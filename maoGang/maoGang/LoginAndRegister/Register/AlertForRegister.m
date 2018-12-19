//
//  AlertForRegister.m
//  LvJie
//
//  Created by bilin on 2018/5/2.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "AlertForRegister.h"
#import "UIButton+LLExtension.h"

@interface AlertForRegister ()
@property (nonatomic, strong) UIView *topview;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UIButton *wxLogin;


@property (nonatomic, strong) UIButton *cancleBtn;



@end

@implementation AlertForRegister



- (void)textWithString:(NSString *)text withLabel:(UILabel *)label withDic:(NSDictionary *)dic
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:dic];
    label.attributedText = string;
}
- (void)forAlertViewAddSubViews:(UIView *)aletView
{
    self.topview = [UIView new];
    self.topview.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tishi_a"]];
    
    self.label = [UILabel new];
    self.label.font = [UIFont fontWithName:FontName size:15];
    self.label.textColor = RGBCOLOR(10, 10, 10);
    self.label.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 12;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:FontName size:15],NSForegroundColorAttributeName : RGBCOLOR(10, 10, 10),NSParagraphStyleAttributeName :paragraphStyle};
    [self textWithString:@"收不到验证码？你还可以使用微信\n快速登录" withLabel:self.label withDic:dic];
    
    
    
    self.secondLabel = [UILabel new];
    self.secondLabel.font = [UIFont fontWithName:FontName size:11];
    self.secondLabel.textColor = RGBCOLOR(197, 197, 197);
    self.secondLabel.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 6;
    NSDictionary *dic1 = @{NSFontAttributeName:[UIFont fontWithName:FontName size:11],NSForegroundColorAttributeName : RGBCOLOR(197, 197, 197),NSParagraphStyleAttributeName :paragraphStyle1};
    [self textWithString:@"*快速成功后请去我的-设置里面绑定您的手机\n号码(方便您使用认证)" withLabel:self.secondLabel withDic:dic1];
    
    
    
    self.wxLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wxLogin setImage:[UIImage imageNamed:@"icon_weixin_"] forState:UIControlStateNormal];
    [self.wxLogin addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.wxLogin setTitle:@"微信登录" forState:UIControlStateNormal];
    self.wxLogin.backgroundColor = RGBCOLOR(0, 164, 251);
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleBtn setImage:[UIImage imageNamed:@"icon_back_b"] forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [aletView addSubview:self.topview];
    [self.topview addSubview:self.imageView];
    [aletView addSubview:self.label];
    [aletView addSubview:self.secondLabel];
    [aletView addSubview:self.wxLogin];
    [self.topview addSubview:self.cancleBtn];
    
    aletView.layer.cornerRadius = 8;
    aletView.layer.masksToBounds = YES;
    
}
- (void)configurateLayOutWithModel:(id)model withAlertView:(UIView *)aletView outsideView:(UIView *)view withSubView:(UITableView *)tableView
{
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(630.f/2);
        make.width.mas_equalTo(600.f/2);
        make.center.mas_equalTo(self);
    }];
    
    [self.topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alertView.mas_top);
        make.left.mas_equalTo(self.alertView.mas_left);
        make.right.mas_equalTo(self.alertView.mas_right);
        make.height.mas_equalTo(230.f/2);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topview.mas_top).offset(12);
        make.right.mas_equalTo(self.topview.mas_right).offset(-12);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.topview);
    }];
    
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topview.mas_bottom);
        make.left.mas_equalTo(self.alertView.mas_left).offset(63.f/2);
        make.right.mas_equalTo(self.alertView.mas_right).offset(-63.f/2);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(48.f/2);
        make.left.mas_equalTo(self.label.mas_left);
        make.right.mas_equalTo(self.label.mas_right);
    }];

    self.wxLogin.layer.cornerRadius = 90.f/4;
    self.wxLogin.layer.masksToBounds = YES;
    
    [self.wxLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondLabel.mas_bottom).offset(58.f/2);
        make.width.mas_equalTo(475.f/2);
        make.height.mas_equalTo(90.f/2);
        make.centerX.mas_equalTo(self.alertView.mas_centerX);
    }];
    
    [self.wxLogin layoutButtonWithEdgeInsetsStyle:(LLButtonStyleTextRight) imageTitleSpace:6];
    
    
}

- (void)cancleAction:(UIButton *)sender
{
    if (self.aletBlock) {
        self.aletBlock(cancle);
    }
    [self dismiss];

}

- (void)loginAction:(UIButton *)sender
{
    if (self.aletBlock) {
        self.aletBlock(wxLogin);
    }
    [self dismiss];
}

@end
