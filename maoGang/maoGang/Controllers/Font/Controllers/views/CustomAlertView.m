//
//  GroupView.m
//  maoGang
//
//  Created by xl on 2018/11/26.
//  Copyright © 2018年 bilin. All rights reserved.
//
CGFloat const alertViewHeight = 150.f;
#import "CustomAlertView.h"
@protocol ColorViewProtocol <NSObject>

- (void)colorViewSelect:(NSInteger)tag;

@end
@interface ColorView : UIView
// 是否选择
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) UIColor *xcolor;
@property (nonatomic, weak) id<ColorViewProtocol> delegate;

@end

@interface ColorView ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *colorView;


@end
@implementation ColorView

- (void)setXcolor:(UIColor *)xcolor {
    _xcolor = xcolor;
    self.colorView.backgroundColor = xcolor;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *midView = [UIView new];
        self.colorView = [UIView new];
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:[UIImage imageNamed:@"btn_xuanzhong_a"] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.selectBtn = selectBtn;
        [self addSubview:midView];
        [self addSubview:self.colorView];
        [self addSubview:selectBtn];
        
        [midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(15);
            make.center.mas_equalTo(self);
        }];
        
        [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(15);
            make.centerX.mas_equalTo(midView.mas_centerX);
            make.bottom.mas_equalTo(midView.mas_top);
        }];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(midView.mas_bottom);
            make.centerX.mas_equalTo(midView.mas_centerX);
        }];
    }
    return self;
}

- (void)btnClickAction:(UIButton *)btn {
    self.isSelect = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colorViewSelect:)]) {
        [self.delegate colorViewSelect:self.tag];
    }
    [self.selectBtn setImage:[UIImage imageNamed:@"btn_xuanzhong_b"] forState:UIControlStateNormal];// 选中
}

- (void)setIsSelect:(BOOL)isSelect {
    if (_isSelect == isSelect) return;
    _isSelect = isSelect;
    if (_isSelect == NO) {// 取消选中
        [self.selectBtn setImage:[UIImage imageNamed:@"btn_xuanzhong_a"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setImage:[UIImage imageNamed:@"btn_xuanzhong_b"] forState:UIControlStateNormal];// 选中
    }
    
}

@end
@interface CustomAlertView ()
@end
@implementation CustomAlertView
- (void)dealloc {
    DLog(@"%@ - Dealloc",NSStringFromClass(self.class));
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.touchBlackDismiss = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self placeHolderView];
        [self layoutPlaceViews];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.touchBlackDismiss = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self placeHolderView];
        [self layoutPlaceViews];
    }
    return self;
}
+ (instancetype)customAlertView {
    CustomAlertView *alertView = [[[self class] alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    return alertView;
}
- (void)placeHolderView {
    
}
- (void)layoutPlaceViews
{
    self.titleLb.font = [UIFont systemFontOfSize:15];
    self.titleLb.textColor = RGBCOLOR(22, 22, 22);
}
- (void)animationViewShow {
    
}
- (void)tapGes:(UITapGestureRecognizer *)tapGes {
    [self customDismiss];
}
- (void)customDismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.mj_y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self.blackView removeFromSuperview];
    }];
}
- (void)customAlertShow {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.blackView = [[UIView alloc] init];
    self.blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    if (self.touchBlackDismiss) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
        [self.blackView addGestureRecognizer:tapGes];
    }
    [window addSubview:self.blackView];
    self.blackView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- ((iPhoneXM||iPhoneXR||iPhoneX)?20:0));
    self.mj_y = kScreenHeight;
    [window addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        [self animationViewShow];
    }];
}
@end

@interface AlpheraAlertView ()
@property (nonatomic, strong) UISlider *slider;

@end
@implementation AlpheraAlertView


- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    self.slider.value = percent;
    self.titleLb.text = [NSString stringWithFormat:@"字体透明度:%.2f%%",percent * 100];
}
- (void)sliderAction:(UISlider *)slider
{
    // 检车滑动的范围
    //    0.2---0.4
    //    0.4---0.6
    //    0.6---0.8
    //    0.8----1
    
    bool isok = YES;
    NSMutableArray *array = [NSMutableArray array];
    CGFloat flotIndex = 0.2;
    CGFloat const xflindex = 0.2;
    while (isok) {
        NSDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@(flotIndex) forKey:@"start"];
        [dic setValue:@(flotIndex += xflindex) forKey:@"end"];
        [array addObject:dic];
        if (flotIndex == 1) {
            isok = NO;
        }
    }
    [array enumerateObjectsUsingBlock:^(NSDictionary  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        CGFloat start = [dic[@"start"] floatValue];
        CGFloat end   = [dic[@"end"] floatValue];
        if (slider.value < end && slider.value > start) {// 在范围内
            // 看距离谁近值就是谁
            CGFloat currentValue = (slider.value - start) > (end - slider.value) ? end:start;
            slider.value = currentValue;
            if (self.alphaBlock) {
                self.alphaBlock(currentValue);
            }
            *stop = YES;
        }else if (((slider.value == start) && slider.value != 0) || slider.value == end) {
            if (self.alphaBlock) {
                self.alphaBlock(slider.value);
            }
            *stop = YES;
        } else if (slider.value < 0.2) {
            slider.value = 0.2;
            if (self.alphaBlock) {
                self.alphaBlock(slider.value);
            }
            *stop = YES;
        }
    }];
    
    self.titleLb.text = [NSString stringWithFormat:@"字体透明度:%.2f%%",slider.value * 100];
}
- (void)placeHolderView {
    self.titleLb = [UILabel new];// 创建描述
    self.titleLb.text = @"字体透明度";
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];// 创建滑动控件
    slider.minimumValue = 0.2;
    slider.maximumValue = 1;
    slider.continuous = NO;
    self.slider = slider;
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.titleLb];
    [self addSubview:slider];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(15);
        make.width.mas_equalTo(kScreenWidth - 70);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(25);
    }];
}

@end
@interface TiziGeAlertView ()
@property (nonatomic, strong) NSMutableArray *tiziGeArray;

@end


@implementation TiziGeAlertView

- (void)setIndextizi:(NSInteger)Indextizi {
    if (Indextizi >= 100 == NO) return;
    _Indextizi = Indextizi;
    UIButton *sender = self.tiziGeArray[Indextizi - 100];
    [self buttonCongigureWithSender:sender];
}
- (NSMutableArray *)tiziGeArray {
    if (!_tiziGeArray) {
        _tiziGeArray = [NSMutableArray array];
    }
    return _tiziGeArray;
}

- (void)placeHolderView {
    self.titleLb = [UILabel new];
    self.titleLb.text = @"请选择线框样式";
    [self addSubview:self.titleLb];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    NSArray *array = @[@"bian_yangshi_5_a",@"bian_yangshi_4_a",@"bian_yangshi_3_a",@"bian_yangshi_2_a",@"bian_yangshi_1_a"];
    UIImage *image = [UIImage imageNamed:@"bian_yangshi_5_a"];
    CGFloat imageWidth = image.size.width;// imageWith宽和高
    CGFloat fenGeWidth = (kScreenWidth - 5 * imageWidth) / 6;// 间距
    for (int i = 0; i < array.count; i++) {
        UIButton *imageview = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageview setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [imageview addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        imageview.tag = 100 + i;
        imageview.mj_x =  (i+1) *fenGeWidth + i * imageWidth;
        imageview.mj_w = imageWidth;
        imageview.mj_h = imageWidth;
        imageview.mj_y = 70;
        imageview.tag = 100 + i;
        [self.tiziGeArray addObject:imageview];
        [self addSubview:imageview];
    }
    //    self.backgroundColor = [UIColor redColor];
    
}

- (void)buttonClick:(UIButton *)sender {
    //    if (self.tiziGeBlock) {
    //        self.tiziGeBlock(@(sender.tag));
    //    }
    [self buttonCongigureWithSender:sender];
}

- (void)buttonCongigureWithSender:(UIButton *)sender
{
    NSArray *array = @[@"bian_yangshi_5_a",@"bian_yangshi_4_a",@"bian_yangshi_3_a",@"bian_yangshi_2_a",@"bian_yangshi_1_a"];
    NSArray *selet = @[@"bian_yangshi_5_b",@"bian_yangshi_4_b",@"bian_yangshi_3_b",@"bian_yangshi_2_b",@"bian_yangshi_1_b"];
    [self.tiziGeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *sxender = obj;
        if ([sender isEqual:sxender]) {// 颜色变化
            if (self.tiziGeBlock) {
                self.tiziGeBlock(@(idx + 100));
            }
            [sxender setImage:[UIImage imageNamed:selet[idx]] forState:UIControlStateNormal];
        } else {// 颜色变化
            [sxender setImage:[UIImage imageNamed:array[idx]] forState:UIControlStateNormal];
        }
    }];
}

@end
@interface FontAlertView ()
@property (nonatomic, strong) NSMutableArray *fontArray;

@end
@implementation FontAlertView

- (void)setFontIndex:(NSInteger)fontIndex {
    _fontIndex = fontIndex;
    if (fontIndex >=100 == NO) return;
    UIButton *sender = self.fontArray[fontIndex - 100];
    [self fontConfigurateWithSende:sender];
    
}
- (NSMutableArray *)fontArray {
    if (!_fontArray) {
        _fontArray = [NSMutableArray array];
    }
    return _fontArray;
}
- (void)placeHolderView {
    self.titleLb = [UILabel new];
    self.titleLb.text = @"设置字体大小";
    
    [self addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    NSArray *array = @[@"小",@"中",@"大"];
    CGFloat imageWidth =  60;// imageWith宽和高
    CGFloat imageHeight = 34;
    NSInteger countAll = array.count;
    CGFloat fenGeWidth = (kScreenWidth - countAll * imageWidth) / (countAll + 1);// 间距
    for (int i = 0; i < array.count; i++) {
        UIButton *imageview = [UIButton buttonWithType:UIButtonTypeSystem];
        [imageview setTitle:array[i] forState:UIControlStateNormal];
        imageview.titleLabel.font = [UIFont systemFontOfSize:15];
        [imageview setTitleColor:RGBCOLOR(36, 36, 36) forState:UIControlStateNormal];
        [imageview addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        imageview.layer.cornerRadius =  imageHeight / 2.0f;
        imageview.layer.masksToBounds = YES;
        [imageview setBackgroundImage:[UIImage createImageWithColor:RGBCOLOR(247, 247, 247)] forState:UIControlStateNormal];
        imageview.mj_x =  (i+1) *fenGeWidth + i * imageWidth;
        imageview.mj_w = imageWidth;
        imageview.mj_h = imageHeight;
        imageview.mj_y = 70;
        imageview.tag = 100 + i;
        [self.fontArray addObject:imageview];
        [self addSubview:imageview];
    }
}



- (void)fontConfigurateWithSende:(UIButton *)sender
{
    [self.fontArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *custom = obj;
        if ([sender isEqual:custom]) {
            custom.layer.borderWidth = 1;
            custom.layer.borderColor =  RGBCOLOR(244, 24, 24).CGColor;
            [custom setTitleColor:RGBCOLOR(224, 24, 24) forState:UIControlStateNormal];
            [custom setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        } else {
            custom.layer.borderWidth = 0;
            custom.layer.borderColor = nil;
            [custom setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [custom setBackgroundImage:[UIImage createImageWithColor:RGBCOLOR(247, 247, 247)] forState:UIControlStateNormal];
        }
    }];
}
- (void)btnClickAction:(UIButton *)sender
{
    if (self.fontBlock) {
        self.fontBlock(sender.tag);
    }
    [self fontConfigurateWithSende:sender];
}

@end

@interface ColorAlertView ()<ColorViewProtocol>
@property (nonatomic, strong) NSMutableArray *colorArray;



@end
@implementation ColorAlertView


- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}
- (void)setColorIndex:(NSInteger)colorIndex {
    if (colorIndex >= 100 == NO) return;
    _colorIndex = colorIndex;
    [self buttonConfigurateWithSender:colorIndex];
}

#pragma mark -ColorViewProtocol
- (void)colorViewSelect:(NSInteger)tag {
    //    if (self.colorBlock) {
    //        self.colorBlock(@(tag));
    //    }
    [self buttonConfigurateWithSender:tag];
}
- (void)buttonConfigurateWithSender:(NSInteger )tag
{
    [self.colorArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ColorView *colorView = obj;
        if (colorView.tag == tag) {
            colorView.isSelect = YES;
            if (self.colorBlock) {
                self.colorBlock(@(idx + 100));
            }
        } else {
            colorView.isSelect = NO;
        }
    }];
}
- (void)animationViewShow {
    self.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
}

- (void)placeHolderView {
    self.titleLb = [UILabel new];
    self.titleLb.text = @"请选择线框颜色";
    [self addSubview:self.titleLb];// 添加文字描述
    self.mj_w = kScreenWidth;
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(20);
    }];
    
    NSArray *array = @[[UIColor blackColor],[UIColor redColor],[UIColor greenColor],[UIColor darkGrayColor]];
    CGFloat imageWidth =  60;// imageWith宽和高
    CGFloat imageHeight = 60;
    CGFloat fenGeWidth = (kScreenWidth - 4 * imageWidth) / 2;// 间距
    for (int i = 0; i < array.count; i++) {
        ColorView *imageview = [[ColorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imageview.xcolor = array[i];
        imageview.delegate = self;
        imageview.mj_x =  fenGeWidth + i * imageWidth;
        imageview.mj_w = imageWidth;
        imageview.mj_h = imageHeight;
        imageview.mj_y = 70;
        imageview.tag = 100 + i;
        [self.colorArray addObject:imageview];
        [self addSubview:imageview];
    }
    
}


@end
#import "FontModel.h"
@implementation CustomAlertModel




- (NSDictionary *)parm {
    NSInteger colorIndex = self.colorIndex.integerValue -100;// 田字格线框颜色
    NSInteger backgroundView = self.tiziGeIndex.intValue - 100;// 田字格类型
    NSInteger fontsizeIndex =  self.fontSizeIndex - 100;//
    NSString *fontSizeStr = [NSString stringWithFormat:@"%ld",(long)fontsizeIndex + 1];// 字体大小1
    NSString *alpha = [NSString stringWithFormat:@"%.0f",self.percent * 100];
    NSString *tianziGeYanSe = [NSString stringWithFormat:@"%ld",colorIndex + 1];// 3田字格线框颜色
    NSString *tianziGeLeixing = [NSString stringWithFormat:@"%ld",(long)backgroundView + 1];// 田字格类型4
    NSString *pape = [NSString stringWithFormat:@"%@",self.a3orA4];// 纸张类型 5
    NSString *papeIndex = @"";
    if ([pape isEqualToString:@"A3"]) {
        papeIndex = @"1";
    } else if ([pape isEqualToString:@"A4"]) {
        papeIndex = @"2";
    }
    FontModel *fontModel = self.fontTypeArray[self.fontType.integerValue];
    NSString *fontType = [NSString stringWithFormat:@"%@",fontModel.TypefaceId];// 7 字体类型 xl编码
    return @{@"typefaceId":fontType,// 字体编号!!!
             @"wordLattice":tianziGeLeixing,// 字格!!
             @"WordColour":tianziGeYanSe,//字格颜色!!!
             @"Transparency":alpha,//透明度!!
             @"FontSize":fontSizeStr,// 字号!!!
             @"PaperType":papeIndex,//纸张
             @"poetryId":(IS_VALID_STRING(self.shiciId)?self.shiciId:@"0"),//诗词
             @"poetryContentId":(IS_VALID_STRING(self.contentId)?self.contentId:@"0"),// 内容的id
             @"Typesetting":self.order.stringValue// 横竖排
             };
}

- (NSArray *)colorNameArray {
    if (!_colorNameArray) {
        _colorNameArray = [NSMutableArray arrayWithObjects:@"black",@"red",@"green",@"gray", nil];
    }
    return _colorNameArray;
}

- (NSArray *)geziColorArray
{
    if (!_geziColorArray) {
        _geziColorArray =  @[@{@"0": @"",
                               @"1":@"",
                               @"2":@"",
                               @"3":@""
                               },
                             @{@"0": @"gezi_huizige_b_2",
                               @"1":@"gezi_huizige_a_2",
                               @"2":@"gezi_huizige_c_2",
                               @"3":@"gezi_huizige_d_2"
                               },
                             @{@"0": @"gezi_fangge_b_2",
                               @"1":@"gezi_fangge_a_2",
                               @"2":@"gezi_fangge_c_2",
                               @"3":@"gezi_fangge_d_2"
                               },
                             @{@"0": @"gezi_tianzige_b_2",
                               @"1":@"gezi_tianzige_a_2",
                               @"2":@"gezi_tianzige_c_2",
                               @"3":@"gezi_tianzige_d_2"
                               },
                             @{@"0": @"gezi_mizige_b_2",
                               @"1":@"gezi_mizige_a_2",
                               @"2":@"gezi_mizige_c_2",
                               @"3":@"gezi_mizige_d_2"
                               }
                             ];
    }
    return  _geziColorArray;
}
- (NSDictionary *)alphaDic {
    if (!_alphaDic) {
        _alphaDic = @{
                      @"1.00":@"#606060",
                      @"0.80":@"#9d9d9d",
                      @"0.60":@"#c2c2c2",
                      @"0.40":@"#e3e3e3",
                      @"0.20":@"#f1f1f1"
                      };
        
    }
    return _alphaDic;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"percent =%.2f\n  \
            线框颜色下表colorIndex=%@\n       \
            田字格下表tiziGeIndex=%@\n   \
            字体大小下表fontSizeIndex=%ld\n \
            纸张大小papersizeIndex=%@\n \
            线框颜色colorNameArray=%@\n \
            字体的类型fontType=%@\n \
            文字txt=%@\n \
            文字排序order=%@",
            self.percent,
            self.colorIndex,
            self.tiziGeIndex,
            (long)self.fontSizeIndex,
            self.a3orA4,
            self.colorNameArray,
            self.fontType,
            self.txt,
            self.order];
}

@end
@interface CustomAlertPool ()
@property (nonatomic, strong) NSMutableArray *bttons;
@property (nonatomic, strong) AlpheraAlertView *alpheraAlert;
@property (nonatomic, strong) TiziGeAlertView *tiziGeAlertView;
@property (nonatomic, strong) FontAlertView *fontAlertView;
@property (nonatomic, strong) ColorAlertView *colorAlertView;


@end
@implementation CustomAlertPool

CGFloat const bottomHeight = 60;
+ (instancetype)customAlertPool
{
    CGFloat height = 0.f;
    (iPhoneXM|| iPhoneXR || iPhoneX) ? (height = 88+ 20):(height = 64);
    CustomAlertPool *pool = [[CustomAlertPool alloc] initWithFrame:CGRectMake(0, kScreenHeight - alertViewHeight + bottomHeight -height, kScreenWidth, alertViewHeight + bottomHeight)];
    return pool;
}

- (CustomAlertPool *)alpha:(void(^)(CGFloat alpha))alphaBlock {
    self.alpheraAlert.alphaBlock = alphaBlock;
    return self;
}
- (CustomAlertPool *)font:(void(^)(NSInteger font))fontBlock {
    self.fontAlertView.fontBlock = fontBlock;
    return self;
}
- (CustomAlertPool *)tiziGe:(void(^)(id))tiziGeBlock {
    self.tiziGeAlertView.tiziGeBlock = tiziGeBlock;
    return self;
}
-(CustomAlertPool *)color:(void(^)(id))colorBlock {
    self.colorAlertView.colorBlock = colorBlock;
    return self;
}
-(CustomAlertPool *(^)(NSInteger tagesNumber))tagNumber
{
    return ^CustomAlertPool *(NSInteger tageNumber) {
        self.tagesNumber = tageNumber;
        return self;
    };
}
- (CustomAlertPool *(^)(CGFloat percent))percent {
    
    return ^CustomAlertPool *(CGFloat percent) {
        self.alpheraAlert.percent = percent;
        return self;
    };
}
- (CustomAlertPool *(^)(NSInteger indeXColor))color {
    return ^CustomAlertPool *(NSInteger indeXColor) {
        self.colorAlertView.colorIndex = indeXColor;
        return self;
    };
}
- (CustomAlertPool *(^)(NSInteger indeXTiziGe))tiziGe {
    return ^CustomAlertPool *(NSInteger indeXColor) {
        self.tiziGeAlertView.Indextizi = indeXColor;
        return self;
    };
}
- (CustomAlertPool *(^)(NSInteger indeXFont))fontSize {
    return ^CustomAlertPool *(NSInteger indeXFont) {
        self.fontAlertView.fontIndex = indeXFont;
        return self;
    };
}
- (void)tapGesRemove:(UITapGestureRecognizer *)tapGes
{
    UIView *view = tapGes.view;
    [self removeFromSuperview];
    [view removeFromSuperview];
}

- (CustomAlertPool *)alertShow {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *blackView = [UIView new];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesRemove:)];
    [blackView addGestureRecognizer:tapGes];
    blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    [window addSubview:blackView];
    [window addSubview:self];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(window.mas_top);
        make.left.mas_equalTo(window.mas_left);
        make.right.mas_equalTo(window.mas_right);
        make.bottom.mas_equalTo(self.mas_top);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(window.mas_bottom).offset((iPhoneX||iPhoneXR||iPhoneXM)?-20:0);
        make.left.mas_equalTo(window.mas_left);
        make.right.mas_equalTo(window.mas_right);
        make.height.mas_equalTo(alertViewHeight + bottomHeight);
    }];
    return self;
}

- (NSMutableArray *)bttons {
    if (!_bttons) {
        _bttons = [NSMutableArray array];
    }
    return _bttons;
}
- (void)placeHolderView {
    // 创建视图
    self.alpheraAlert = [[AlpheraAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, alertViewHeight)];
    self.alpheraAlert.tag = 1001;
    self.tiziGeAlertView = [[TiziGeAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, alertViewHeight)];
    self.tiziGeAlertView.tag = 1002;
    self.fontAlertView = [[FontAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, alertViewHeight)];
    self.fontAlertView.tag = 1003;
    self.colorAlertView = [[ColorAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, alertViewHeight)];
    self.colorAlertView.tag = 1000;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, alertViewHeight, kScreenWidth, bottomHeight)];
    NSArray *array = @[@"bianji_yanse_a",@"bianji_touming_a",@"bianji_yangshi_a",@"bianji_daxiao_a"];
    const  CGFloat fengeWidth = (kScreenWidth - (4 * 44)) / 5;// 分割距离
    const CGFloat netY = (bottomHeight - 44) / 2;
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        CGFloat netX = fengeWidth *(i + 1) + i * 44;
        button.frame = CGRectMake(netX, netY, 44, 44);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttionClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        [self.bttons  addObject:button];
    }
    
    [self addSubview:self.alpheraAlert];
    [self addSubview:self.tiziGeAlertView];
    [self addSubview:self.fontAlertView];
    [self addSubview:self.colorAlertView];
    [self addSubview:bottomView];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)buttionClick:(UIButton *)sender
{
    [self setTagesNumber:sender.tag];
}


- (void)setTagesNumber:(NSInteger)tagesNumber {
    _tagesNumber = tagesNumber;
    NSString *tageStr = [NSString stringWithFormat:@"%d",tagesNumber];
    NSString *lastStr = [tageStr substringFromIndex:(tageStr.length - 1)];
    NSInteger lastnumber = lastStr.integerValue;
    UIView *view = [self viewWithTag:1000 + lastnumber];
    [self bringSubviewToFront:view];
    [self configurateWithTagesNumber:_tagesNumber];
}

- (void)configurateWithTagesNumber:(NSInteger)tag {
    NSArray *unSelect = @[@"bianji_yanse_a",@"bianji_touming_a",@"bianji_yangshi_a",@"bianji_daxiao_a"];
    NSArray *select = @[@"bianji_yanse_b",@"bianji_touming_b",@"bianji_yangshi_b",@"bianji_daxiao_b"];
    [self.bttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        if (btn.tag == tag) {
            // 这个设置成
            [btn setImage:[UIImage imageNamed:select[btn.tag - 100]] forState:UIControlStateNormal];
        } else {
            [btn setImage:[UIImage imageNamed:unSelect[btn.tag - 100]] forState:UIControlStateNormal];
        }
    }];
}
@end

#import "CustomSizeCell.h"
@interface CustomSize ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *sizeArray;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSArray *PaperTypeArray;
@property (nonatomic, copy) void(^selectSizeBlock)(NSString *index);

@end
CGFloat const customSizeHeight = 68 * 3 + 130;
@implementation CustomSize

- (CustomSize *(^)(NSArray *paperArray))paper
{
    return ^CustomSize *(NSArray * paperArray) {
        self.PaperTypeArray = paperArray;
        return self;
    };
}

+ (instancetype)customSizeAlertPool {
    CustomSize *custom = [[CustomSize alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 68 * 3 + 100)];
    return custom;
}

- (CustomSize *(^)(NSInteger index))index {
    return ^CustomSize *(NSInteger index) {
        self.indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView reloadData];
        return self;
    };
}
- (CustomSize *)selectIndex:(void(^)(NSString *index))selectSizeBlock {
    self.selectSizeBlock = selectSizeBlock;
    return self;
}

- (CustomSize *)alertShow {
    const CGFloat height = ((iPhoneX||iPhoneXM||iPhoneXR)?20:0);
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *blackView = [UIView new];
    blackView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - height);
    blackView.backgroundColor =  RGBACOLOR(0, 0, 0, 0.3);
    self.blackView = blackView;
    
    [window addSubview:blackView];
    [window addSubview:self];
    self.frame = CGRectMake(0, kScreenHeight,kScreenWidth , customSizeHeight);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight - customSizeHeight - height ,kScreenWidth, customSizeHeight);
    }];
    
    return self;
}
- (NSMutableArray *)sizeArray {
    if (!_sizeArray) {
        _sizeArray = [NSMutableArray arrayWithObjects:
                      @{@"name":@"A3",@"size":@"210 X 297"},
                      @{@"name":@"A4",@"size":@"500 X 707"},nil];
    }
    return _sizeArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.PaperTypeArray) {
        return self.sizeArray.count;
    }
    return self.PaperTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomSizeCell" forIndexPath:indexPath];
    if ((!self.indexPath &&indexPath.row == 0)||self.indexPath.row == indexPath.row) {
        cell.selectImage.image = [UIImage imageNamed:@"btn_xuanzhong_b"];
    } else {
        cell.selectImage.image = [UIImage imageNamed:@"btn_xuanzhong_a"];
    }
    if (!self.PaperTypeArray) {
        NSDictionary *dic = self.sizeArray[indexPath.row];
        cell.nameL.text = dic[@"name"];
        cell.sizeLa.text = dic[@"size"];
        
    } else {
        NSString *paper=  self.PaperTypeArray[indexPath.row];
        [self configureWithPapaer:paper cell:cell];
        if (self.PaperTypeArray.count == 1) {
            cell.selectImage.image = [UIImage imageNamed:@"btn_xuanzhong_b"];
        }
    }
    
    return cell;
}
- (void)configureWithPapaer:(NSString *)papaer cell:(CustomSizeCell *)cell{
    if ([papaer isEqualToString:@"1"]) {// 1
        cell.nameL.text = @"A3";
        cell.sizeLa.text = @"210 X 297";
    } else if ([papaer isEqualToString:@"2"]) {// 2
        cell.nameL.text = @"A4";
        cell.sizeLa.text = @"500 X 707";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sizeArray.count > indexPath.row) {
        self.indexPath = indexPath;
        [self.tableView reloadData];
    }
}

- (void)cancleAction:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, customSizeHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.blackView removeFromSuperview];
    }];
    
}


- (void)placeHolderView {
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"icon_shouqi_c"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    self.titleLb = [UILabel new];
    self.titleLb.text = @"字帖尺寸";
    UILabel *des = [UILabel new];
    self.des = des;
    des.text = @"纸张尺寸 (单位: mm)";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 68 * 3) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomSizeCell" bundle:nil] forCellReuseIdentifier:@"CustomSizeCell"];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.tableView.rowHeight = 68;
    [self addSubview:self.titleLb];
    [self addSubview:des];
    [self addSubview:cancleBtn];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(114/2.f);
        make.left.mas_equalTo(self.mas_left).offset(114/2.f);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
        make.left.mas_equalTo(self.titleLb.mas_right).offset(20);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(68 * 3);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(25);;
        make.right.mas_equalTo(self.mas_left).offset(30);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
}
- (void)layoutPlaceViews {
    self.titleLb.font       = [UIFont systemFontOfSize:16];
    self.titleLb.textColor  = RGBCOLOR(0, 0, 0);
    self.des.font = [UIFont systemFontOfSize:12];
    self.des.textColor = RGBCOLOR(180, 180, 180);
    
}
- (void)buttonAction:(UIButton *)sender {
    if (self.selectSizeBlock) {
        if (self.indexPath) {// indexPath
            if (self.PaperTypeArray) {
                NSString *papaer = self.PaperTypeArray[self.indexPath.row];
                if ([papaer isEqualToString:@"1"]) {// A3
                    self.selectSizeBlock(@"A3");
                    
                } else if ([papaer isEqualToString:@"2"]) {// A4
                    self.selectSizeBlock(@"A4");
                    
                }
                [self cancleAction:nil];
                return;
            }
            NSDictionary *dic = self.sizeArray[self.indexPath.row];
            NSString *A3orA4 = dic[@"name"];
            self.selectSizeBlock(A3orA4);
            [self cancleAction:nil];
        }
    }
}

@end
#import "UILabel+LXAdd.h"
@interface TipAlert ()

@property (nonatomic, copy) void(^sureBlock)(BOOL isSure);
@property (nonatomic, strong) UIImageView *placeImageView;


@end

@implementation TipAlert

- (void)placeHolderView {
    
    self.titleLb = [UILabel new];
    NSString *labelText = @"下载后方可预览，是否下载此字体?";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:14];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *color = RGBCOLOR(10, 10, 10);
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [labelText length])];
    self.titleLb.attributedText = attributedString;
    self.titleLb.textAlignment  = NSTextAlignmentCenter;
    
    self.placeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tishi_a"]];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LineBackgroundColor;
    
    UIView *midLineView = [[UIView alloc] init];
    midLineView.backgroundColor = LineBackgroundColor;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:RGBCOLOR(255, 0, 0) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *okBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [okBtn setTitleColor:RGBCOLOR(10, 114, 255) forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.placeImageView];
    [self addSubview:self.titleLb];
    [self addSubview:lineView];
    [self addSubview:midLineView];
    [self addSubview:cancleBtn];
    [self addSubview:okBtn];
    
    [self.placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(45);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.titleLb.numberOfLines = 0;
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeImageView.mas_bottom).offset(45);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancleBtn.mas_top).offset(-12);
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.right.mas_equalTo(self.titleLb.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    [midLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-12);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(0.5);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(midLineView.mas_left);
        make.centerY.mas_equalTo(midLineView.mas_centerY);
        make.height.mas_equalTo(45);
    }];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.left.mas_equalTo(midLineView.mas_right);
        make.centerY.mas_equalTo(midLineView.mas_centerY);
        make.height.mas_equalTo(cancleBtn.mas_height);
    }];
    
    
    
    
}
// 否
- (void)cancleAction:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(NO);
    }
    [self.blackView removeFromSuperview];
    [self removeFromSuperview];
}
// 是
- (void)okBtnAction:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(YES);
    }
    [self.blackView removeFromSuperview];
    [self removeFromSuperview];
}


+ (void)centerAlertShowtipAlertisSureBlock:(void(^)(BOOL isSure))sureBlock {
    
    TipAlert *tipAlertView = [[TipAlert alloc] initWithFrame:CGRectMake(0, 0, 280, 250)];
    tipAlertView.sureBlock = sureBlock;
    UIView *blackView = [UIView new];
    blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    
    tipAlertView.blackView = blackView;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:blackView];
    blackView.frame = window.bounds;
    [window addSubview:tipAlertView];
    tipAlertView.center = window.center;
    
}
@end
@interface TipCopyAlert ()

@property (nonatomic, copy) void(^coyBlock)(BOOL isSure);

@property (nonatomic, strong) UIImageView *placeImageView;
@property (nonatomic, strong) UILabel *urlLabel;

@end
@implementation TipCopyAlert

- (void)placeHolderView {
    
    self.titleLb = [UILabel new];
    NSString *labelText = @"已为您生成了下载链接\n请复制后用浏览器打开";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:14];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *color = RGBCOLOR(10, 10, 10);
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [labelText length])];
    self.titleLb.attributedText = attributedString;
    
    self.placeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chenggongf"]];
    
    self.urlLabel = [UILabel new];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LineBackgroundColor;
    
    UIView *midLineView = [[UIView alloc] init];
    midLineView.backgroundColor = LineBackgroundColor;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *okBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    [okBtn setTitle:@"复制链接" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [okBtn setTitleColor:RGBCOLOR(10, 114, 255) forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.placeImageView];
    [self addSubview:self.titleLb];
    [self addSubview:self.urlLabel];
    [self addSubview:lineView];
    [self addSubview:midLineView];
    [self addSubview:cancleBtn];
    [self addSubview:okBtn];
    
    [self.placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(25);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.titleLb.numberOfLines = 0;
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeImageView.mas_bottom).offset(25);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];
    
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancleBtn.mas_top).offset(-12);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.height.mas_equalTo(0.5);
    }];
    
    [midLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-12);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(0.5);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(midLineView.mas_left);
        make.centerY.mas_equalTo(midLineView.mas_centerY);
        make.height.mas_equalTo(45);
    }];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.left.mas_equalTo(midLineView.mas_right);
        make.centerY.mas_equalTo(midLineView.mas_centerY);
        make.height.mas_equalTo(cancleBtn.mas_height);
    }];
    self.urlLabel.numberOfLines = 0;
    [self.urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_left);
        make.right.mas_equalTo(lineView.mas_right);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(12);
    }];
    
    
}
// 取消
- (void)cancleAction:(UIButton *)sender {
    if (self.coyBlock) {
        self.coyBlock(NO);
    }
    [self.blackView removeFromSuperview];
    [self removeFromSuperview];
}
//  复制链接
- (void)okBtnAction:(UIButton *)sender {
    if (self.coyBlock) {
        self.coyBlock(YES);
    }
    [self.blackView removeFromSuperview];
    [self removeFromSuperview];
}


+ (void)centerAlertShowtipAlertisSureBlock:(void(^)(BOOL isCopy))sureBlock urlString:(NSString *)urlString;
{
    
    TipCopyAlert *tipAlertView = [[TipCopyAlert alloc] initWithFrame:CGRectMake(0, 0, 300, 340.5)];
    //    tipAlertView.urlLabel.text = urlString;
    NSString *labelText = urlString;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *color = RGBCOLOR(32, 179, 255);
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [labelText length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [labelText length])];
    tipAlertView.urlLabel.attributedText = attributedString;
    
    tipAlertView.urlString = urlString;
    tipAlertView.coyBlock = sureBlock;
    UIView *blackView = [UIView new];
    blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    tipAlertView.blackView = blackView;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:blackView];
    blackView.frame = window.bounds;
    [window addSubview:tipAlertView];
    tipAlertView.center = window.center;
    
}

@end
CGFloat const customWordsSetHeight = 302.f/2 + 50;

@interface WordsSet ()
@property (nonatomic, assign) BOOL autoFillWords;
@property (nonatomic, assign) BOOL autoClearPunctuation;
@property (nonatomic, copy) void(^WordsSetBlock)(BOOL,BOOL);
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UISwitch *switchView2;


@end
@implementation WordsSet

+ (void)congigureLookFontsSetBlockFillWords:(BOOL)autoFillWords autoClearPunctuation:(BOOL)clearPunctuation setBlock:(void(^)(BOOL autoFillWords,BOOL autoClearPunctuation))setBlock {
    
    // 1.0 创建自身  2.0 创建蒙版
    WordsSet *setView = [[WordsSet alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, customWordsSetHeight)];
    setView.backgroundColor = [UIColor whiteColor];
    setView.autoFillWords = autoFillWords;
    setView.autoClearPunctuation = clearPunctuation;
    setView.WordsSetBlock = setBlock;
    setView.switchView.on = autoFillWords;
    setView.switchView2.on = clearPunctuation;
    // 3.0 获取window 把蒙版放在窗口上&&自身弹框
    const CGFloat height = ((iPhoneX||iPhoneXM||iPhoneXR)?20:0);
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:setView.blackView];
    [window addSubview:setView];
    setView.blackView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - height);
    setView.frame = CGRectMake(0, kScreenHeight,kScreenWidth , customWordsSetHeight);
    // 4.0 动画
    [UIView animateWithDuration:0.25 animations:^{
        setView.frame = CGRectMake(0, kScreenHeight - customWordsSetHeight - height ,kScreenWidth, customWordsSetHeight);
    }];
    
    
}
- (void)sureBtnAction:(UIButton *)sureBtn {
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.frame = CGRectMake(0, kScreenHeight, kScreenWidth, customWordsSetHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        [weakSelf.blackView removeFromSuperview];
    }];
}
- (void)cancleBtnAction:(UIButton *)cancleBtn {
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.frame = CGRectMake(0, kScreenHeight, kScreenWidth, customWordsSetHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        [weakSelf.blackView removeFromSuperview];
    }];
}
- (void)conteLabelSwitchAction:(UISwitch *)on {
    self.autoFillWords = on.on;
    if (self.WordsSetBlock) {
        self.WordsSetBlock(self.autoFillWords,  self.autoClearPunctuation);
    }
}
- (void)conteLabelSwitchAction2:(UISwitch *)on {
    self.autoClearPunctuation = on.on;
    if (self.WordsSetBlock) {
        self.WordsSetBlock(self.autoFillWords,  self.autoClearPunctuation);
    }
}
- (void)placeHolderView {
    //1.0 创建顶部视图
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    //    topview.backgroundColor = [UIColor whiteColor];
    //1.0.1创建取消按钮
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleBtn setImage:[UIImage imageNamed:@"icon_shouqi_c"] forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //1.0.2创建标题
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = RGBCOLOR(121, 121, 121);
    label.text = @"内容设置";
    //1.0.3创建确定按钮
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureBtn setTitleColor:RGBCOLOR(255, 46, 46) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //1.0.4创建黑线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LineBackgroundColor;
    [self addSubview:topview];
    [topview addSubview:_cancleBtn];
    [topview addSubview:label];
    [topview addSubview:sureBtn];
    [topview addSubview:lineView];
    
    //2.0 创建底部视图
    UIView *contentView = [UIView new];
    //    contentView.backgroundColor = [UIColor whiteColor];
    //2.0.1创建自动填满空白字格
    UILabel *conteLabel1 = [UILabel new];
    conteLabel1.font = [UIFont systemFontOfSize:15];
    conteLabel1.text = @"自动填满空白字格";
    conteLabel1.textColor = RGBCOLOR(0, 0, 0);
    //2.0.2创建switch控件
    UISwitch *switchView = [[UISwitch alloc]init];
    self.switchView = switchView;
    [switchView addTarget:self action:@selector(conteLabelSwitchAction:) forControlEvents:UIControlEventValueChanged];
    
    //2.0.3创建自动清除标点符号
    UILabel *conteLabel2 = [UILabel new];
    conteLabel2.font = [UIFont systemFontOfSize:15];
    conteLabel2.text = @"自动清除标点符号";
    conteLabel2.textColor = RGBCOLOR(0, 0, 0);
    //2.0.4创建switch控件
    UISwitch *switchView2 = [[UISwitch alloc]init];
    self.switchView2 = switchView2;
    [switchView2 addTarget:self action:@selector(conteLabelSwitchAction2:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:contentView];
    [contentView addSubview:conteLabel1];
    [contentView addSubview:switchView];
    [contentView addSubview:conteLabel2];
    [contentView addSubview:switchView2];
    //3.0 创建蒙版
    self.blackView = [UIView new];
    self.blackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    
    //4.0布局topView
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    //4.0.1 布局左边的取消按钮
    [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview.mas_left).offset(20);
        make.centerY.mas_equalTo(topview);
        make.width.height.mas_equalTo(35);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(topview);
    }];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topview.mas_right).offset(-20);
        make.centerY.mas_equalTo(topview.mas_centerY);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(topview);
        make.height.mas_equalTo(0.5);
    }];
    //5.0 创建底部的布局
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topview.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
    }];
    [conteLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topview.mas_bottom).offset(33);
        make.left.mas_equalTo(contentView.mas_left).offset(50.1);
    }];
    
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conteLabel1.mas_centerY);
        make.right.mas_equalTo(contentView.mas_right).offset(-30);
    }];
    
    [conteLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(conteLabel1.mas_left);
        make.top.mas_equalTo(conteLabel1.mas_bottom).offset(38);
    }];
    [switchView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conteLabel2.mas_centerY);
        make.right.mas_equalTo(switchView.mas_right);
    }];
    
}

@end
