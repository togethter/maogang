//
//  NotingViewController.m
//  maoGang
//
//  Created by xl on 2018/11/23.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "NotingViewController.h"
#import "NotingCell.h"
#import "WhiteViewController.h"
#import "NotingPenViewController.h"


@interface BlankFontModel : BaseModel
@property (nonatomic, copy) NSString *xId;
@property (nonatomic, copy) NSString *Name;
@end

@implementation BlankFontModel
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"Id"]) {
        [self setValue:value forKey:@"xId"];
    } else {
        [super setValue:value forKey:key];
    }
}
@end
@interface NotingViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollowView;
@property (nonatomic, strong) NSArray *btnArray;

@end

@implementation NotingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 网络请求成功
    [SVProgressHUD show];
    [self netWorkHelperWithPOST:BlankFontBlankFontGrouping parameters:nil success:^(id responseObject) {
            [SVProgressHUD dismiss];
            BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
        
            if ([model.Result isEqualToString:@"200"]) {
                NSArray *arrayInfo = responseObject[@"Info"];
                NSMutableArray *array = @[].mutableCopy;;
                for (NSDictionary *dic in arrayInfo) {
                    BlankFontModel *blankFont = [BlankFontModel loadModelWithDictionary:dic];
                    [array addObject:blankFont];
                }
                // 1.00 创建顶部btn
                self.btn1.tag = 0;
                self.btn2.tag = 1;
                self.btn3.tag = 2;
                self.btnArray = @[_btn1,_btn2,_btn3];
                for (int i = 0; i < self.btnArray.count; i++) {
                    UIButton *btn = _btnArray[i];
                    if (array.count > i) {
                        BlankFontModel *blankFont = array[i];
                        [btn setTitle:blankFont.Name forState:UIControlStateNormal];
                    }
                    btn.layer.cornerRadius = 25.f/2;
                    btn.layer.masksToBounds = YES;
                    btn.layer.borderWidth = 1;
                    btn.tag = 100 + i;
                    [btn setTitleColor:RGBCOLOR(128, 126, 126) forState:UIControlStateNormal];
                    btn.layer.borderColor = RGBCOLOR(128, 126, 126).CGColor;
                    if (i == 0) {
                        btn.layer.borderColor = RGBCOLOR(255, 51, 17).CGColor;
                        [btn setTitleColor:RGBCOLOR(255, 51, 17) forState:UIControlStateNormal];
                    }
                }
                // 2.00 创建空白字帖视图
                NotingPenViewController *notingPen = [[NotingPenViewController alloc] init];
                NotingPenViewController *notingMaoBi = [[NotingPenViewController alloc] init];
                NotingPenViewController *notingOthers = [[NotingPenViewController alloc] init];
                [self addChildViewController:notingPen];
                [self addChildViewController:notingMaoBi];
                [self addChildViewController:notingOthers];
                
                for (int i = 0; i < self.childViewControllers.count; i++) {
                    NotingPenViewController *vc =  self.childViewControllers[i];
                    if (array.count > i) {
                        BlankFontModel *blankFont = array[i];
                        vc.penId = blankFont.xId;
                    }
                    vc.view.frame = CGRectMake(i * CGRectGetWidth(self.contentScrollowView.frame), 0, CGRectGetWidth(self.contentScrollowView.frame), CGRectGetHeight(self.contentScrollowView.frame));
                }
                
                [self.contentScrollowView addSubview:notingPen.view];
                [self.contentScrollowView addSubview:notingMaoBi.view];
                [self.contentScrollowView addSubview:notingOthers.view];
                
                self.contentScrollowView.contentSize = CGSizeMake(self.childViewControllers.count * CGRectGetWidth(self.contentScrollowView.frame), 0);
                self.contentScrollowView.pagingEnabled = YES;
                self.contentScrollowView.showsVerticalScrollIndicator = NO;
                self.contentScrollowView.showsHorizontalScrollIndicator = NO;
                self.contentScrollowView.delegate = self;
            }
            
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)senderSelect:(UIButton *)sender {
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:RGBCOLOR(128, 126, 126) forState:UIControlStateNormal];
        obj.layer.borderColor = RGBCOLOR(128, 126, 126).CGColor;
        if ([sender isEqual:obj]) {
            obj.layer.borderColor = RGBCOLOR(255, 51, 17).CGColor;
            [obj setTitleColor:RGBCOLOR(255, 51, 17) forState:UIControlStateNormal];
        }
    }];
    NSInteger page = sender.tag - 100;
    [self.contentScrollowView setContentOffset:CGPointMake(CGRectGetWidth(self.contentScrollowView.frame) * page, 0) animated:NO];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIButton *btn =  self.btnArray[page];
    [self senderSelect:btn];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
