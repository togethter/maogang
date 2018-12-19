//
//  PromptNetworkBadManager.m
//  ChongFa
//
//  Created by bilin on 16/9/6.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import "PromptNetworkBadManager.h"
//#import "NetworkReachabilityManager.h"
#import "MBProgressHUD.h"
#import "AFNetworkReachabilityManager.h"
#import "YLRootViewController.h"

@implementation PromptNetworkBadManager

+ (BOOL)quchuAction:(UIViewController *)vc
{
//    if ([vc isKindOfClass:[LoginViewController class]] || [vc isKindOfClass:[ForgetPassWordViewController class]] || [vc isKindOfClass:[ResetPassWordViewController class]]|| [vc isKindOfClass:[YLMyViewController class]]|| [vc isKindOfClass:[RegisterViewController class]]|| [vc isKindOfClass:[ResetPassWordViewController class]]|| [vc isKindOfClass:[ChangeXPassWordViewController class]]) {
//        return YES;
//    }
    return YES;
}

/**
 *  提示网络不好的工具类
 */
+ (BOOL)promptNetworkBadWithCode:(NSInteger)code withVC:(UIViewController *)VC
{

    if (code == -1001) {// 请求超时
        if ([VC isKindOfClass:[YLRootViewController class]]) {
            YLRootViewController *xlRootVC = (YLRootViewController *)VC;
            xlRootVC.netWorkCustomView.networkEnum = AlertCustomViewForNetworkTimeOut;
            xlRootVC.netWorkCustomView.hidden = NO;
            if ([VC isKindOfClass:[UIViewController class]]) {
                [VC.view endEditing:YES];
            }
            
        }
//        [self showMessage:@"未检测到可用网络,请检查网络是否畅通" toView:VC.view];
        return NO;
        
    }else if (code == -1009) {// 与网络断断开连接
        if ([VC isKindOfClass:[YLRootViewController class]]) {
            YLRootViewController *xlRootVC = (YLRootViewController *)VC;
            xlRootVC.netWorkCustomView.networkEnum = AlertCustomViewForNetworkNoNetwork;
            xlRootVC.netWorkCustomView.hidden = NO;
            if ([VC isKindOfClass:[UIViewController class]]) {
                [VC.view endEditing:YES];
            }
        }
//        [self showMessage:@"未检测到可用网络,请检查网络是否畅通" toView:VC.view];
        return NO;
    } else {
        AFNetworkReachabilityManager  *manager = [AFNetworkReachabilityManager sharedManager];
        
        if (manager.reachable) {
            return manager.reachable;
            
        } else {
            if (VC) {// 如果试图控制器存在的话在去处理
                
                
                if ([VC isKindOfClass:[YLRootViewController class]]) {
                  BOOL isok =  [self quchuAction:VC];
                    if (isok) {
                    [self showMessage:@"未检测到可用网络,请检查网络是否畅通" toView:VC.view];

                    } else {
//                        ((YLRootViewController *)VC).xlQuanXian = XForWuWangluo;
                        if ([VC isKindOfClass:[UIViewController class]]) {
                            [VC.view endEditing:YES];
                        }
                    }
                   
                }
            }
        }

    }
    
    return NO;

}



+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];

    
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = YES;
    if (IS_VALID_STRING(message)) {
       hud.labelText = message;
    }else{
      hud.labelText = @"结构体返回错误";
    }
    
    // 设置图片
    //   hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
    

}

@end
