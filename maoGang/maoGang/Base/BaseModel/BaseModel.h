//
//  BaseModel.h
//  LeForProject
//
//  Created by zhangzhen on 2018/6/20.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface BaseModel : NSObject
// 提示的消息
@property (nonatomic, copy) NSString *message;
@property(nonatomic,copy)NSString * status;
@property (nonatomic, strong) NSDictionary *xlDic;
/** 用户的模型*/
@property (nonatomic, strong) UserModel *userModel;
/** 网络请求的返回的状态 200 ---成功， 500 -- 系统内部错误， 404 ---- 信息不存在，410 - tokenError, 414- TokenError, ,320- 图片大小超出限制, 321 -（图片格式不正确）, 310 - 系统内部错误（崇法错误）  300 ---- code错误 600 - 提交信息验证失败*/
@property (nonatomic, copy) NSString *Result;
/**
 *案源 返回成功关键词
 */
@property (nonatomic, copy) NSString *state;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

+(instancetype)loadModelWithDictionary:(NSDictionary *)dic;


@end
