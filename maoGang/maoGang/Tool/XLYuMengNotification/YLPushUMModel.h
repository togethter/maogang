//
//  YLPushUMModel.h
//  maoGang
//
//  Created by zhangzhen on 2018/12/13.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "BaseModel.h"
#import "YLPushApsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLPushUMModel : BaseModel
/**
 *自定义参  在aps外
 */
@property(nonatomic,copy)NSString * psy;

@property(nonatomic,strong)YLPushApsModel * apsModel;
@end




NS_ASSUME_NONNULL_END
