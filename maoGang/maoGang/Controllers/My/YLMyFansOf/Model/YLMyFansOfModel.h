//
//  YLMyFansOfModel.h
//  maoGang
//
//  Created by zhangzhen on 2018/12/6.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLMyFansOfModel : BaseModel
/**
 *头像
 */
@property(nonatomic,copy)NSString * HeadPic;
/**
 *id
 */
@property(nonatomic,copy)NSString * MemberId;
/**
 *姓名
 */
@property(nonatomic,copy)NSString * Nick;



@end

NS_ASSUME_NONNULL_END
