//
//  PenCell.h
//  maoGang
//
//  Created by xl on 2018/11/24.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PenCell;
@protocol PenCellDelegate <NSObject>

- (void)downLoadFontWithCell:(PenCell *)cell model:(id )model IndexPath:(NSIndexPath *)indexPath;
@end
@interface PenCell : UITableViewCell
@property (nonatomic, weak) id<PenCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id model;
@property (weak, nonatomic) IBOutlet UIView *titleName;
@property (weak, nonatomic) IBOutlet UIView *imageVi;
@property (weak, nonatomic) IBOutlet UIView *yeView;
@property (weak, nonatomic) IBOutlet UIImageView *penImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@end

NS_ASSUME_NONNULL_END
