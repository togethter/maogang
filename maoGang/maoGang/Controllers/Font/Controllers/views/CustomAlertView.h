//
//  GroupView.h
//  maoGang
//
//  Created by xl on 2018/11/26.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat alertViewHeight;

@interface CustomAlertView : UIView
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, assign) BOOL touchBlackDismiss;
@property (nonatomic, strong) UIView *blackView;

- (void)customAlertShow;// 子类调用展示
- (void)animationViewShow;// 子类实现
- (void)placeHolderView;
- (void)layoutPlaceViews;
@end


@interface AlpheraAlertView : CustomAlertView
@property (nonatomic, copy) void(^alphaBlock)(CGFloat alpha);
@property (nonatomic, assign) CGFloat percent;

@end

@interface TiziGeAlertView : CustomAlertView
@property (nonatomic, copy) void(^tiziGeBlock)(id);
@property (nonatomic, assign) NSInteger Indextizi;
@end

@interface FontAlertView : CustomAlertView
@property (nonatomic, copy) void(^fontBlock)(NSInteger alpha);
@property (nonatomic, assign) NSInteger fontIndex;
@end

@interface ColorAlertView : CustomAlertView
@property (nonatomic, copy) void(^colorBlock)(id);
@property (nonatomic, assign) NSInteger colorIndex;
@end

@interface CustomAlertModel : NSObject
@property (nonatomic, assign) CGFloat percent;// 百分比
@property (nonatomic, strong) NSNumber *colorIndex;// 颜色下表 线框颜色下表
@property (nonatomic, strong) NSNumber *tiziGeIndex;// 田字格下表
@property (nonatomic, assign) NSInteger fontSizeIndex;// 字体下表
@property (nonatomic, copy) NSString *a3orA4;// 纸张大小 1A3 2A4
@property (nonatomic, strong) NSArray *colorNameArray;//线框颜色
@property (nonatomic, copy) NSNumber *fontType;// 字体的类型 
@property (nonatomic, copy) NSString *txt;// 文字
@property (nonatomic, strong) NSNumber *order;// 文字排序
@property (nonatomic, strong) NSNumber *maoGangType;// 钢笔的类型
@property (nonatomic, strong) NSArray *fontTypeArray;// 字体的类型
@property (nonatomic, strong) NSDictionary *alphaDic;// 透明度
@property (nonatomic, strong) NSArray *geziColorArray;
@property (nonatomic, copy) NSString *TypefaceId;// 字体的编号
@property (nonatomic, copy) NSString *shiciId;// 诗词id
@property (nonatomic, copy) NSString *contentId;// 内容的id

// 1线框颜色的16进制, ;2字颜色的的16进制，;3线框样式的类型下表从（1开始..)，;4字号下表（从1开始...） 5纸张的类型A3,A4;6 字体的类型中文编码，7，横竖排（1左右，2上下）;8文字；9笔类（1=钢笔 2=毛笔）
- (NSDictionary *)parm;

/*
 if(type === '1'){//钢笔只有a4纸型
 textNumber = 216
 hang = 18
 lie = 12
 
 }else {
 switch (paperType) {
 case 'A4':
 if(fontSize === '1'){//小
 textNumber = 24
 hang = 6
 lie = 4
 }else if(fontSize === '2'){//中
 textNumber = 12
 hang = 4
 lie = 3
 }else {//大
 textNumber = 6
 hang = 3
 lie = 2
 }
 break
 case 'A3':
 if(fontSize === '1'){//小
 textNumber = 70
 hang = 7
 lie = 10
 }else if(fontSize === '2'){//中
 textNumber = 40
 hang = 5
 lie = 8
 }else {//大
 textNumber = 15
 hang = 3
 lie = 5
 }
 }***/
@end



@interface CustomAlertPool : CustomAlertView

// 第几个下表
@property (nonatomic, assign) NSInteger tagesNumber;

+ (instancetype)customAlertPool;
- (CustomAlertPool *(^)(NSInteger tagesNumber))tagNumber;
- (CustomAlertPool *(^)(CGFloat percent))percent;
- (CustomAlertPool *(^)(NSInteger indeXColor))color;
- (CustomAlertPool *(^)(NSInteger indeXTiziGe))tiziGe;
- (CustomAlertPool *(^)(NSInteger indeXFont))fontSize;
- (CustomAlertPool *)color:(void(^)(id))colorBlock;
- (CustomAlertPool *)tiziGe:(void(^)(id))tiziGeBlock;
- (CustomAlertPool *)font:(void(^)(NSInteger font))fontBlock;
- (CustomAlertPool *)alpha:(void(^)(CGFloat alpha))alphaBlock;
- (CustomAlertPool *)alertShow;
@end


@interface CustomSize : CustomAlertView

+ (instancetype)customSizeAlertPool;
- (CustomSize *(^)(NSArray *paperArray))paper;
- (CustomSize *(^)(NSInteger index))index;
- (CustomSize *)selectIndex:(void(^)(NSString *A3orA4))selectSizeBlock;
- (CustomSize *)alertShow;
@end


@interface TipAlert : CustomAlertView


+ (void)centerAlertShowtipAlertisSureBlock:(void(^)(BOOL isSure))sureBlock;

@end

@interface TipCopyAlert : CustomAlertView
@property (nonatomic, copy) NSString *urlString;
+ (void)centerAlertShowtipAlertisSureBlock:(void(^)(BOOL isCopy))sureBlock urlString:(NSString *)urlString;




@end


@interface WordsSet : CustomAlertView

/**
 字帖预览中国是否自动填满空白字格|自动清除标点符号
 
 @param autoFillWords 填满空白字格
 @param clearPunctuation 清除标点符号
 @param setBlock 设置清除填满空格的block
 */
+ (void)congigureLookFontsSetBlockFillWords:(BOOL)autoFillWords autoClearPunctuation:(BOOL)clearPunctuation setBlock:(void(^)(BOOL autoFillWords,BOOL autoClearPunctuation))setBlock;
@end
