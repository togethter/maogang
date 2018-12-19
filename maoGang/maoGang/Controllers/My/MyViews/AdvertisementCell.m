//
//  AdvertisementCell.m
//  maoGang
//
//  Created by xl on 2018/11/29.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "AdvertisementCell.h"

@implementation AdvertisementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topView.backgroundColor = BACKCOLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
