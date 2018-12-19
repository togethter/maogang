//
//  PoetrysModel.h
//  maoGang
//
//  Created by xl on 2018/12/10.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PoetrysModel : BaseModel
//2     PoetrysTypeId    编号    是    [string]    查看
//3     PoetrysTypeName    标题    是    [string]    查看
//4     IsMulti    是否多层（1=是 10=否）    是    [string]
@property (nonatomic, copy) NSString *PoetrysTypeId;// 编号
@property (nonatomic, copy) NSString *PoetrysTypeName;// 标题
@property (nonatomic, copy) NSString *IsMulti;// 是否多层（1=是 10=否）

@end

NS_ASSUME_NONNULL_END
