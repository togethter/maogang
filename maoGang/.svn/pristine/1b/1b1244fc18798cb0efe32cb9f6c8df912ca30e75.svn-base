//
//  XLRemoPushModel.h
//  LvJie
//
//  Created by bilin on 2018/2/24.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
// 推送的模型

#import "BaseModel.h"
#import "XLRemoPushProtocol.h"

@interface XLRemoPushModel : BaseModel<XLRemoPushProtocol>

//      必填，值可以为:
//      "go_app": 打开应用
//      "go_url": 跳转到URL
//      "go_activity": 打开特定的viewController
@property (nonatomic, copy) NSString *after_open;
 //     当after_open=go_url时，必填。

@property (nonatomic, copy) NSString *url;
//      当after_open=go_activity时，必填。
// 通知栏点击后打开的activityViewController
@property (nonatomic, copy) NSString *activity;
// 是否登录 1 登录0 不登录
@property (nonatomic, copy) NSString *IsLogin;

/**     这个是网络请求的参数相关设置*/
@property (nonatomic, strong) NSDictionary *extra;


@end
