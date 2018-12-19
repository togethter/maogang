//
//  XLRemoPushTool.m
//  LvJie
//
//  Created by bilin on 2018/2/24.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "XLRemoPushTool.h"
#import "XLRemoPushModel.h"
#import "XLRemotoNotificationWebViewController.h"// 远程推送的web页面
#import "PushSingleton.h"
#import "LoginViewController.h"
@implementation XLRemoPushTool

+ (void)xlRemoPushToolWithRemoDic:(NSDictionary *)remoDic
{
    if (remoDic && [remoDic isKindOfClass:[NSDictionary class]]) {// 如果是字典的话做一些操作
        XLRemoPushModel *model = [XLRemoPushModel loadModelWithDictionary:remoDic[@"openType"]];
        NSDictionary *openType = remoDic[@"extra"];
        if ([openType isKindOfClass:[NSDictionary class]]) {
           id jj = openType[@"IsLogin"];
            if (IS_VALID_STRING(jj) || [jj isKindOfClass:[NSNumber class]]) {
                model.IsLogin = [NSString stringWithFormat:@"%@",jj];
            } else {
                model.IsLogin = @"";// 不需要登录啥也不设置
            }
        }
        model.extra = openType;
        [self XLPushToolWithModel:model];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = -1;

}

//"go_app": 打开应用
//      "go_url": 跳转到URL
//      "go_activity": 打开特定的viewController

+ (void)XLPushToolWithModel:(id<XLRemoPushProtocol>)model
{
    if (model && [model conformsToProtocol:@protocol(XLRemoPushProtocol)]) {// 模型存在并且遵守了协议
     
        if (XLRespondsToSelector(model, XLRemoPushProtocolAfter_open)) {
           
            NSString *after_open = [model XLRemoPushProtocolAfter_open];
            
            if (IS_VALID_STRING(after_open)) {
                if ([after_open isEqualToString:@"go_app"]) {// 啥操作都没有
                    
                } else if ([after_open isEqualToString:@"go_url"]) {// 打开web页面
                    // 所有的导航条返回到最前方然后跳转到web
                    
                    if (XLRespondsToSelector(model, XLRemoPushProtocolUrl)) {
                        if (XLRespondsToSelector(model, XLRemoPushProtocolIsLogin)) {
                            NSString *xlisLogin = [model XLRemoPushProtocolIsLogin];
                            if (IS_VALID_STRING(xlisLogin)) {
                                if ([xlisLogin isEqualToString:@"1"]) {//需要登录
                                    NSString *token = TOKEN;
                                    if (!IS_VALID_STRING(token)) {// 没有登录
                                        LoginViewController *login = [[LoginViewController alloc] init];
                                        NSString *url = [model XLRemoPushProtocolUrl];
                                        XLRemotoNotificationWebViewController *webViewController = [[XLRemotoNotificationWebViewController alloc] init];
                                        webViewController.url = url;
                                        UIWindow *window =  [UIApplication sharedApplication].delegate.window;
                                        // 获取导航控制器
                                        UITabBarController *tabVC = (UITabBarController *)window.rootViewController;
                                        if (![tabVC isKindOfClass:[UITabBarController class]]) {
                                            return;
                                        }
                                        UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                                        PushSingleton *pushsingleton = [PushSingleton pushSharedInstance];
                                        pushsingleton.navc = pushClassStance;
                                        pushsingleton.vc = webViewController;
                                        [pushClassStance pushViewController:login animated:YES];
                                        
                                        return;
                                    } else {
                                        XLRemotoNotificationWebViewController *webViewController = [[XLRemotoNotificationWebViewController alloc] init];
                                        NSString *url = [model XLRemoPushProtocolUrl];
                                        PushSingleton *singleTon = [PushSingleton pushSharedInstance];
                                        url = [singleTon combinationParameter:url withToken:token];
                                        webViewController.url = url;
                                        UIWindow *window =  [UIApplication sharedApplication].delegate.window;
                                        // 获取导航控制器
                                        UITabBarController *tabVC = (UITabBarController *)window.rootViewController;
                                        if (![tabVC isKindOfClass:[UITabBarController class]]) {
                                            return;
                                        }
                                        UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                                        // 跳转到对应的控制器
                                        [pushClassStance pushViewController:webViewController animated:YES];
                                        return;
                                    }

                                } else if ([xlisLogin isEqualToString:@"0"]) {// 不需要登录
                                    XLRemotoNotificationWebViewController *webViewController = [[XLRemotoNotificationWebViewController alloc] init];
                                    NSString *url = [model XLRemoPushProtocolUrl];
                                    webViewController.url = url;
                                    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
                                    // 获取导航控制器
                                    UITabBarController *tabVC = (UITabBarController *)window.rootViewController;
                                    if (![tabVC isKindOfClass:[UITabBarController class]]) {
                                        return;
                                    }
                                    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                                    // 跳转到对应的控制器
                                    [pushClassStance pushViewController:webViewController animated:YES];
                                    return;

                                }
                            }
                        }
                    }

                } else if ([after_open isEqualToString:@"go_activity"]) {// 打开ViewController
                    // 所有的导航条返回到最前方然后跳转到指定的页面
                    if (XLRespondsToSelector(model, XLRemoPushProtocolopenType)) {
                        NSDictionary *dic = [model XLRemoPushProtocolopenType];
                        NSString *classStr = nil;
                        if (XLRespondsToSelector(model, XLRemoPushProtocolActivity)) {
                            classStr = [model XLRemoPushProtocolActivity];
                        }
                        const char *className = [classStr cStringUsingEncoding:NSASCIIStringEncoding];
                        
                        // 从一个字串返回一个类
                        Class newClass = objc_getClass(className);
                        if (!newClass)
                        {
                            return;
                         
                        }
                        // 创建对象
                        id instance = [[newClass alloc] init];
                        if (!instance) {// 这里就说明跳转的有问题
                            return;
                        }
                        NSString *xlisLogin = [model XLRemoPushProtocolIsLogin];// 是否需要登录的1 需要登录 0 不需要登录

                        if (IS_VALID_STRING(xlisLogin)) {
                            if ([xlisLogin isEqualToString:@"1"]) {// 需要登录
                                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                                    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                        if ([key isEqualToString:@"IsLogin"]) {
                                            return;
                                        }
                                        // 检测这个对象是否存在该属性
                                        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
                                            // 利用kvc赋值
                                           
                                            [instance setValue:obj forKey:key];
                                        }
                                    }];
                                }
                                UIWindow *window =  [UIApplication sharedApplication].delegate.window;
                                // 获取导航控制器
                                UITabBarController *tabVC = (UITabBarController *)window.rootViewController;
                                NSMutableArray *controllerArray = [NSMutableArray array];
                                [controllerArray addObjectsFromArray:@[@"XLNewsViewController",@"ContractViewController",@"ZZDiabetesMellitusViewController",@"YLFoundViewController",@"YLMyViewController",]];
                                NSString *xlClassNameString = [NSString stringWithUTF8String:className];
                                if (![tabVC isKindOfClass:[UITabBarController class]]) {// 如果不是tableBarViewController的话直接返回就好了
                                    return;
                                }
                                if (IS_VALID_STRING(xlClassNameString)) {
                                    if ([tabVC isKindOfClass:[UITabBarController class]]) {// 如果是tabl
                                        if ([controllerArray containsObject:xlClassNameString]) {
                                            NSInteger index = [controllerArray indexOfObject:xlClassNameString];
                                            tabVC.selectedIndex = index;
                                            NSArray *array = tabVC.viewControllers;
                                            for (UINavigationController *navc in array) {
                                                [navc popToRootViewControllerAnimated:YES];
                                            }
                                            return;
                                        }
                                    }
                                }
                                
                                UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];

                                // 跳转到对应的控制器
                                NSString *token = TOKEN;
                                if (!IS_VALID_STRING(token)) {// 没有登录过
                                    PushSingleton *pushSingleton = [PushSingleton pushSharedInstance];
                                    pushSingleton.vc = instance;
                                    pushSingleton.navc = pushClassStance;
                                    LoginViewController *loginVC = [[LoginViewController alloc] init];
                                    // push 过去到登录页面去 如果他不想登陆也没有办法了
                                    [pushClassStance pushViewController:loginVC animated:YES];
                                } else {// 登录过
                                    [pushClassStance pushViewController:instance animated:YES];

                                }
                                
                                return;
                            } else if ([xlisLogin isEqualToString:@"0"]) {// 不需要登录
                                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                                    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                        if ([key isEqualToString:@"IsLogin"]) {
                                            return;
                                        }
                                        // 检测这个对象是否存在该属性
                                        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
                                            // 利用kvc赋值
                                            [instance setValue:obj forKey:key];
                                        }
                                    }];
                                }
                                
                                UIWindow *window =  [UIApplication sharedApplication].delegate.window;
                                // 获取导航控制器
                                UITabBarController *tabVC = (UITabBarController *)window.rootViewController;
                                if (![tabVC isKindOfClass:[UITabBarController class]]) {
                                    return;
                                }
                                NSMutableArray *controllerArray = [NSMutableArray array];
                                [controllerArray addObjectsFromArray:@[@"XLNewsViewController",@"ContractViewController",@"ZZDiabetesMellitusViewController",@"YLFoundViewController",@"YLMyViewController",]];
                                NSString *xlClassNameString = [NSString stringWithUTF8String:className];
                              
                                if (IS_VALID_STRING(xlClassNameString)) {
                                    if ([tabVC isKindOfClass:[UITabBarController class]]) {// 如果是tabl
                                        if ([controllerArray containsObject:xlClassNameString]) {
                                            NSInteger index = [controllerArray indexOfObject:xlClassNameString];
                                            tabVC.selectedIndex = index;
                                            NSArray *array = tabVC.viewControllers;
                                            for (UINavigationController *navc in array) {
                                                [navc popToRootViewControllerAnimated:YES];
                                            }
                                            return;
                                        }
                                    }
                                }
                                
                                UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
                                // 跳转到对应的控制器
                                [pushClassStance pushViewController:instance animated:YES];
                            }
                        }
                        
                        

                    }
                    
                }
                
            }
        }
        
    }
}



/**
 *  检测对象是否存在该属性
 */
+  (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}


@end
