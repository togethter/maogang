//
//  YLUMpushVCTool.m
//  maoGang
//
//  Created by zhangzhen on 2018/12/13.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "YLUMpushVCTool.h"
#import "YLPushUMModel.h"
#import "TBTabBarController.h"
#import "YLNacigationViewController.h"
#import "YLPublishedWorksViewController.h"
#import "MessageViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "XLRemotoNotificationWebViewController.h"


@implementation YLUMpushVCTool

+(void)pushVCwithDic:(NSDictionary *)dic{
     [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
    YLPushUMModel * model = [YLPushUMModel loadModelWithDictionary:dic];
    DLog(@"dic-%@,body--%@",dic,model.apsModel.alert[@"body"]) ;
    
    
     TBTabBarController * tab =(TBTabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
     YLNacigationViewController * nav = (YLNacigationViewController*)tab.childViewControllers[tab.selectedIndex];
     UIViewController * selectedvc = [YLUMpushVCTool currentViewController];
    
    if ([model.psy isEqualToString:@"1"]) {//跳转到 tab中的某个界面
        
        //模态界面
        if ([selectedvc isKindOfClass:[YLPublishedWorksViewController class]]||[selectedvc isKindOfClass:[ZLPhotoPickerBrowserViewController class]]) {//在 发布界面
            [selectedvc dismissViewControllerAnimated:NO completion:nil];
            if (nav.childViewControllers.count>0) {
              [nav popToRootViewControllerAnimated:YES];
            }
            if (tab.selectedIndex==2) {//当前在  我的
                if (isLogin) {//登录状态
                    MessageViewController * mesvc = [[MessageViewController alloc]init];
                    [nav pushViewController:mesvc animated:YES];
                }else{//非登录状态
                    DLog(@"停留在 我的界面");
                }
                
            }else{//在其他两个 tab
                tab.selectedIndex = 2;
                YLNacigationViewController * navs = (YLNacigationViewController*)tab.childViewControllers[tab.selectedIndex];
                if (isLogin) {//登录状态
                    MessageViewController * mesvc = [[MessageViewController alloc]init];
                    [navs pushViewController:mesvc animated:YES];
                }else{//非登录状态
                    DLog(@"停留在 我的界面");
                }
                
            }
            
        }else{
            // push 界面
            if (selectedvc.navigationController.childViewControllers.count>0) {
                [selectedvc.navigationController popToRootViewControllerAnimated:YES];
            }
            
            if (tab.selectedIndex==2) {//当前在  我的
                
                if (isLogin) {//登录状态
                    MessageViewController * mesvc = [[MessageViewController alloc]init];
                    [nav pushViewController:mesvc animated:YES];
                }else{//非登录状态
                    DLog(@"停留在 我的界面");
                }
            
            }else{//在其他两个 tab
                tab.selectedIndex = 2;
                YLNacigationViewController * nav = (YLNacigationViewController*)tab.childViewControllers[tab.selectedIndex];
                if (isLogin) {//登录状态
                    MessageViewController * mesvc = [[MessageViewController alloc]init];
                    [nav pushViewController:mesvc animated:YES];
                }else{//非登录状态
                    DLog(@"停留在 我的界面");
                }
   
            }
            
            
        }
        
        
        
    }else if ([model.psy isEqualToString:@"2"]){//跳转到 web
        if ([selectedvc isKindOfClass:[YLPublishedWorksViewController class]]||[selectedvc isKindOfClass:[ZLPhotoPickerViewController class]]) {
             [selectedvc dismissViewControllerAnimated:NO completion:nil];
            
        }
        XLRemotoNotificationWebViewController * webV = [[XLRemotoNotificationWebViewController alloc]init];
        webV.url = @"http://www.baidu.com";
        [nav pushViewController:webV animated:YES];
    }
    else if ([model.psy isEqualToString:@"3"]){
        
        
    }
    
}

+(UIViewController*)findBestViewController:(UIViewController*)vc {

    if (vc.presentedViewController) {
        [vc dismissViewControllerAnimated:YES completion:nil];
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];

    } else if ([vc isKindOfClass:[UISplitViewController class]]) {

        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;

    } else if ([vc isKindOfClass:[UINavigationController class]]) {

        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;

    } else if ([vc isKindOfClass:[UITabBarController class]]) {

        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;

    } else {

        // Unknown view controller type, return last child view controller
        return vc;

    }

}

+(UIViewController*)currentViewController {

    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];

}

@end
