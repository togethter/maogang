//
//  WhiteViewController.m
//  maoGang
//
//  Created by xl on 2018/11/28.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "WhiteViewController.h"
#import "CustomAlertView.h"
#import "GXWaterCollectionViewLayout.h"
#import "GXWaterCVCell.h"
#import "CustomAlertView.h"
@interface BlankFontDetailsModel : BaseModel

//BlankFontId    编号    是    [string]    查看
//3     BlankFontTypeId    类型编号    是    [string]    查看
//4     PaperType    纸张（A3=1 A4=2）    是    [string]    查看
//5     WordColour    字格 颜色 （黑色=1 red=2 绿色=3 灰色=4）    是    [string]    查看
//6     SearchCode        是    [string]
//7     IsDefault    是否默认    是    [string]    查看
//8     FilePath    PDF下载路径    是    [string]    查看
//9     PicPath    图片预览地址    是    [string]
@property (nonatomic, copy) NSString *BlankFontId;// 编号
@property (nonatomic, copy) NSString *BlankFontTypeId;// 类型编号 1 方格，2回字格，3田字格，4米子格，5 毛笔回字格，6毛笔方格，7毛笔田字格，毛笔米子格
@property (nonatomic, copy) NSString *PaperType;// 纸张A3=1 A4=2
@property (nonatomic, copy) NSString *WordColour;// 字格颜色(黑色1，红色2，绿色3，绿色4)
@property (nonatomic, copy) NSString *SearchCode;
@property (nonatomic, copy) NSString *IsDefault;// 是否默认
@property (nonatomic, copy) NSString *FilePath;// PDF下下载路径
@property (nonatomic, copy) NSString *PicPath;// 图片预览路径
@end
@implementation BlankFontDetailsModel
@end


@interface WhiteViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *PicImageView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *paperArray;
/** 默认的字体*/
@property (nonatomic, strong) BlankFontDetailsModel *defaultModel;

@end

@implementation WhiteViewController

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (void)setDefaultModel:(BlankFontDetailsModel *)defaultModel {
    if (!defaultModel || _defaultModel == defaultModel) return;
    _defaultModel = defaultModel;
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:defaultModel.PicPath]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.PicImageView.image = image;
            [SVProgressHUD dismiss];
        });
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    iPhoneXR||iPhoneXM||iPhoneX?(self.bottomMargin.constant = 20):0;
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"导出" style:UIBarButtonItemStyleDone target:self action:@selector(daoChuAction:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"预览";
    self.PicImageView.contentMode =  UIViewContentModeScaleAspectFit;
    self.paperArray = [NSMutableArray array];
    [self network];
    
}

- (void)network {
    
    if (!IS_VALID_STRING(self.blankFontTypeId)) {
        [AlertPool alertMessage:@"blankFontTypeId为空" xlViewController:self WithBlcok:nil];
        return;
    }
    
    [self netWorkHelperWithPOST:BlankFontDetails parameters:@{@"blankFontTypeId":self.blankFontTypeId} success:^(id responseObject) {
        BaseModel *model = [BaseModel loadModelWithDictionary:responseObject];
        if ([model.Result isEqualToString:@"200"]) {
            NSArray *array = responseObject[@"Info"];
            for (NSDictionary *licDic in array) {
                BlankFontDetailsModel *detailModel = [BlankFontDetailsModel loadModelWithDictionary:licDic];
                if (![self.paperArray containsObject:detailModel.PaperType]) {
                    [self.paperArray addObject:detailModel.PaperType];
                }
                if ([detailModel.IsDefault isEqualToString:@"1"]) {// 如果是1的话 显示该模型的
                    // 子线程请求数据
                    self.defaultModel = detailModel;
                   
                }
            
                [self.listArray addObject:detailModel];
            }
           
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)senderAction:(UIButton *)sender {
    if (!self.defaultModel)   return;// 不存在的返回
    __weak typeof(self)weakSelf = self;
    if (sender.tag == 100) {
        ColorAlertView *colorAlert = [[ColorAlertView alloc] init];
        colorAlert.colorIndex = self.defaultModel.WordColour.intValue + 100 - 1;// 颜色下表 1 2 3 4
        colorAlert.colorBlock = ^(NSNumber *WordColour) {
            NSString *xlWordColour = @(WordColour.integerValue + 1 - 100).stringValue;// 颜色 下表
            [weakSelf.listArray enumerateObjectsUsingBlock:^(BlankFontDetailsModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {// 周到了
                if ([obj.PaperType isEqualToString:self.defaultModel.PaperType] && [obj.WordColour isEqualToString:xlWordColour]) {// 找到了
                    self.defaultModel = obj;
                    *stop = YES;
                }
            }];
        };
        [colorAlert customAlertShow];
    }
    if (sender.tag == 101) {
        [[[CustomSize customSizeAlertPool].index(self.defaultModel.PaperType.intValue - 1).paper(self.paperArray) selectIndex:^(NSString *a3orA4) {
            NSString *papaer = [a3orA4 isEqualToString:@"A3"]?@"1":@"2";//
            NSInteger xlWordColour =    weakSelf.defaultModel.WordColour.intValue;
            NSString *strColor = @(xlWordColour).stringValue;
            [weakSelf.listArray enumerateObjectsUsingBlock:^(BlankFontDetailsModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.PaperType isEqualToString:papaer] && [obj.WordColour isEqualToString:strColor]) {// 周到了
                    weakSelf.defaultModel = obj;
                    *stop = YES;
                }
            }];
        }] alertShow];
        
    }
}
- (void)daoChuAction:(UIBarButtonItem *)right  {
    if (!self.defaultModel)   return;// 不存在的返回
    __weak typeof(self)weakSelf = self;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"字帖已完成" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"生成下载链接" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [TipCopyAlert centerAlertShowtipAlertisSureBlock:^(BOOL isCopy) {
            if (isCopy) {
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string= weakSelf.defaultModel.FilePath;
            }
        } urlString:self.defaultModel.FilePath];
    }];
   
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action3];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
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
