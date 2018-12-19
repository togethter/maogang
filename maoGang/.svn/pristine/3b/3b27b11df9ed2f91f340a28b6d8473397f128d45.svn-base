//
//  MaogangDictionaryViewController.m
//  maoGang
//
//  Created by xl on 2018/11/28.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "MaogangDictionaryViewController.h"
#import "YLScorlControl.h"
#import "SingleDicViewController.h"
#import "PoetrysModel.h"
@interface MaogangDictionaryViewController ()
@property (weak, nonatomic) IBOutlet UIView *TLView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation MaogangDictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"毛钢词典";
    self.TLView.layer.cornerRadius = 3;
    self.TLView.layer.masksToBounds = YES;
    self.TLView.backgroundColor = BACKCOLOR;
   
    YLScorlControl *control = [[YLScorlControl alloc] init];
    const CGFloat midMargin = 20;
    control.midMargin = midMargin;
    control.contentView = self.contentView;
    [self.contentView addSubview:control];
    
    [self netWorkHelperWithPOST:BasicsPoetrysTypes parameters:@{} success:^(id responseObject) {
        BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
        if ([model.Result isEqualToString:@"200"]) {
            NSArray *InfoArray = responseObject[@"Info"];
            if (InfoArray.count <6) {
                control.titleScrolEnabled = NO;
            } else {
                control.titleScrolEnabled = YES;
            }
            for (NSDictionary *dic in InfoArray) {
                PoetrysModel *poetryModel = [PoetrysModel loadModelWithDictionary:dic];
                SingleDicViewController *vc = [[SingleDicViewController alloc] init];
                vc.poetryModel = poetryModel;
                [control addChildViewController:vc title:poetryModel.PoetrysTypeName];
            }
            [control show];
        }
    } failure:^(NSError *error) {
        
    }];
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
