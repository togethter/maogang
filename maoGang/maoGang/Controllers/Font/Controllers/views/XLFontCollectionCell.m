//
//  XLFontCollectionCell.m
//  maoGang
//
//  Created by xl on 2018/12/21.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "XLFontCollectionCell.h"
#import "UIFont+FY_Fonty.h"
#import "UIImage+Extension.h"
@implementation XLFontCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textTitle = [UILabel new];
        [self.contentView addSubview:self.imageView];
        [self.imageView addSubview:self.textTitle];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        [self.textTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.imageView);
        }];
        self.contentView.layer.borderWidth = 0.5;
    }
    return self;
}
// look NO 外部的
- (CGFloat)fontSetWithIndex:(NSInteger)index isLook:(BOOL)look{
    NSInteger lieShu = [self getGangBiisWaiBu:look];
    CGFloat leftRightMargin = 0;
    CGFloat lineMargin = 0;
    if (look) {// 内部
        leftRightMargin = 20 + 20 + 20 + 20;
        lineMargin = 0;
    } else {// 外部
        leftRightMargin = 40;
        lineMargin = 10;
    }
    CGFloat singWidth = (kScreenWidth - leftRightMargin - (lieShu -1)* lineMargin)/(lieShu*1.0);
    // 图片的宽高都知道了
    switch (index) {
        case 0:// 小
        {
            self.textTitle.font = [UIFont fy_mainFontWithSize:singWidth * 0.5];//
        }
            break;
        case 1:// 中
        {
            self.textTitle.font = [UIFont fy_mainFontWithSize:singWidth * 0.6];//
        }
            break;
        case 2:// 大
        {
            self.textTitle.font =  [UIFont fy_mainFontWithSize:singWidth * 0.8];//
        }
            break;
        default:
            break;
    }
    return singWidth;
}

- (NSInteger)getGangBiisWaiBu:(BOOL)isWaibu{
    if (isWaibu == NO) {
        return 5;
    } else {
        return 12;
    }
    return 4;
}
- (NSInteger)getLisShu:(BOOL)isA3 isFontSize:(NSInteger)fontSize {
    if (isA3) {
        
        switch (fontSize) {
            case 0:
                return 10;
                break;
            case 1:
                return 8;

                break;
            case 2:
                return 5;
                break;
            default:
                break;
        }
        
        return 4;
    }
    
    switch (fontSize) {
        case 0:
            return 4;

            break;
        case 1:
            return 3;

            break;
        case 2:
            return 2;

            break;
        default:
            break;
    }
    
    
    
    return 4;
}

- (CGFloat)maoBiFitIndex {
    BOOL isA3 = YES;
    NSInteger fontSize = self.alertModel.fontSizeIndex - 100;
    if ([self.alertModel.a3orA4 isEqualToString:@"A3"]) {
        isA3 = YES;
    } else if ([self.alertModel.a3orA4 isEqualToString:@"A4"]) {
        isA3 = NO;
    }
   NSInteger lieShu = [self getLisShu:isA3 isFontSize:fontSize];
   NSInteger margin  = 20 + 20 + 20 + 20;
    
   CGFloat singWidth = (kScreenWidth - margin) / (lieShu  * 1.0);
    switch (fontSize) {
        case 0:// 小
        {
            
            self.textTitle.font = [UIFont fy_mainFontWithSize:singWidth * 0.5];//
        }
            break;
        case 1:// 中
        {
            self.textTitle.font = [UIFont fy_mainFontWithSize:singWidth *0.6];//
        }
            break;
        case 2:// 大
        {
            self.textTitle.font =  [UIFont fy_mainFontWithSize:singWidth * 0.8];//
        }
            break;
        default:
            break;
    }
    return singWidth;
}

- (UIImage *)imageWithImage:(UIImage *)ximage widthHeight:(CGFloat)widthHeight{
    if (!ximage) {
        return nil;
    }
    UIImage *image2 =   ximage;
    UIGraphicsBeginImageContext(CGSizeMake(widthHeight,widthHeight));
    //    画1
    //     画2
    [image2 drawInRect:CGRectMake(0,0,widthHeight,widthHeight)];
    //根据图形上下文拿到图片
    UIImage*image =UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
    
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
//    self.imageView.image = [UIImage resizedImage:photoImage];
    
//    self.imageView.image = [UIImage imageNamed:photoImage];
    UIImage *xxx = [UIImage imageNamed:photoImage];
    UIColor *color = nil;
    switch (self.alertModel.colorIndex.intValue -100) {
        case 0:
            color = [UIColor blackColor];
            break;
        case 1:
            color = RGBCOLOR(254, 59, 44);
            break;
        case 2:
            color = RGBCOLOR(35, 203, 2);
            break;
        case 3:
            color = RGBCOLOR(201, 201, 201);
            break;
        default:
            break;
    }
    self.contentView.layer.borderColor = color.CGColor;
    if (!IS_VALID_STRING(photoImage)) {
        self.contentView.layer.borderColor = nil;
        self.contentView.layer.borderWidth = 0;
    } else {
        self.contentView.layer.borderWidth = 0.5;
    }
    //    //4 配置文字
    if (self.array == nil) {// 单个分区
        //2 字体
        //2.1 获取到下表
        NSInteger index = alertModel.fontSizeIndex - 100;
        CGFloat width =  [self fontSetWithIndex:index isLook:NO];
        UIImage *pppp =  [xxx imageByScalingAndCroppingForSize:CGSizeMake(width, width)];
        self.imageView.image = pppp;
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
        CGFloat adition = 0.8;
        if ((iPhoneX||iPhoneXM||iPhoneXR) && [alertModel.maoGangType.stringValue isEqualToString:@"1"]) {// 钢笔
            adition = 0.9;
        }
        if ([self.alertModel.maoGangType.stringValue isEqualToString:@"2"]) {// 毛笔
            CGFloat width = [self maoBiFitIndex];
            UIImage *pppp =  [self imageWithImage:xxx widthHeight:width];
            self.imageView.image = pppp;
        } else {
           CGFloat width =   [self fontSetWithIndex:index isLook:YES];//钢笔
            UIImage *pppp =  [xxx imageByScalingAndCroppingForSize:CGSizeMake(width, width)];
             self.imageView.image = pppp;
        }
        
        self.textTitle.text = singTxt;
    }
    
}

@end
