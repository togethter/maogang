//
//  UserManager.h
//  LvJie
//
//  Created by bilin on 2017/1/5.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface UserManager : NSObject

@property (nonatomic, strong, readonly) UserModel *userModel;
// App版本号
@property (nonatomic, copy, readonly) NSString *AppVersion;
// 单利
+ (instancetype)sharedManager;

//保存用户信息
- (void)savaUserInfoWith:(UserModel *)entity;

//清空用户信息
- (void)cleanUserInfo;

//判断是否登录
- (BOOL)isLoad;

// 是否显示新特性
- (BOOL)isDisplayGuidePage;

@end
