//
//  XLFontCollectionCell.h
//  maoGang
//
//  Created by xl on 2018/12/21.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XLFontCollectionCell : UICollectionViewCell
@property (nonatomic, strong)  UIImageView *imageView;
@property (nonatomic, strong)  UILabel     *textTitle;
@property (nonatomic, strong) NSArray *array;// 文字数组
@property (nonatomic, strong) NSIndexPath *indexPath;// 下表
@property (nonatomic, weak) CustomAlertModel *alertModel;
@end

NS_ASSUME_NONNULL_END
