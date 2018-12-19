//
//  ZLPhotoPickerBrowserPhotoScrollView.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZLPhotoPickerBrowserPhotoImageView.h"
#import "ZLPhotoPickerBrowserPhotoView.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhoto.h"

typedef void(^callBackPhotoBlock)(id img);
typedef void(^callBackPhotoStateBeganBlock)(id img);

@class ZLPhotoPickerBrowserPhotoScrollView;

@protocol ZLPhotoPickerPhotoScrollViewDelegate <NSObject>
@optional
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(ZLPhotoPickerBrowserPhotoScrollView *)photoScrollView;
//长按
- (void) pickerPhotoScrollViewDidSingleClickStateBegan:(ZLPhotoPickerBrowserPhotoScrollView *)photoScrollView;

@end

@interface ZLPhotoPickerBrowserPhotoScrollView : UIScrollView <UIScrollViewDelegate, ZLPhotoPickerBrowserPhotoImageViewDelegate,ZLPhotoPickerBrowserPhotoViewDelegate>

@property (nonatomic,strong) ZLPhotoPickerBrowserPhoto *photo;
@property (strong,nonatomic) ZLPhotoPickerBrowserPhotoImageView *photoImageView;
@property (nonatomic, weak) id <ZLPhotoPickerPhotoScrollViewDelegate> photoScrollViewDelegate;
// 长按图片的操作，可以外面传入
@property (strong,nonatomic) UIActionSheet *sheet;
// 单击销毁的block
@property (copy,nonatomic) callBackPhotoBlock callback;
//长按
@property (copy,nonatomic) callBackPhotoStateBeganBlock callbackStateBegan;

- (void)setMaxMinZoomScalesForCurrentBounds;
@end
