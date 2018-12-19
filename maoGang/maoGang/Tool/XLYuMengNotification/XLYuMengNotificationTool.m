//
//  XLYuMengNotificationTool.m
//  LvJie
//
//  Created by bilin on 2018/2/5.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#import "XLYuMengNotificationTool.h"
NSString *const XLYuMengNotificationToolTypeFrom = @"maogang";
//
NSString *const XLYuMengNotificationToolAppKey = @"5c175471b465f5428d00023f";

@implementation XLYuMengNotificationTool
//+ (void)XLYuMengNotificationToolWithuid:(NSString *)uid withtype:(NSString *)typefrome withXLYuMengNotificationToolPersonAuthtags:(NSArray *)authTagsArray
//{
//    // 移除
//    [UMessage removeAlias:uid type:typefrome response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//        DLog(@"%@", responseObject);
//        DLog(@"%@", error);
//
//        [UMessage removeAllTags:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
//            DLog(@"%@", responseObject);
//            DLog(@"%@", error);
//            [UMessage setAlias:uid type:typefrome response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//                DLog(@"%@", responseObject);
//                DLog(@"%@", error);
//                if (IS_VALID_ARRAY(authTagsArray)) {
//                    for (NSString *auth in authTagsArray) {
//                        [UMessage addTag:auth response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
//                            DLog(@"%@", responseObject);
//                            DLog(@"%@", error);
//                        }];
//                    }
//                }
//            }];
//        }];
//    }];
//
//}
+ (void)XLYuMengNotificationToolWithuid:(NSString *)uid withtype:(NSString *)typefrome withXLYuMengNotificationToolPersonAuthtags:(NSArray *)authTagsArray
{
    // 移除
    [UMessage removeAlias:uid type:typefrome response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        DLog(@"%@", responseObject);
        DLog(@"%@", error);
        if (IS_VALID_ARRAY(authTagsArray)) {
           
            [UMessage deleteTags:authTagsArray response:^(id  _Nullable responseObject, NSInteger remain, NSError * _Nullable error) {
                
                
            }];
            
        }
    
    }];
    
}
+ (void)XLYuMengNotificationToolwithappKey:(NSString *)appKey withlaunchoptions:(NSDictionary *)launchOptions withAppDelegate:(AppDelegate<UNUserNotificationCenterDelegate> *)delegate
{
    [UMConfigure initWithAppkey:appKey channel:@"App Store"];
//    [UMessage startWithAppkey:appKey launchOptions:launchOptions httpsEnable:YES];
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc]init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types =  UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = delegate;
    } else {
        // Fallback on earlier versions
    }
    
    
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        }else{
            NSLog(@"error:%@",error.description);
        }
        
    }];
     // 线上的 发布的NO 线下为YES
    [UMessage openDebugMode:YES];
    [UMessage setBadgeClear:NO];
    [UMConfigure setLogEnabled:YES];
}
@end
