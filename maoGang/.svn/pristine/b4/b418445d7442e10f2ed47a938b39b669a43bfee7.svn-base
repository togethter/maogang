//
//  GXWaterCVCell.m
//  GXUICollectionView
//
//  Created by GuoShengyong on 2017/12/11.
//  Copyright © 2017年 cong. All rights reserved.
//

#import "GXWaterCVCell.h"
#import "Fonty.h"
@implementation GXWaterCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)fontSetWithIndex:(NSInteger)index rare:(CGFloat)rare isLook:(BOOL)look{
    NSInteger addadition = 0;
    if (look) {
        if (IPHONE5HEIGHT) {
            addadition = -1;
        }
    }
    switch (index) {
            case 0:// 小
        {
            self.textTitle.font = [UIFont fy_mainFontWithSize:18 *rare + addadition];//
        }
            break;
            case 1:// 中
        {
            self.textTitle.font = [UIFont fy_mainFontWithSize:19 *rare +addadition];//
        }
            break;
            case 2:// 大
        {
            self.textTitle.font =  [UIFont fy_mainFontWithSize:22 *rare + 2 * addadition];//
        }
            break;
        default:
            break;
    }
    
}
- (void)setAlertModel:(CustomAlertModel *)alertModel {
    _alertModel = alertModel;
    //1 字体的颜色
    self.textTitle.textColor = [UIColor colorWithHexString:alertModel.alphaDic[[NSString stringWithFormat:@"%.2f",alertModel.percent]]];
    
    
    //3 图片的颜色
    NSArray *geziColorArray = alertModel.geziColorArray;
    NSDictionary *dic = geziColorArray[alertModel.tiziGeIndex.integerValue -100];
    NSInteger colorindex = alertModel.colorIndex.integerValue;
    colorindex = colorindex - 100;
    NSString *photoImage = dic[@(colorindex).stringValue];
    self.imageView.image = [UIImage imageNamed:photoImage];
//    //4 配置文字
    if (self.array == nil) {// 单个分区
        //2 字体
        //2.1 获取到下表
        NSInteger index = alertModel.fontSizeIndex - 100;
        [self fontSetWithIndex:index rare:1 isLook:NO];
        // 对字体大小的适配
        if (alertModel.txt.length > self.indexPath.row) {
            NSString *jjj = [alertModel.txt substringWithRange:NSMakeRange(self.indexPath.row, 1)];
            self.textTitle.text = jjj;
        } else {
            self.textTitle.text = @"";
        }
    } else {// 多个分区
        NSString *singTxt = @"";
        if (self.array.count > self.indexPath.section) {
            NSString *txt = self.array[self.indexPath.section];
            if (txt.length > self.indexPath.row) {
               singTxt  = [txt substringWithRange:NSMakeRange(self.indexPath.row, 1)];
            }
        }
        NSInteger index = alertModel.fontSizeIndex - 100;
        CGFloat adition = 1.1;
        if ((iPhoneX||iPhoneXM||iPhoneXR) && [alertModel.maoGangType.stringValue isEqualToString:@"1"]) {// 钢笔
            adition = 0.9;
        }
    
        [self fontSetWithIndex:index rare:adition isLook:YES];
        self.textTitle.text = singTxt;
    }
    
}





@end
