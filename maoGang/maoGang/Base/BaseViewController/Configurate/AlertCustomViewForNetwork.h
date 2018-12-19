//
//  AlertCustomViewForNetwork.h
//  LvJie
//
//  Created by bilin on 2017/12/6.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
// 

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AlertCustomViewForNetworkTimeOut,//超时
    AlertCustomViewForNetworkNoNetwork,// 无网络
     AlertCustomViewForNetworError,// 出错了
    
} AlertCustomViewForNetworkEnum;
@protocol alertCustomViewForNetworkDelegate <NSObject>
// 重新加载的方法
- (void)reloadRequsetAction:(UIButton *)sender;

/**开启网络权限*/
- (void)OpenNetworkAccess;

@end
@interface AlertCustomViewForNetwork : UIView
@property (nonatomic, assign) AlertCustomViewForNetworkEnum networkEnum;
@property (nonatomic, weak) id<alertCustomViewForNetworkDelegate>delegate;
+ (instancetype)alertCustomViewForNetworkWithDelegte:(id<alertCustomViewForNetworkDelegate>)delegate;

@end
