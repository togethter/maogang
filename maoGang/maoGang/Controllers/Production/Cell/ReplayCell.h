//
//  ReplayCell.h
//  LvJie
//
//  Created by bilin on 2018/1/31.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLReplyPostModel.h"

@protocol ReplayCellDelegate<NSObject>

- (void)ReplayCellDidSelectPic:(YLReplyPostModel *)model;

- (void)ReplayCellDidDeletewithModel:(YLReplyPostModel *)model;

@end
@interface ReplayCell : UITableViewCell
@property (nonatomic, strong) YLReplyPostModel *model;
@property (nonatomic, weak) id<ReplayCellDelegate> delegate;

@end
