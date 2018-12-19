//
//  UIImageUtils.m
//  17Snooker
//
//  Created by LookMedia-China on 14-4-16.
//  Copyright (c) 2014年 LookMedia-China. All rights reserved.
//

#import "UIImageUtils.h"

@implementation UIImageUtils
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage*) getPlaceholderImage{
    return [UIImage imageNamed:@"photos.png"];
}
+ (void)rotate180back:(UIView*)view withDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration delay:0 options:0 animations: ^{
        view.transform = CGAffineTransformRotate(view.transform, 3.141593);
    } completion: ^(BOOL completed) {
        if (!completed) {
            [self rotate180:view withDuration:duration];
        }
    }];
}
+ (void)rotate180:(UIView*)view withDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration delay:0 options:0 animations: ^{
        view.transform = CGAffineTransformRotate(view.transform, -3.141593);
    } completion: ^(BOOL completed) {
        if (!completed) {
            [self rotate180:view withDuration:duration];
        }
    }];
}

//压缩图片（等比例)
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
//        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+ (CGRect )setOneImageViewSize:(UIImageView *)imageView
{
    //img的尺寸
    CGFloat imgWidth=imageView.image.size.width;
    CGFloat imgHeight=imageView.image.size.height;
    
    //imgView的尺寸
    CGFloat vWidth=imageView.frame.size.width;
    CGFloat vHeight=imageView.frame.size.height;
    
    //宽高比
    CGFloat dImg=(imgWidth/imgHeight);
    CGFloat dView=(vWidth/vHeight);
    CGRect rect;
    if (dImg > dView) {
        CGFloat changedHeight=vWidth * (imgHeight/imgWidth);
        rect = CGRectMake(6,6, vWidth, changedHeight);
        
    }
    else
    {
        CGFloat changedWidth=vHeight * (imgWidth/imgHeight);
        rect = CGRectMake(6, 6, changedWidth, vHeight);
    }
    return rect;
    
}
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}



+(void)resizeFrameWithImg:(UIImage *)img andImageView:(UIImageView *)imageView
{
    //img的尺寸
    CGFloat imgWidth=img.size.width;
    CGFloat imgHeight=img.size.height;
    
    //imgView的尺寸
    CGFloat vWidth=imageView.frame.size.width;
    CGFloat vHeight=imageView.frame.size.height;
    
    //宽高比
    CGFloat dImg=imgWidth/imgHeight;
    CGFloat dView=vWidth/vHeight;
    
    if (dImg > dView) {
        CGFloat changedHeight=vWidth * (imgHeight/imgWidth);
        imageView.frame=CGRectMake(imageView.frame.origin.x, (vHeight-changedHeight)/2 + imageView.frame.origin.y, vWidth, changedHeight);
    }
    else
    {
        CGFloat changedWidth=vHeight * (imgWidth/imgHeight);
        imageView.frame=CGRectMake(imageView.frame.origin.x + (vWidth-changedWidth)/2, imageView.frame.origin.y, changedWidth, vHeight);
    }
    
}


+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
        // 创建一个bitmap的context
   
      // 并把它设置成为当前正在使用的context
    
        UIGraphicsBeginImageContext(size);
   
        // 绘制改变大小的图片
    
        [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    
       // 从当前context中创建一个改变大小后的图片
    
        UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
        // 使当前的context出堆栈
    
        UIGraphicsEndImageContext();
    
        //返回新的改变大小后的图片
    
        return scaledImage;
    
}


@end
