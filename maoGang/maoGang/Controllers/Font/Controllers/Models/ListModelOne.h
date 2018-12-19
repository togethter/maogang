//
//  ListModelOne.h
//  maoGang
//
//  Created by xl on 2018/12/10.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListModelOne : BaseModel
//Author = "";
//IsAdult = 1;
//IsHigh = 1;
//IsMiddle = 1;
//IsPrimary = 1;
//PoetryId = 4298;
//PoetryName = "\U5de6";
//PoetrysTypeId = 5;
@property (nonatomic, copy) NSString * PoetryId;// 编号
@property (nonatomic, copy) NSString * PoetrysTypeId;// 类型编号
@property (nonatomic, copy) NSString * PoetryName;// 标题
@property (nonatomic, copy) NSString * Author;// 作者


@end

NS_ASSUME_NONNULL_END
