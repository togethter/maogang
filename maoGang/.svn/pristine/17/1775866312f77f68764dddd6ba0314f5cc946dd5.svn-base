//
//  ArticleDetailBottomView.m
//  LvJie
//
//  Created by bilin on 2018/1/4.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "ArticleDetailBottomView.h"

@interface ArticleDetailBottomView ()

@end

@implementation ArticleDetailBottomView


- (instancetype)initWithFrame:(CGRect)frame withbuttonsType:(ButtonsType)buttontype
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *cornerView  = [UIView new];
        [self addSubview:cornerView];
        
        UIImageView *writeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huifu_pinglun"]];
        UILabel *label  = [[UILabel alloc] init];
        label.text      = @"写评论...";
        label.textColor = RGBCOLOR(36, 36, 36);
        label.font = [UIFont fontWithName:FontName size:15 * XLh];
      
        UIButton *replayBtnForUser = [UIButton buttonWithType:UIButtonTypeCustom];
        [cornerView addSubview:replayBtnForUser];
        [replayBtnForUser addTarget:self action:@selector(replayBtnForUserAction:) forControlEvents:UIControlEventTouchUpInside];
      
        [cornerView addSubview:replayBtnForUser];
        [cornerView addSubview:writeImageView];
        [cornerView addSubview:label];
       
        cornerView.layer.cornerRadius = 39.f/2;
        cornerView.layer.masksToBounds = YES;
       
        UILabel * line = [[UILabel alloc]init];
        line.backgroundColor = LineBackgroundColor;
        [self addSubview:line];
        
      
        [cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.top.mas_equalTo(self.mas_top).offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
            make.right.mas_equalTo(self).offset(-20);

    
        }];
        [replayBtnForUser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(cornerView);
        }];

        [writeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cornerView.mas_centerY);
            make.left.mas_equalTo(cornerView.mas_left).offset((39.f/2 - 2) * XLh);
        }];


        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(writeImageView.mas_right).offset(5);
            make.centerY.mas_equalTo(writeImageView.mas_centerY);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(0);
            make.right.mas_equalTo(self).mas_equalTo(0);
            make.height.mas_equalTo(@1);
            make.top.mas_equalTo(self);
        }];
        cornerView.backgroundColor          = RGBCOLOR(244, 244, 244);

    }
    
    return self;
}

// 写评论
- (void)replayBtnForUserAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(articleDetailBottomViewTFDBecaseFistResponder)]) {
        [self.delegate articleDetailBottomViewTFDBecaseFistResponder];
    }
}


@end
