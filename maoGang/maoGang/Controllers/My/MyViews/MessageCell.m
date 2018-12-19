//
//  MessageCell.m
//  maoGang
//
//  Created by xl on 2018/12/4.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.picImageView.layer.cornerRadius = 39.f/2;
    self.picImageView.layer.masksToBounds = YES;
    self.redView.layer.cornerRadius = 4.f/2;
    self.redView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
