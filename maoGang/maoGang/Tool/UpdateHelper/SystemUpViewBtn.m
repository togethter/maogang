
//
//  SystemUpViewBtn.m
//  OPEN
//
//  Created by bilin on 16/10/9.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import "SystemUpViewBtn.h"
#import "Masonry.h"
#import "updateCell.h"
#import "YYText.h"
#import "NSString+Extension.h"
#define MainScreenRect [UIScreen mainScreen].bounds
#define SpacingHeight 17
#define XLUpdatefontSize 15
@interface SystemUpViewBtn ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic,strong)UIWindow * alertWindow;


@end
static ClickBlock xLclickBlcok;
static SystemUpViewBtn *xLalertBox;
static UIView *xLblackView;
static UIWindow *xLkeyWindow;
@implementation SystemUpViewBtn





+ (void)deleteAction:(UIButton *)btn
{
    [[NSUserDefaults standardUserDefaults]setObject:@"321" forKey:@"sysTemUpView"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (xLclickBlcok) {
        xLclickBlcok(NO);
    }

    [xLblackView removeFromSuperview];
    [xLalertBox removeFromSuperview];
    xLclickBlcok = nil;
    xLblackView = nil;
    xLalertBox = nil;

}



+ (void)updateAction:(UIButton *)btn
{
    [[NSUserDefaults standardUserDefaults]setObject:@"321" forKey:@"sysTemUpView"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (xLclickBlcok) {
        xLclickBlcok(YES);
    }
}






// 弹框
+ (void)alertWithClickBlock:(ClickBlock)alertBlock
                      title:(NSArray *)titleArray
                   subTitle:(NSString *)subTitle
         canHiddenDeleteBtn:(BOOL)isvisualDeleteBtn

{
    [[NSUserDefaults standardUserDefaults]setObject:@"123" forKey:@"sysTemUpView"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    SystemUpViewBtn *alertView = [[[self class] alloc] init];
    xLalertBox = alertView;
    xLclickBlcok = alertBlock;
    alertView.titleArray = titleArray;
    
    UIView * Bgview = [[UIView alloc]initWithFrame:MainScreenRect];
    Bgview.backgroundColor=[UIColor colorWithWhite:.3 alpha:.7];
    xLblackView = Bgview;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    xLkeyWindow = window;
    [xLkeyWindow addSubview:xLblackView];
    [xLblackView addSubview:alertView];
    CGFloat height = 0.f;
    for (NSString *des in titleArray) {
        if ([des isEqualToString:@"YES"]||[des isEqualToString:@"NO"]) {
            continue;
        }
        NSMutableAttributedString *attributedString = [self xcattributedStringWithText:des];
        height += [attributedString.string getSpaceLabelHeightwithSpeace:attributedString.yy_lineSpacing withFont:attributedString.yy_font withWidth:234];
        
    }
    if (height>190) {
        height = 190;
    }
    
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(293);
        make.height.mas_equalTo(22+70+15+18+25+52+ height);
        make.centerX.mas_equalTo(xLkeyWindow);
        make.centerY.mas_equalTo(xLkeyWindow).mas_offset(-10);
    }];

    
    UIImageView * M_icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_update"]];
    [alertView addSubview:M_icon];
    [M_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(@77);
        make.centerX.mas_equalTo(alertView);
        make.top.mas_equalTo(alertView).mas_offset(22);
    }];
    
    UILabel * L_title = [[UILabel alloc]init];
    L_title.text = @"新版本升级";
    L_title.font = [UIFont systemFontOfSize:18];
    L_title.textColor = RGBCOLOR(55, 67, 115);
    L_title.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:L_title];
    [L_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(alertView);
        make.top.mas_equalTo(M_icon.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(@20);
    }];
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    tableView.backgroundColor = [UIColor redColor];
    tableView.delegate = alertView;
    tableView.dataSource = alertView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = NO;
    [tableView registerNib:[UINib nibWithNibName:@"updateCell" bundle:nil] forCellReuseIdentifier:@"updateCell"];
    [alertView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(L_title.mas_bottom).offset(SpacingHeight);
        make.left.mas_equalTo(alertView.mas_left).offset(25);
        make.right.mas_equalTo(alertView.mas_right).offset(-25);
        make.height.mas_equalTo(height);
    }];
    
    
    UILabel * L_line = [[UILabel alloc]init];
    L_line.backgroundColor = LineBackgroundColor;
    [alertView addSubview:L_line];
    [L_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(alertView);
        make.height.mas_equalTo(@1);
        make.top.mas_equalTo(tableView.mas_bottom).mas_offset(4);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"更新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:RGBCOLOR(123, 171, 240) forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17];

    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitleColor:RGBCOLOR(182, 188, 210) forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    if (isvisualDeleteBtn) {//强更
        [alertView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(alertView);
            make.top.mas_equalTo(L_line.mas_bottom);
            make.bottom.mas_equalTo(alertView);
        }];
        
        
    }else{
       [alertView addSubview:button];
       [alertView addSubview:deleteBtn];
        UILabel * L_line_btn = [[UILabel alloc]init];
        L_line_btn.backgroundColor = LineBackgroundColor;
        [alertView addSubview:L_line_btn];
        [L_line_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(alertView);
            make.width.mas_equalTo(@1);
            make.top.mas_equalTo(L_line.mas_bottom);
            make.bottom.mas_equalTo(alertView);
        }];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(alertView);
            make.right.mas_equalTo(L_line_btn.mas_left);
            make.top.mas_equalTo(L_line.mas_bottom);
            make.bottom.mas_equalTo(alertView);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(L_line_btn.mas_right);
            make.right.mas_equalTo(alertView);
            make.top.mas_equalTo(L_line.mas_bottom);
            make.bottom.mas_equalTo(alertView);
        }];
        
        
    }
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 4.0f;
    alertView.layer.masksToBounds = YES;
    [self animationAlert:alertView];
   
    
    
}



+(void) animationAlert:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (xLalertBox.titleArray.count >=2) {
        return xLalertBox.titleArray.count - 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    updateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"updateCell" forIndexPath:indexPath];
    if (xLalertBox.titleArray.count > indexPath.row) {
        NSString *des = xLalertBox.titleArray[indexPath.row];
        NSMutableAttributedString *attributedString = [self attributedStringWithText:des];
        cell.desLb.attributedText = attributedString;
    }
    cell.desLb.textColor = RGBCOLOR(55, 67, 115);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (xLalertBox.titleArray.count > indexPath.row) {
        NSString *des = xLalertBox.titleArray[indexPath.row];
        NSMutableAttributedString *attributedString = [self attributedStringWithText:des];
        CGFloat height = [attributedString.string getSpaceLabelHeightwithSpeace:attributedString.yy_lineSpacing withFont:attributedString.yy_font withWidth:234];
        return height;
    }
    return 0;
}
- (void)dealloc
{
    
}
+ (NSMutableAttributedString *)xcattributedStringWithText:(NSString *)textDes
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:textDes];
    string.yy_font = [UIFont systemFontOfSize:XLUpdatefontSize];
    string.yy_color = RGBCOLOR(55, 67, 115);
    string.yy_lineSpacing = 3;
    return string;
}
- (NSMutableAttributedString *)attributedStringWithText:(NSString *)textDes
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:textDes];
    string.yy_font = [UIFont systemFontOfSize:XLUpdatefontSize];
    string.yy_color = RGBCOLOR(55,67, 115);
    string.yy_lineSpacing = 3;
    return string;
}


@end
