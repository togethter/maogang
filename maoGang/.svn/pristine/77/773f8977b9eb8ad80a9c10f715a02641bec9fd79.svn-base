//
//  YBAreaPickerView.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "YLAlertAddBookTool.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface YLAlertAddBookTool ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *toolBar;
@property(nonatomic,strong)UIView * bottomV;





@end

@implementation YLAlertAddBookTool

- (void)dealloc
{
    DLog(@"%s", __FUNCTION__);
}

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        //点击手势去掉
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
//        [_bgView addGestureRecognizer:tap];
        
        [_bgView addSubview:self];
//        [_bgView addSubview:self.bottomV];
        
        
    }
    return _bgView;
}
-(UIView * )bottomV{
    
    if (!_bottomV) {
        _bottomV = [[UIView alloc]initWithFrame:CGRectMake(15, (kScreenH-220)/2, kScreenW-30, 180)];
        _bottomV.backgroundColor = [UIColor yellowColor];
       
    }
    return _bottomV;
    
}



- (UIView *)toolBar
{
    if (_toolBar==nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-self.bounds.size.height-34, kScreenW, 34)];
        _toolBar.backgroundColor = [UIColor whiteColor];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(kScreenW-60, 0, 60, _toolBar.bounds.size.height);
        [finishBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(0, 0, 60, _toolBar.bounds.size.height);
        [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:cancelBtn];
    }
    return _toolBar;
}

- (void)finishClick:(UIButton *)btn
{

    [self close];
}

- (void)close
{
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
    [self.toolBar removeFromSuperview];
    self.toolBar = nil;
    self.bgView = nil;
}

- (void)show
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self.bgView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
 
        UILabel * titile = [[UILabel alloc]initWithFrame:CGRectMake(0,AdaptedHeightValue(29), self.frame.size.width, AdaptedHeightValue(20))];
        titile.textAlignment = NSTextAlignmentCenter;
        titile.font =kUHSystemFontWithSize(15) ;
        titile.textColor = [UIColor blackColor];
        titile.text = @"正在下载该字体";
        [self addSubview:titile];
        
        //进度条 进度
        self.numberProgressL = [[UILabel alloc]initWithFrame:CGRectMake(0, titile.frame.origin.y+titile.frame.size.height+AdaptedHeightValue(21), self.frame.size.width, AdaptedHeightValue(20))];
       
        self.numberProgressL.textColor = RGBCOLOR(49, 202, 103);
        self.numberProgressL.font =kUHSystemFontWithSize(18);
        self.numberProgressL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.numberProgressL];
        
        //进度条
        self.progressView = [[HWProgressView alloc] initWithFrame:CGRectMake(AdaptedWidthValue(33), self.numberProgressL.frame.origin.y+self.numberProgressL.frame.size.height+AdaptedHeightValue(21), self.frame.size.width-AdaptedWidthValue(33)*2, AdaptedHeightValue(16))];
        [self addSubview:self.progressView];
        
       
        
    }
    
    return self;
}





@end
