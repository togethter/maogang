//
//  YLPushApsModel.h
//  maoGang
//
//  Created by zhangzhen on 2018/12/18.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLPushApsModel : BaseModel

@property(nonatomic,copy)NSString * badge;
@property(nonatomic,copy)NSString * sound;

@property(nonatomic,strong)NSDictionary * alert;


@end


NS_ASSUME_NONNULL_END
