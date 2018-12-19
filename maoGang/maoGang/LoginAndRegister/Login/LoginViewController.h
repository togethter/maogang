//
//  LoginViewController.h
//  LvJie
//
//  Created by bilin on 2017/1/5.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//


#import "YLRootViewController.h"

@class UserModel;
@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewControllerLoginAction:(UserModel *)userModel;

@end
@interface LoginViewController : YLRootViewController

@property (nonatomic, weak) id <LoginViewControllerDelegate>delegate;



/**
 *跳转到 某个界面
 */
@property(nonatomic,copy)NSString * typeClass;
/**
 *链接  url
 */




@end
