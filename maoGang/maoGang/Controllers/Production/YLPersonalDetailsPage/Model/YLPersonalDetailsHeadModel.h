//
//  YLPersonalDetailsHeadModel.h
//  maoGang
//
//  Created by zhangzhen on 2018/11/30.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPersonalDetailsHeadModel : BaseModel

/**
 *用户编号
 */
@property(nonatomic,copy)NSString * MemberId;

/**
 *用户头像
 */
@property(nonatomic,copy)NSString * HeadPic;
/**
 *用户昵称
 */
@property(nonatomic,copy)NSString * Nick;
/**
 *是否关注
 */
@property(nonatomic,copy)NSString * IsFollow;
/**
 *用户粉丝数量
 */
@property(nonatomic,copy)NSString *  MyFansNum;
/**
 *用户签名
 */
@property(nonatomic,copy)NSString *  Autograph;





@end

NS_ASSUME_NONNULL_END
