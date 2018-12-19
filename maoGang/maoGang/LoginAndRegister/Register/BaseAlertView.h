//
//  BaseAlertView.h
//  LvJie
//
//  Created by bilin on 2018/4/27.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
// 弹框的基类

#import <UIKit/UIKit.h>
#import "BaseAlertProtocol.h"
typedef enum : NSUInteger {
    cancleEnum = 1,// 取消
    okEnum = 2,// 确定
    deleteEnum = 3,// 删除
    finishEnum = 4,// 完成
    Placedtop = 5,// 置顶
    wxLogin = 6,// 微信登录
    cancle = 7,// 点击取消
} clickEnum;

typedef NS_ENUM(NSInteger , YLLXAShowAnimationStyle) {
    YLLXASAnimationDefault    = 0,
    YLLXASAnimationLeftShake  ,
    YLLXASAnimationTopShake   ,
    YLLXASAnimationNO         ,
};
typedef void(^alertBlock)(clickEnum toWhathEnum);
@interface BaseAlertView : UIView<BaseAlertProtocol>
/** 点击空白区域是否可以移除自身*/
@property (nonatomic, assign) BOOL isCanRemoveClickBlackView;
/** 弹框*/
@property (nonatomic,readonly)UIView *alertView;
/** 创建的window*/
@property (nonatomic,readonly)UIWindow *alertWindow;
/** 弹框的弹起的的状态*/
@property (nonatomic,assign)YLLXAShowAnimationStyle animationStyle;
/** 指定位置 如果为YES的话需要谁知指定位置显示 specifiedCenter*/
@property (nonatomic,assign) BOOL isSpecifiedLocation;
/*** 具体的位置在哪里显示*/
@property (nonatomic, assign) CGPoint specifiedCenter;

@property (nonatomic, copy) alertBlock aletBlock;

/**
 弹框的基类

 @param model 模型
 @param alertBlock 点击按钮的操作
 @param view 被点击的对象
 @return 弹框对象
 */
- (instancetype)initWithalertWithWithModel:(BaseModel *)model withAlertBlock:(alertBlock)alertBlock ClickItem:(UIView *)view withViewSubViewView:(UITableView *)tableView;


@end
