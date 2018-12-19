//
//  AlertBox.h
//  chartRoom
//
//  Created by xl on 2018/10/11.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^alertActionBlock)(void);

@interface AlertBox : NSObject
+ (void)alertMessage:(NSString *)message xlViewController:(UIViewController *)viewController WithBlcok:(alertActionBlock)alertBlock;
+ (void)alertWithSomeMessage:(NSString *)message selectedType:(NSString *)selectedType withNavigationController:(UINavigationController *)naVC;
+ (void)alertTitle:(NSString *)message withOk:(NSString *)ok withNot:(NSString *)no withVC:(UIViewController *)viewController withOkBlock:(void(^)())okBlock withnNoOkBlock:(void(^)())noOkBlock;
@end

NS_ASSUME_NONNULL_END
