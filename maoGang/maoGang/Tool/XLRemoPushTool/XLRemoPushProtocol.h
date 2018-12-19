//
//  XLRemoPushProtocol.h
//  LvJie
//
//  Created by bilin on 2018/2/24.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
// 模型需要遵循的协议

#import <Foundation/Foundation.h>

@protocol XLRemoPushProtocol <NSObject>
@required
- (NSString *)XLRemoPushProtocolAfter_open;
@optional
- (NSString *)XLRemoPushProtocolUrl;
@optional
- (NSString *)XLRemoPushProtocolActivity;
@required
- (NSDictionary *)XLRemoPushProtocolopenType;
@required
- (NSString *)XLRemoPushProtocolIsLogin;


@end
