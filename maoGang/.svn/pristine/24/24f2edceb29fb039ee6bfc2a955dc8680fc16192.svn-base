//
//  UserManager.m
//  LvJie
//
//  Created by bilin on 2017/1/5.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "UserManager.h"
#define KEY @"XLUSER"
static NSString * const theKeyForGuide = @"theKeyForGuide";
static UserModel *xuserModel = nil;
@implementation UserManager
@synthesize userModel = _userModel;

- (void)setUserModel:(UserModel *)userModel {
   
    if ( [[UserManager sharedManager] isLoad]) {
        _userModel = [[UserManager sharedManager] getUserInfo];
    } else {
        _userModel = nil;
    }
    
}
// 单利
+ (instancetype)sharedManager
{
    static UserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [self new];
    });
    return userManager;
    
}

- (UserModel *)userModel
{
    return [self getUserInfo];
}
//保存用户信息
- (void)savaUserInfoWith:(UserModel *)entity
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:entity];
    [userD setObject:data forKey:KEY];
    entity.Auth = [entity.Auth stringByAppendingString:@",lvjie"];
    NSArray *array = [entity.Auth componentsSeparatedByString:@","];
//    [XLYuMengNotificationTool XLYuMengNotificationToolWithuid:entity.Uid withtype:XLYuMengNotificationToolTypeFrom withXLYuMengNotificationToolPersonAuthtags:array];
    //NSUserDefaults 不是立即写入,需要我们进行同步一下.
    [userD synchronize];
    

}

//清空用户信息
- (void)cleanUserInfo
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    
    [userD removeObjectForKey:KEY];
    
    [userD synchronize];
    _userModel = nil;
}

//获取用户信息
- (UserModel *)getUserInfo
{   UserModel *userModel;
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSData *data = [userD objectForKey:KEY];
    userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (userModel) {
        _userModel = userModel;
        return _userModel;
    } else {
        _userModel = nil;
        return nil;
    }

}

//判断是否登录
- (BOOL)isLoad
{
    if ([self getUserInfo]) {
        return YES;
    } else {
        return NO;
    }
}


// App版本号
- (NSString *)AppVersion {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

//是否显示新特性
- (BOOL)isDisplayGuidePage
{
    if ([self.AppVersion isEqualToString:UserDefaultObjectForKey(theKeyForGuide)]) {// 不用显示引导页
        return NO;
    }
    // 清除用户信息
    [self cleanUserInfo];
    _userModel = nil;
    UserDefaultSetObjectForKey(self.AppVersion, theKeyForGuide);
    return YES;// 显示引导页
}






@end
