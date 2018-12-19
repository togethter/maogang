//
//  NotingCell.m
//  maoGang
//
//  Created by xl on 2018/11/24.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "NotingCell.h"

@implementation NotingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.yeView.backgroundColor = BACKCOLOR;
    self.btn.layer.cornerRadius = 22.5/2.f;
    self.btn.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)getAc:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(notingCellDidSelectWithModel:sender:)]) {
        [self.delegate notingCellDidSelectWithModel:nil sender:self];
    }
}

@end
