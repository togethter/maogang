//
//  ScorllView.h
//  TestControl
//
//  Created by lanouhn on 16/4/1.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YLScorlControl;
@protocol ScorlControlDelegate <NSObject>
// 点击对应按钮的点击回调
- (void)ScorlControlDismissActionWithIndex:(NSInteger)index;

@end
@interface YLScorlControl : UIView
// 默认是可以的
@property (nonatomic, assign) BOOL titleScrolEnabled;
@property (nonatomic, weak) UIView  *contentView;
@property (nonatomic, assign) CGFloat midMargin;

- (void)show;
@property (nonatomic, assign)id<ScorlControlDelegate>delegate;
/**
 * 默认选中哪个按钮
 */
-(void)selectedButtonClicked:(NSInteger) index;

- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle;

@end
