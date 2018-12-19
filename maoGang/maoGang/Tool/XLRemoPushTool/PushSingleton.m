//
//  PushSingleton.m
//  LvJie
//
//  Created by bilin on 2018/3/8.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "PushSingleton.h"
#import "XLRemotoNotificationWebViewController.h"
@implementation PushSingleton
+ (instancetype)pushSharedInstance
{
    static PushSingleton *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PushSingleton new];
    });
    return instance;
}
- (void)clearNavcAndVC
{
    self.navc  = nil;
    self.vc = nil;
}
- (void)configurationRemoToPushWith:(BaseModel *)model
{
    PushSingleton *pushSingleton = [PushSingleton pushSharedInstance];
    if (pushSingleton.vc && [pushSingleton.vc isKindOfClass:[XLRemotoNotificationWebViewController class]]) {
        XLRemotoNotificationWebViewController *vc = (XLRemotoNotificationWebViewController *)pushSingleton.vc;
        NSString *url = vc.url;
        url = [self combinationParameter:url withToken:model.userModel.Token];
        vc.url = url;
        [pushSingleton.navc pushViewController:vc animated:YES];// 先push
        //然后在将单利中的vc 以及navc 制空
        [pushSingleton clearNavcAndVC];
        
    } else if (pushSingleton.vc) {
        UIViewController *vc = [pushSingleton vc];
        UINavigationController *nav = [pushSingleton navc];
        [nav pushViewController:vc animated:YES];
        [pushSingleton clearNavcAndVC];
    }
}
- (NSString *)combinationParameter:(NSString *)url withToken:(NSString *)token
{
    if (!IS_VALID_STRING(url) && !IS_VALID_STRING(token)) {
        return @"";
    }
    if ([url containsString:@"?"] && [url containsString:@"&"]) {// 如果都存在？& 说明之前存在参数的现在只需要登录的token
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&token=%@",token]];
    } else if ([url containsString:@"?"] && ![url containsString:@"&"]) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"token=%@",token]];
    } else if (![url containsString:@"?"]&&![url containsString:@"&"]) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?token=%@",token]];
    }
    return url;
}
@end
