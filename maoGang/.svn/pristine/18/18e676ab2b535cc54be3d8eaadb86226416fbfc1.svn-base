//
//  PushSingleton.h
//  LvJie
//
//  Created by bilin on 2018/3/8.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
// 专门为remotoPush 用于需要登录之后才能页面条猪獒的的单利 记住每次需要跳转的话首先将导航控制器销毁掉以及 对应的VC销毁掉

#import <Foundation/Foundation.h>

@interface PushSingleton : NSObject
#import "BaseModel.h"
+ (instancetype)pushSharedInstance;
// 导航控制器
@property (nonatomic, strong) UINavigationController *navc;
// 试图控制器
@property (nonatomic, strong) UIViewController *vc;
// 清除内部设置
- (void)clearNavcAndVC;
// remoto push 遥远的推送跳转
- (void)configurationRemoToPushWith:(BaseModel *)model;
// 拼接参数
- (NSString *)combinationParameter:(NSString *)url withToken:(NSString *)token;

@end
