//
//  NotingCell.h
//  maoGang
//
//  Created by xl on 2018/11/24.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NotingCell;
@protocol NotingCellDelegate <NSObject>
@optional;
- (void)notingCellDidSelectWithModel:(id)model sender:(NotingCell *)cell;

@end
@interface NotingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *yeView;
@property (weak, nonatomic) IBOutlet UIImageView *placeHold;
@property (weak, nonatomic) IBOutlet UILabel *desL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, weak) id<NotingCellDelegate>  delegate;


@end

NS_ASSUME_NONNULL_END
