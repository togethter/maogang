//
//  LikeUserTableViewCell.h
//  gaofangPenYouQuan
//
//  Created by zhangzhen on 2018/11/19.
//  Copyright © 2018 zhangzhen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN


@protocol LikeUserTableViewCelldelegate <NSObject>
-(void)didSelectPeople:(NSDictionary *)dic;

@end

extern NSString * const prefixStr;
@class CircleItem;
@interface LikeUserTableViewCell : BaseTableViewCell

@property(nonatomic,weak)id<LikeUserTableViewCelldelegate>delegate;
-(void)setContentData:(CircleItem *)item;


@end

NS_ASSUME_NONNULL_END
