//
//  MyCustomCell.m
//  maoGang
//
//  Created by xl on 2018/11/29.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "MyCustomCell.h"

@implementation MyCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topView.backgroundColor = BACKCOLOR;
    self.desL.textColor = RGBCOLOR(110, 110, 110);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
