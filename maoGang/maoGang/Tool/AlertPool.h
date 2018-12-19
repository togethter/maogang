//
//  AlertPool.h
//  LvJie
//
//  Created by bilin on 2017/1/14.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^alertActionBlock)();

@interface AlertPool : NSObject
// 提示确定的提框带有一个 block
+ (void)alertMessage:(NSString *)message xlViewController:(UIViewController *)viewController WithBlcok:(alertActionBlock)alertBlock;
// 关于权限的
+ (void)alertPermissionsWithSomeMessage:(NSString *)message selectedType:(NSString *)selectedType WithXlViewController:(UIViewController *)viewController;

// 带有取消和确定的
+ (void)alertTitle:(NSString *)message withOk:(NSString *)ok withNot:(NSString *)no withVC:(UIViewController *)viewController withOkBlock:(void(^)())okBlock withnNoOkBlock:(void(^)())noOkBlock;

@end
