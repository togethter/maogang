//
//  YLLikeMemberModel.h
//  maoGang
//
//  Created by zhangzhen on 2018/11/28.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLLikeMemberModel : BaseModel

/**
 *点赞人昵称
 */
@property (nonatomic, copy) NSString * LikeMemberNick;


/**
 *点赞人id
 */
@property (nonatomic, copy) NSString * LikeMemberId;

/**
 *LikeId
 */
@property (nonatomic, copy) NSString * LikeId;

/**
 *PostId
 */
@property (nonatomic, copy) NSString * PostId;

/**
 *PostMemberId
 */
@property (nonatomic, copy) NSString * PostMemberId;









@end

NS_ASSUME_NONNULL_END
