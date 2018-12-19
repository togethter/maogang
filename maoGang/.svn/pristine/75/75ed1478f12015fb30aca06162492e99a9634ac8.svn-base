//
//  YLMyFansOfTableViewCell.m
//  maoGang
//
//  Created by zhangzhen on 2018/12/6.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "YLMyFansOfTableViewCell.h"

@implementation YLMyFansOfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.M_headImage.layer.cornerRadius = 39/2;
    self.M_headImage.layer.masksToBounds = YES;
    self.L_line.backgroundColor = LineBackgroundColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Initialization code
}

-(void)addModel:(YLMyFansOfModel *)model{
    
    if (IS_VALID_STRING(model.Nick)) {
        self.L_name.text = model.Nick;
    }
    if (IS_VALID_STRING(model.HeadPic)) {
        [self.M_headImage sd_setImageWithURL:[NSURL URLWithString:model.HeadPic]];
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
