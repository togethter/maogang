//
//  CircleUserCell.m
//  gaofangPenYouQuan
//
//  Created by zhangzhen on 2018/11/19.
//  Copyright © 2018 zhangzhen. All rights reserved.
//

#import "CircleUserCell.h"

#import <TTTAttributedLabel.h>
#import "CircleItem.h"
#import <UIImageView+WebCache.h>
#import "SectionHeaderView.h"
#import "YLReplyPostModel.h"


@interface CircleUserCell ()<TTTAttributedLabelDelegate>

@property(nonatomic,strong)TTTAttributedLabel * commentLabel;

@end
@implementation CircleUserCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setTop];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setTop{
    
    UIView * bgV = [UIView new];
    bgV.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-SectionHeaderHorizontalSpace*2);
        make.left.equalTo(@( SectionHeaderHeaderImageLeftWidth+SectionHeaderHeaderImageHeight+ SectionHeaderHorizontalSpace ));
        
    }];
    
    self.commentLabel = [TTTAttributedLabel new];
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.lineSpacing = SectionHeaderLineSpace;
    self.commentLabel.font = [UIFont systemFontOfSize:12];
    self.commentLabel.delegate = self;
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(6);
        make.bottom.equalTo(self.contentView).offset(-6);
        make.right.equalTo(self.contentView).offset(-SectionHeaderHorizontalSpace*2-SectionHeaderHeaderLiketNameLeftWidth);
        make.left.equalTo(@(SectionHeaderHeaderImageLeftWidth+SectionHeaderHeaderImageHeight+SectionHeaderHorizontalSpace+SectionHeaderHeaderLiketNameLeftWidth));
        
    }];
    
    [self linkStyles];
    

    
}
-(void)linkStyles{
    
    UIColor * linkColor = [UIColor colorWithRGB:@"2,112,225"];
    CTUnderlineStyle linkUnderLineStyle = kCTUnderlineStyleNone;
    UIColor *activeLinkColor = [UIColor colorWithRGB:@"2,112,225"];
    CTUnderlineStyle activelinkUnderLineStyle  = kCTUnderlineStyleNone;
    
    //没有点击时候的样式
    self.commentLabel.linkAttributes = @{
                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:12],
                                         (NSString*)kCTForegroundColorAttributeName : linkColor,
                                         (NSString *)kCTUnderlineStyleAttributeName:[NSNumber numberWithInt:linkUnderLineStyle]
                                         };
    
    // 点击时候的样式
    self.commentLabel.activeLinkAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],
                                               (NSString *)kCTForegroundColorAttributeName: activeLinkColor,
                                               (NSString *)kTTTBackgroundFillColorAttributeName:[UIColor lightGrayColor],
                                               (NSString *)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:activelinkUnderLineStyle]};
    
}

-(void)setContentData:(CircleItem *)item index:(NSInteger)index{
    if (item.replys.count>index) {
        
        NSDictionary *dic = item.replys[index];
        YLReplyPostModel * model = [YLReplyPostModel loadModelWithDictionary:dic];
        
        NSString *text = nil;
        if (!IS_VALID_STRING(model.AtMemberNick) ||![model.AtMemberId isEqualToString:item.MemberId]) {
            text = [NSString stringWithFormat:@"%@: %@", model.ReplyMemberNick, model.ReplyContent];
            self.commentLabel.text = text;
        } else {
            text = [NSString stringWithFormat:@"%@回复%@: %@", model.ReplyMemberNick,model.AtMemberNick, model.ReplyContent];
             self.commentLabel.text = text;
        }
//        if ([dic valueForKey:@"AtMemberNick"] == nil || [[dic valueForKey:@"AtMemberNick"] length] <= 0 || [[dic valueForKey:@"AtMemberId"] integerValue] == item.MemberId) {
//            text = [NSString stringWithFormat:@"%@: %@", [dic valueForKey:@"ReplyMemberNick"], [dic valueForKey:@"ReplyContent"]];
//            self.commentLabel.text = text;
//        } else {
//            text = [NSString stringWithFormat:@"%@回复%@: %@", [dic valueForKey:@"ReplyMemberNick"], [dic valueForKey:@"AtMemberNick"], [dic valueForKey:@"ReplyContent"]];
//            self.commentLabel.text = text;
//        }
        
        //添加url
        NSRange boldRange0 = NSMakeRange(0, [model.ReplyMemberNick length]);
        NSRange boldRange1 = NSMakeRange([model.ReplyMemberNick length] + 2, [model.AtMemberNick length]);
        [self.commentLabel addLinkToTransitInformation:@{@"user_name":model.ReplyMemberNick} withRange:boldRange0];
        if (!IS_VALID_STRING(model.AtMemberNick) ||![model.AtMemberId isEqualToString:item.MemberId]) {
            
        } else {
            [self.commentLabel addLinkToTransitInformation:@{@"user_name":model.AtMemberNick} withRange:boldRange1];
        }
        
    }
    
    
    
}

#pragma mark - TTTAttributedLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    if ([_delegate respondsToSelector:@selector(didSelectPeople:)]) {
        [_delegate didSelectPeople:components];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
