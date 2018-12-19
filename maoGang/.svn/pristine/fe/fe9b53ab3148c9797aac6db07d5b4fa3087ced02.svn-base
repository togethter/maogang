//
//  CircleUserCell.h
//  gaofangPenYouQuan
//
//  Created by zhangzhen on 2018/11/19.
//  Copyright © 2018 zhangzhen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CircleUserCellDelegate <NSObject>

-(void)didSelectPeople:(NSDictionary *)dic;

@end


@class CircleItem;
@interface CircleUserCell : BaseTableViewCell

@property(nonatomic,weak)id<CircleUserCellDelegate>delegate;
- (void)setContentData:(CircleItem *)item index:(NSInteger)index;




@end

NS_ASSUME_NONNULL_END
