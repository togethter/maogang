//
//  GiFHUD.m
//  GiFHUD
//
//  Created by 王森 http://www.51zan.cc on 25/11/15.
//  Copyright (c) 2015-11-25 王森. All rights reserved.
//


#import "GiFHUD.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

#define Size            117
#define FadeDuration    0.3
#define GifSpeed        0.3

#define APPDELEGATE     ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define fromCF (__bridge id)
#else
#define toCF (CFTypeRef)
#define fromCF (id)
#endif



#pragma mark - UIImage Animated GIF


@implementation UIImage (animatedGIF)

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

@end



#pragma mark - GiFHUD Private

@interface GiFHUD ()
+ (instancetype)instance;

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL shown;

@end



#pragma mark - GiFHUD Implementation

@implementation GiFHUD


#pragma mark Lifecycle

static GiFHUD *instance;

+ (instancetype)instance {
    if (!instance) {
        instance = [[GiFHUD alloc] init];
    }
    return instance;
}

- (instancetype)init {
    if ((self = [super initWithFrame:CGRectMake(0, 0, Size, Size)])) {
        
        [self setAlpha:0];
        [self setCenter:APPDELEGATE.window.center];
        [self setClipsToBounds:NO];
//        设置整个uiview的背景颜色
        [self.layer setBackgroundColor:[[UIColor colorWithWhite:0 alpha:0] CGColor]];
        
        [self.layer setCornerRadius:10];
        [self.layer setMasksToBounds:YES];
        
//        self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 30, 60)];
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 117, 60)];

        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y+60+5, 117, 17)];
        lable.textAlignment=NSTextAlignmentCenter;
        
        lable.text=@"正在加载";
        lable.textColor=[UIColor greenColor];
        lable.font=[UIFont systemFontOfSize:14];
        
        [self addSubview:lable];
        
        [self addSubview:self.imageView];
        
        [APPDELEGATE.window addSubview:self];
    }
    return self;
}


+(void)addSting:(NSString * )str toView:(UIView *)view{

    MBProgressHUD *newhud  = [[MBProgressHUD alloc] initWithView:view];
   // newhud.delegate = self;
    
    //常用的设置
    //小矩形的背景色
    newhud.bezelView.color =[UIColor redColor];//这儿表示无背景
//    newhud.color = [UIColor redColor];//这儿表示无背景
    //显示的文字
    if (IS_VALID_STRING(str)) {
        newhud.label.text =str;
    }else{
         newhud.label.text =@"结构体错误~";
    }
     //细节文字
   newhud.detailsLabel.text =@"Test detail";
   
    newhud.customView.backgroundColor = [UIColor clearColor];
    //是否有庶罩
//    newhud.dimBackground = YES;
    [newhud hideAnimated:YES afterDelay:2];
//    [newhud hide:YES afterDelay:2];



}



#pragma mark HUD

+ (void)showWithOverlay {
    [self dismiss:^{
        [APPDELEGATE.window addSubview:[[self instance] overlay]];
        [self show];
    }];
}

+ (void)show {
    [self dismiss:^{
        [APPDELEGATE.window bringSubviewToFront:[self instance]];
        [[self instance] setShown:YES];
        [[self instance] fadeIn];
    }];
}


+ (void)dismiss {
    if (![[self instance] shown])
        return;
    
    [[[self instance] overlay] removeFromSuperview];
    [[self instance] fadeOut];
}

+ (void)dismiss:(void(^)(void))complated {
    if (![[self instance] shown])
        return complated ();
    
    [[self instance] fadeOutComplate:^{
        [[[self instance] overlay] removeFromSuperview];
        complated ();
    }];
}

#pragma mark Effects

- (void)fadeIn {
    [self.imageView startAnimating];
    
    [UIView animateWithDuration:FadeDuration animations:^{
        [self setAlpha:1];
    }];
}

- (void)fadeOut {
    [UIView animateWithDuration:FadeDuration animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setShown:NO];
        [self.imageView stopAnimating];
    }];
}

- (void)fadeOutComplate:(void(^)(void))complated {
    [UIView animateWithDuration:FadeDuration animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self setShown:NO];
        [self.imageView stopAnimating];
        complated ();
    }];
}


- (UIView *)overlay {
    
    if (!self.overlayView) {
        self.overlayView = [[UIView alloc] initWithFrame:APPDELEGATE.window.frame];
        [self.overlayView setBackgroundColor:[UIColor blackColor]];
//       开始时候的默认值不用该
        [self.overlayView setAlpha:0];
        
        [UIView animateWithDuration:FadeDuration animations:^{
            
//            self.overlayView.backgroundColor=[UIColor redColor];
            [self.overlayView setAlpha:0.3];

        }];
    }
    return self.overlayView;
}



#pragma mark Gif

+ (void)setGifWithImages:(NSArray *)images {
    [[[self instance] imageView] setAnimationImages:images];
    [[[self instance] imageView] setAnimationDuration:GifSpeed];
}

+ (void)setGifWithImageName:(NSString *)imageName {
    
    [[[self instance] imageView] stopAnimating];
    [[[self instance] imageView] setImage:[UIImage animatedImageWithAnimatedGIFURL:[[NSBundle mainBundle] URLForResource:imageName withExtension:nil]]];
}

+ (void)setGifWithURL:(NSURL *)gifUrl {
    [[[self instance] imageView] stopAnimating];
    [[[self instance] imageView] setImage:[UIImage animatedImageWithAnimatedGIFURL:gifUrl]];
}
+ (void)showGifToView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //使用SDWebImage 放入gif 图片
    UIImage *image =[UIImage sd_animatedGIFWithData:UIImagePNGRepresentation([UIImage imageNamed:@"loading.gif"])];
    
    //自定义imageView
    UIImageView *cusImageV = [[UIImageView alloc] initWithImage:image];
    
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置在hud影藏时将其从SuperView上移除,自定义情况下默认为NO
    hud.removeFromSuperViewOnHide = YES;
    
    //设置方框view为该模式后修改颜色才有效果
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    //设置方框view背景色
    hud.bezelView.backgroundColor = [UIColor clearColor];
    
    //设置总背景view的背景色，并带有透明效果
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    hud.customView = cusImageV;
}


+ (void)setGifWithMBProgress:(NSString *)string toView:(UIView *)view;
{
    //提示成功
    MBProgressHUD *newhud  = [[MBProgressHUD alloc] initWithView:view];
    newhud.backgroundColor = [UIColor whiteColor];
    newhud.userInteractionEnabled = YES;//关闭交互
    newhud.bezelView.color =RGBACOLOR(0, 0, 0, 0);//这儿表示无背景
    newhud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    /*!
     *  @author WS, 15-11-26 15:11:52
     *
     *  是否显示遮罩
     */
    newhud.dimBackground = NO;
    newhud.customView.backgroundColor =RGBACOLOR(0, 0, 0, 0) ;
    [view addSubview:newhud];
    if (IS_VALID_STRING(string)) {
        newhud.label.text = string;
    }

    /*!
     *  @author WS, 15-11-26 15:11:05
     *
     *  字体颜色
     */
    newhud.label.textColor=[UIColor blackColor];
    newhud.mode = MBProgressHUDModeCustomView;
    UIView * headhudview=[[UIView alloc]init];
    headhudview.backgroundColor=[UIColor redColor];
    headhudview.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    /*!
     *  @author WS, 15-11-26 15:11:32
     *
     *  如果修改动画图片就在这里修改
     */
    UIImage *images=[UIImage sd_animatedGIFNamed:@"loading"];
    UIImageView * imageV = [[UIImageView alloc]initWithImage:images];
    newhud.customView =imageV ;
    [newhud showAnimated:YES];

}

+ (void)show:(NSString *)text  view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = YES;
    if (IS_VALID_STRING(text)) {
        hud.label.text = text;
    }else{
        
        hud.label.text = @"结构体返回错误~";
    }
    
    hud.bezelView.backgroundColor = [UIColor blackColor];

    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
    
}
+ (void)GeneralButtonActionView:(UIView *)view title:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    //如果设置此属性则当前的view置于后台
    hud.bezelView.backgroundColor = [UIColor blackColor];
    //设置对话框文字
    hud.label.text = title;
    hud.label.textColor = [UIColor whiteColor];
    //设置菊花框为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    //    //细节文字
//        hud.detailsLabelText = @"请耐心等待";
    
    [hud showAnimated:YES];
}

//   通常情况  文字  加 菊花
+ (void)GeneralButtonActionView:(UIView *)view{
    //初始化进度框，置于当前的View当中
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    //如果设置此属性则当前的view置于后台
    hud.bezelView.backgroundColor = [UIColor blackColor];
    //设置对话框文字
    hud.label.text = @"加载中...";
    hud.label.textColor = [UIColor whiteColor];
    //设置菊花框为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
//    //细节文字
//    hud.detailsLabelText = @"请耐心等待";
    
    [hud showAnimated:YES];
}





+ (void)hideHUDForView:(UIView *)view
{
    
    [MBProgressHUD hideHUDForView:view animated:YES];
    }

@end
