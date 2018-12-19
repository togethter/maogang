//
//  AlertPool.m
//  LvJie
//
//  Created by bilin on 2017/1/14.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "AlertPool.h"

@implementation AlertPool
+ (void)alertMessage:(NSString *)message xlViewController:(UIViewController *)viewController WithBlcok:(alertActionBlock)alertBlock
{
    if (!(viewController && [viewController isKindOfClass:[UIViewController class]])) {
        return;
    }
    if ([message isKindOfClass:[NSString class]]) {// 如果是字符串
        UIAlertController *Longalert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (alertBlock) {
                alertBlock();
            }
        }];
        [Longalert addAction:queding];
        [viewController presentViewController:Longalert animated:YES completion:nil];
        
    } else {//  不是的话
        UIAlertController *Longalert = [UIAlertController alertControllerWithTitle:@"提示" message:@"结构体返回错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (alertBlock) {
                alertBlock();
            }
        }];
        [Longalert addAction:queding];
        [viewController presentViewController:Longalert animated:YES completion:nil];
    }
}

/** 开启权限*/
+ (void)alertPermissionsWithSomeMessage:(NSString *)message selectedType:(NSString *)selectedType WithXlViewController:(UIViewController *)viewController
{
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *queding = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:selectedType style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 跳转到设置项
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }];
    [alerVC addAction:queding];
    [alerVC  addAction:ok];
    
    [viewController.navigationController presentViewController:alerVC animated:YES completion:nil];
    
}

+ (void)alertTitle:(NSString *)message withOk:(NSString *)ok withNot:(NSString *)no withVC:(UIViewController *)viewController withOkBlock:(void(^)())okBlock withnNoOkBlock:(void(^)())noOkBlock
{
    
    if (!(viewController && [viewController isKindOfClass:[UIViewController class]])) {
        return;
    }
    if ([message isKindOfClass:[NSString class]]) {// 如果是字符串
        if (!IS_VALID_STRING(ok)) {
            ok = @"确定";
        }
        UIAlertController *Longalert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *queding = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (okBlock) {
                okBlock();
            }
        }];
        [Longalert addAction:queding];
        [viewController presentViewController:Longalert animated:YES completion:nil];
        if (!IS_VALID_STRING(no)) {
            no = @"取消";
        }
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:no style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (noOkBlock) {
                noOkBlock();
            }
        }];
        [Longalert addAction:cancle];
    } else {//  不是的话
        UIAlertController *Longalert = [UIAlertController alertControllerWithTitle:@"提示" message:@"结构体返回错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (okBlock) {
                okBlock();
            }
        }];
        [Longalert addAction:queding];
        [viewController presentViewController:Longalert animated:YES completion:nil];
    }
}


@end
