//
//  PenCell.m
//  maoGang
//
//  Created by xl on 2018/11/24.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "PenCell.h"

@implementation PenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.yeView.backgroundColor = BACKCOLOR;
    self.downLoadBtn.backgroundColor = RGBCOLOR(241, 242, 244);
    self.downLoadBtn.layer.cornerRadius = 22.5/2.f;
    self.downLoadBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)downLoadAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(downLoadFontWithCell:model:IndexPath:)]) {
        [self.delegate downLoadFontWithCell:self model:self.model IndexPath:self.indexPath];
    }
}

@end
