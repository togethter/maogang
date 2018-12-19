//
//  XLWebHelper.h
//  chongfa
//
//  Created by bilin on 2017/3/28.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**  1用户协议  2 支付协议 3 协议声明 */
typedef enum: NSInteger {
    EWebTypeAbout,// 源于我们
    
}EWebType;
typedef void(^requestBlock)(NSURLRequest *requset);
@interface XLWebHelper : NSObject
+ (void)xlWebHeler:(EWebType)webType  withRequestBlock:(requestBlock)requestBlock
            withVC:(UIViewController *)VC;
@end
