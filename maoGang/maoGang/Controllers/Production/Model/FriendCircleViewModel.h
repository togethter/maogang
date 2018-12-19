//
//  FriendCircleViewModel.h
//  gaofangPenYouQuan
//
//  Created by zhangzhen on 2018/11/19.
//  Copyright © 2018 zhangzhen. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class CircleItem;
@interface FriendCircleViewModel : BaseModel

- (NSMutableArray *)loadDatasDic:(NSDictionary *)dic;

- (NSMutableArray *)loadDatasDetails;

- (CGFloat)getHeaderHeight:(CircleItem *)item;
- (void)calculateItemHeight:(CircleItem *)item;

@end

NS_ASSUME_NONNULL_END
