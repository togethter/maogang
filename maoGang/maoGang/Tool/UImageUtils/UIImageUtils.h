//
//  UIImageUtils.h
//  17Snooker
//
//  Created by LookMedia-China on 14-4-16.
//  Copyright (c) 2014年 LookMedia-China. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImageUtils : NSObject
/**
 *  根据颜色生成图片
 *
 *  @param color
 *
 *  @return
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

//获取默认图片
+(UIImage*) getPlaceholderImage;

/**
 *布局翻转180°
 */
+ (void)rotate180:(UIView*)view withDuration:(NSTimeInterval)duration;
/**
 *布局翻转180°后,翻转回来d
 */
+ (void)rotate180back:(UIView*)view withDuration:(NSTimeInterval)duration;
/**
 *  等比例压缩图片
 *
 *  @param sourceImage 原图
 *  @param size        压缩比例
 *
 *  @return
 */
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (CGRect )setOneImageViewSize:(UIImageView *)imageView;

/**
 *  等比例缩放
 *
 *  @param image     需要缩放的图片
 *  @param scaleSize 缩放比例
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
/**
 *  获取图片缩放比例
 *
 *  @param height 高
 *  @param width  宽
 *
 *  @return 缩放比例
 */
//+(float)getImageScaleSizeWithHeight:(float)height width:(float)width;
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
/**
 *  获取产品背景图片
 *
 *  @param productType 产品类型
 *
 *  @return 背景图片
 */
+(UIImage *)getOrderImageByProductType:(NSInteger)productType;
/**
 *  图片等比例显示
 *
 *  @param img 获取的图片
 *  @param imageView  显示图片的imageView
 *
 *  @return
 */
+(void)resizeFrameWithImg:(UIImage *)img andImageView:(UIImageView *)imageView;
/**
 *  压缩图片
 *
 *  @param img  压缩之前
 *  @param size 尺寸
 *
 *  @return 压缩后的
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
