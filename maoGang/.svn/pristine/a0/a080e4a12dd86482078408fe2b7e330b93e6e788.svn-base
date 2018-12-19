//
//  KSAlertView.m
//  test
//
//  Created by kong on 16/4/29.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "KSAlertView.h"
#import "KSAlertAppearance.h"

//屏幕尺寸
#define KSFullScreen [UIScreen mainScreen].bounds
//AlertViewWidth
#define KSAlertWidth (KSFullScreen.size.width - 2 *30)
//按钮默认高度
#define KSAlertBtnHeight (50)




@interface KSAlertView ()
/** 配置中心 */
//@property (nonatomic, strong) KSAlertAppearance* appearance;

@property (nonatomic, strong) UIWindow* window;

@property (nonatomic, strong) UIView* alertView;

@end

@implementation KSAlertView
{
    UILabel* _titleLabel;
    UILabel* _message1Label;
    
    
    UIButton * _remindButton;
    
    
    UIButton* _cancelButton;
    UIButton* _commitButton;
    
    UIView* _horizontalLine;
    UIView* _verticalLine;
    
    NSTimeInterval _druation;
}

- (void)show{
    
    [self.window becomeKeyWindow];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self];
    
    [self setShowAnimation];
}
- (void)dismiss{
    
    [self.window resignKeyWindow];

    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];

    [[UIApplication sharedApplication].delegate.window becomeKeyWindow];

    [self removeFromSuperview];
}

#pragma mark--提醒点击事件
-(void)remindButtonClicked:(UIButton * )sendButton{

    sendButton.selected =!sendButton.selected;
    if (sendButton.selected) {

        
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:DeleteFileKEY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
    }else{
    
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:DeleteFileKEY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
       
    }
 


}




- (instancetype)initWithTitle:(NSString *)title message1:(NSString *)message1  remindTitle:(NSString *)remindTitle  cancelButton:(NSString*)cancelTitle commitButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction druation:(NSTimeInterval)druation{

    if (self = [super init]) {
//        {
//            //初始化配置
//            self.appearance = [[KSAlertAppearance alloc] init];
//        }
        
        {
            //初始化窗体
            self.window = [[UIWindow alloc] initWithFrame:KSFullScreen];
            self.window.windowLevel = UIWindowLevelAlert;
        }
        
        {
            //背景区域
            self.backgroundColor = [KSAlertView appearances].KSAlertMaskViewColor;
            self.frame = KSFullScreen;
            self.userInteractionEnabled = YES;
        }
        
        {
            //显示区域
            self.alertView = [[UIView alloc] init];
            self.alertView.backgroundColor = [KSAlertView appearances].KSAlertViewColor;
            self.alertView.userInteractionEnabled = YES;
            [self addSubview:self.alertView];
        }
        
        {
            //title
            if (title) {
                _titleLabel = [[UILabel alloc] init];
                [self.alertView addSubview:_titleLabel];

                _titleLabel.numberOfLines = 0;
                _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:[KSAlertView appearances].KSAlertTitleAttributed];
            }
        }
        
        {
            //message1
            if (message1) {
                _message1Label = [[UILabel alloc] init];
                
                _message1Label.numberOfLines = 0;
                _message1Label.attributedText = [[NSAttributedString alloc] initWithString:message1 attributes:[KSAlertView appearances].KSAlertMessage1Attributed];
                [self show:@"删除后将不可恢复,请谨慎操作。" With:@"\n也可以把案件状态改成“完结”状态,方便以后查看" With:@"\n\n是否确认删除?" WithLabel:_message1Label];
                
                [self.alertView addSubview:_message1Label];
            }
        }
        
        {
            //remindButton
            if (remindTitle) {
               _remindButton  = [UIButton buttonWithType:UIButtonTypeCustom];
                //_remindButton.backgroundColor = KSColor(240, 240, 240);
                
                if (IS_VALID_STRING(DeleteFile)&& [DeleteFile isEqualToString:@"1"]  ) {
                    
                    
                    _remindButton.selected = YES;
                    
                }
                
                
                [_remindButton setTitle:remindTitle forState:UIControlStateNormal];
                [_remindButton setImage:[UIImage imageNamed:@"icon_anjian_shanchu_a"] forState:UIControlStateNormal];
                [_remindButton setImage:[UIImage imageNamed:@"icon_anjian_shanchu_b"] forState:UIControlStateSelected];
                [_remindButton setTitleColor:KSColor(155, 155, 155) forState:UIControlStateNormal];
                [_remindButton setImageEdgeInsets:UIEdgeInsetsMake(0, -86, 0, 0)];
                [_remindButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -76, 0, 0)];
                
                _remindButton.titleLabel.font = [UIFont systemFontOfSize:12];
                [_remindButton addTarget:self action:@selector(remindButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_remindButton];
            }
        }
        
        
        {
            //cancelButton
            if (cancelTitle) {
                _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _cancelButton.backgroundColor = KSColor(240, 240, 240);

                [_cancelButton setAttributedTitle:[[NSAttributedString alloc] initWithString:cancelTitle attributes:[KSAlertView appearances].KSAlertCancelTitleAttributed] forState:UIControlStateNormal];
                [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_cancelButton];
            }
        }

        {
            //commitButton
            if (commitTitle) {
                _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _commitButton.backgroundColor = KSColor(240, 240, 240);
                
                if ([commitTitle isEqualToString:@"删除"]) {
                    [_commitButton setAttributedTitle:[[NSAttributedString alloc] initWithString:commitTitle attributes:[KSAlertView appearances].KSAlertCommitTitleAttributed] forState:UIControlStateNormal];
                }else{
                    [_commitButton setAttributedTitle:[[NSAttributedString alloc] initWithString:commitTitle attributes:[KSAlertView appearances].KSAlertCustomTitleAttributed] forState:UIControlStateNormal];
                }
                
                [_commitButton handleControlEvent:UIControlEventTouchUpInside withBlock:commitAction];
                [_commitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
                [self.alertView addSubview:_commitButton];
            }
        }
        
        {
            //水平分割线
            if (cancelTitle || commitTitle) {
                _horizontalLine = [[UIView alloc] init];
                _horizontalLine.backgroundColor = [KSAlertView appearances].horizontalLineColor;
                [self.alertView addSubview:_horizontalLine];
            }
            //垂直分割线
            if (commitTitle) {
                _verticalLine = [[UIView alloc] init];
                _verticalLine.backgroundColor = [KSAlertView appearances].verticalLineColor;
                [self.alertView addSubview:_verticalLine];
            }
        }
        
        {
            //alertView
            self.alertView.layer.cornerRadius = [KSAlertView appearances].KSAlertViewCornerRadius;
            self.alertView.layer.masksToBounds = YES;
        }
        
        {
            //保存变量
            _druation = druation;
        }
    }
    return self;
}
- (void)show:(NSString *)thing With:(NSString *)yuanString With:(NSString *)String   WithLabel:(UILabel *)btn
{
    //    NSParagraphStyle *para = [[NSParagraphStyle alloc] init];
    //    NSMutableParagraphStyle *muPara = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:thing attributes:@{NSFontAttributeName : [UIFont fontWithName:FontName size:15], NSForegroundColorAttributeName :RGBCOLOR(155, 155, 155)}];
    NSMutableAttributedString *attrYanStr = [[NSMutableAttributedString alloc] initWithString:yuanString attributes:@{NSFontAttributeName : [UIFont fontWithName:FontName size:15],NSForegroundColorAttributeName :RGBCOLOR(155, 155, 155)}];
    
    
    NSMutableAttributedString *attrStringStr = [[NSMutableAttributedString alloc] initWithString:String attributes:@{NSFontAttributeName : [UIFont fontWithName:FontName size:16],NSForegroundColorAttributeName :[UIColor redColor]}];
    [attrStr appendAttributedString:attrYanStr];
    [attrStr appendAttributedString:attrStringStr];
    //添加到副文本
    btn.attributedText = attrStr;
    
}
- (void)layoutSubviews{
    
    CGFloat topMargin = [KSAlertView appearances].KSAlertViewPadding.top;
    CGFloat leftMargin = [KSAlertView appearances].KSAlertViewPadding.left+5;
    CGFloat rightMargin = [KSAlertView appearances].KSAlertViewPadding.right;
    CGFloat height = 0;
    
    if (_titleLabel) {
        CGFloat titleX = leftMargin;
        CGFloat titleY = topMargin;
        CGFloat titleW = KSAlertWidth - leftMargin - rightMargin;
        CGFloat titleH = _titleLabel.frame.size.height;
        _titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(KSAlertWidth / 2, _titleLabel.center.y);
        
        height = CGRectGetMaxY(_titleLabel.frame) + 30;
        
    }
    
    if (_message1Label) {
        CGFloat message1X = leftMargin;
        CGFloat message1Y = CGRectGetMaxY(_titleLabel.frame) + [KSAlertView appearances].KSAlertMessage1TopMargin;
        CGFloat message1W = KSAlertWidth - leftMargin - rightMargin;
        CGFloat message1H = _message1Label.frame.size.height;
        _message1Label.frame = CGRectMake(message1X, message1Y, message1W, message1H);
        [_message1Label sizeToFit];
        _message1Label.center = CGPointMake(KSAlertWidth / 2, _message1Label.center.y);
        
        height = CGRectGetMaxY(_message1Label.frame) + 30;
    }
    
    if (_remindButton) {

        CGFloat remindButtonX = leftMargin - 3;
        CGFloat remindButtonY = CGRectGetMaxY(_message1Label.frame) + [KSAlertView appearances].KSAlertMessage1TopMargin-5;
        CGFloat remindButtonW = 200;
        CGFloat remindButtonH = 20;
        _remindButton.frame = CGRectMake(remindButtonX, remindButtonY, remindButtonW, remindButtonH);
        height = CGRectGetMaxY(_remindButton.frame)+ [KSAlertView appearances].KSAlertMessage1TopMargin;
    }
    
    
    if (_cancelButton && (!_commitButton)) {
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = height;
        CGFloat cancelBtnW = KSAlertWidth;
        CGFloat cancelBtnH = KSAlertBtnHeight;
        _cancelButton.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
    }
    
    if ((!_cancelButton) && _commitButton) {
        CGFloat commitBtnX = 0;
        CGFloat commitBtnY = height;
        CGFloat commitBtnW = KSAlertWidth;
        CGFloat commitBtnH = KSAlertBtnHeight;
        _commitButton.frame = CGRectMake(commitBtnX, commitBtnY, commitBtnW, commitBtnH);
    }
    
    if (_cancelButton && _commitButton) {
        
     
        
        CGFloat cancelBtnX = 0;
        CGFloat cancelBtnY = height;
        CGFloat cancelBtnW = KSAlertWidth / 2;
        CGFloat cancelBtnH = KSAlertBtnHeight;
        _cancelButton.frame = CGRectMake(cancelBtnX, cancelBtnY, cancelBtnW, cancelBtnH);
        
        CGFloat commitBtnX = cancelBtnW;
        CGFloat commitBtnY = cancelBtnY;
        CGFloat commitBtnW = cancelBtnW;
        CGFloat commitBtnH = KSAlertBtnHeight;
        _commitButton.frame = CGRectMake(commitBtnX, commitBtnY, commitBtnW, commitBtnH);
        
        CGFloat verticalX = cancelBtnW;
        CGFloat verticalY = height + 13;
        CGFloat verticalW = 0.5;
        CGFloat verticalH = KSAlertBtnHeight - 26;
        _verticalLine.frame = CGRectMake(verticalX, verticalY, verticalW, verticalH);
    }
    
    if (_cancelButton || _commitButton) {
        CGFloat horizontalX = 0;
        CGFloat horizontalY = height;
        CGFloat horizontalW = KSAlertWidth;
        CGFloat horizontalH = 0.5;
        _horizontalLine.frame = CGRectMake(horizontalX, horizontalY, horizontalW, horizontalH);
        
        height += KSAlertBtnHeight;
    }
    
    self.alertView.frame = CGRectMake(0, 0, KSAlertWidth, height);
    self.alertView.center = self.center;

}

+ (KSAlertAppearance *)appearances{
    
    static KSAlertAppearance* appearance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         appearance = [[KSAlertAppearance alloc] init];
    });
    
    return appearance;
}

- (void)setShowAnimation{
    switch ([KSAlertView appearances].KSAlertAnimationStyle) {
        case KSAlertAnimationStyleDefault:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -_alertView.frame.size.height);
            _alertView.layer.position=startPoint;
            
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
                if (_druation) {
                    [UIView animateWithDuration:.25 delay:_druation options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.alpha = 0;
                    } completion:^(BOOL finished) {
                        [self dismiss];
                    }];
                }
            }];
        }
            break;
    }
}

//+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 druation:(NSTimeInterval)druation{
//    
//    KSAlertView* alertView = [[KSAlertView alloc] initWithTitle:title message1:message1 cancelButton:nil commitButton:nil commitAction:NULL druation:druation];
//    
//    [alertView show];
//    
//}


//+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1 cancelButton:(NSString*)cancelTitle{
//    
//    KSAlertView* alertView = [[KSAlertView alloc] initWithTitle:title message1:message1 cancelButton:cancelTitle commitButton:nil commitAction:NULL  druation:0];
//    
//    [alertView show];
//}

+ (void)showWithTitle:(NSString*)title message1:(NSString*)message1  remindTitle:(NSString *)remindTitle cancelButton:(NSString*)cancelTitle customButton:(NSString*)commitTitle commitAction:(CommitAction)commitAction{

    
    KSAlertView* alertView = [[KSAlertView alloc]initWithTitle:title message1:message1 remindTitle:remindTitle cancelButton:cancelTitle commitButton:commitTitle commitAction:commitAction druation:0];
    
    [alertView show];
    
}

//+ (void)showWithTitle:(NSString *)title message1:(NSString *)message1 cancelButton:(NSString *)cancelTitle commitType:(KSAlertViewButtonType )type commitAction:(CommitAction)commitAction{
//    
//    NSString* commitTitle = (type == 0)?@"确定":@"删除";
//    
//    KSAlertView* alertView = [[KSAlertView alloc] initWithTitle:title message1:message1 cancelButton:cancelTitle commitButton:commitTitle commitAction:commitAction druation:0];
//    
//    [alertView show];
//}

@end


@implementation UIButton (block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(CommitAction)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)callActionBlock:(id)sender {
    CommitAction block = (CommitAction)objc_getAssociatedObject(self, &overviewKey);
    
    if (block) {
        __weak typeof(self) weakSelf = self;
        block(weakSelf);
    }
}

@end
