//
//  BindingMobilePhoneViewController.h
//  LvJie
//
//  Created by bilin on 2017/10/9.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLBindingMobilePhoneViewController : YLRootViewController
/**
 *微信唯一标识
 */
@property(nonatomic,copy)NSString * OpenId;
/**
 *授权渠道  1QQ  2微信
 */
@property(nonatomic,copy)NSString * type;



@end
