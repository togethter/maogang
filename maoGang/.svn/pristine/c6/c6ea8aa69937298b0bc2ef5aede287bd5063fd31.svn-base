//
//  ReplayCell.m
//  LvJie
//
//  Created by bilin on 2018/1/31.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "ReplayCell.h"
#import "NSString+Extension.h"



@interface ReplayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;


@property (weak, nonatomic) IBOutlet UILabel *desLb;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *whoTypeWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *whoTypeHeight;

@end
@implementation ReplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lineView.backgroundColor = LineBackgroundColor;
    self.lineView.hidden = YES;
    self.desLb.font = [UIFont systemFontOfSize:14];
    self.nameLb.textColor = RGBCOLOR(49, 124, 201);
    self.nameLb.font = [UIFont systemFontOfSize:15];
    self.desLb.textColor = RGBCOLOR(0, 0, 0);
//    self.desLb.backgroundColor = [UIColor purpleColor];
    
    self.dateLb.font = [UIFont systemFontOfSize:12];
    self.dateLb.textColor = RGBCOLOR(126, 126, 126);
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ReplayCellDidSelectPic:)]) {
        [self.delegate ReplayCellDidSelectPic:self.model];
    }
    
}


- (void)setModel:(YLReplyPostModel *)model
{
    _model = model;
    
    if (IS_VALID_STRING(model.ReplyMemberNick)) {
        self.nameLb.text = model.ReplyMemberNick;
    } else {
        self.nameLb.text = XLYOUKE;
    }
    
    if (IS_VALID_STRING(model.ReplyContent)) {
        self.desLb.text = model.ReplyContent;
    } else {
        self.desLb.text = @"";
    }
    
    if (IS_VALID_STRING(model.Created)) {
        NSString *time  = [NSString compareCurrentTime:model.Created];
        self.dateLb.text = time;
    } else {
        self.dateLb.text = @"";
    }
    
    
    
    if (IS_VALID_STRING(model.ReplyHeadPic)) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.ReplyHeadPic] placeholderImage:[UIImage imageNamed:@"tag_wode_a"]];
    } else {
        self.headerImageView.image = [UIImage imageNamed:@"tag_wode_a"];
    }
//    NSString *uid =  [UserManager sharedManager].userModel.Uid;
//    if (IS_VALID_STRING(model.UId)) {// 模型的UID 存在的话
//        if (IS_VALID_STRING(uid)) {// 登录后有返回的uid
//            if ([uid isEqualToString:model.UId]) {// 如果是同一个人的话
//                self.deleteBtm.hidden = NO;
//            }
//        } else {// 不是同一个人
//            self.deleteBtm.hidden = YES;
//        }
//    } else {// 不存在的情况
//        self.deleteBtm.hidden = YES;
//    }
    
}
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ReplayCellDidDeletewithModel:)]) {
        [self.delegate ReplayCellDidDeletewithModel:self.model];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
