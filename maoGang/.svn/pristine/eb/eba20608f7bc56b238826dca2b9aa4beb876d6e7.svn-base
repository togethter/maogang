//
//  BaseAlertView.m
//  LvJie
//
//  Created by bilin on 2018/4/27.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "BaseAlertView.h"
@interface BaseAlertView ()
/** 弹框*/
@property (nonatomic,strong)UIView *alertView;
/** 模型*/
@property (nonatomic, strong) id model;
@property (nonatomic,strong)UIWindow *alertWindow;

@property (nonatomic, strong) UIView *outsideView;
@property (nonatomic, strong) UITableView *talbView;




@end
@implementation BaseAlertView

- (UIWindow *)alertWindow
{
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _alertWindow;
}


- (instancetype)initWithalertWithWithModel:(BaseModel *)model withAlertBlock:(alertBlock)alertBlock ClickItem:(UIView *)view withViewSubViewView:(UITableView *)tableView
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.outsideView = view;
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    self.aletBlock = alertBlock;
    self.frame = [UIScreen mainScreen].bounds;// 设置frame
    self.alertView = [UIView new];
    self.alertView.backgroundColor = [UIColor whiteColor];
    // 添加alertView
    self.talbView = tableView;
    [self addSubview:self.alertView];
    [self forAlertViewAddSubViews:self.alertView];
    self.model = model;

    return self;
}

- (void)forAlertViewAddSubViews:(UIView *)aletView
{
    
}

- (void)setIsCanRemoveClickBlackView:(BOOL)isCanRemoveClickBlackView
{
    _isCanRemoveClickBlackView = isCanRemoveClickBlackView;
    if (isCanRemoveClickBlackView) {
        UITapGestureRecognizer  *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)];
        [self addGestureRecognizer:tapGes];
    }
    
}

- (void)dismissAction:(UITapGestureRecognizer *)tapGes
{
    CGPoint point = [tapGes locationInView:self];
    if (!CGRectContainsPoint(self.alertView.frame,point)) {
         [self dismiss];
    }
   
}
- (void)setModel:(id)model
{
    _model = model;// 给模型赋值
    [self configurateLayOutWithModel:(model) withAlertView:self.alertView outsideView:self.outsideView withSubView:self.talbView];
}

- (void)configurateLayOutWithModel:(id)model withAlertView:(UIView *)aletView outsideView:(UIView *)view withSubView:(UITableView *)tableView
{
    
}
/**
 展示
 */
- (void)show
{
    self.alertWindow.windowLevel=UIWindowLevelAlert;
    [_alertWindow becomeKeyWindow];
    [_alertWindow makeKeyAndVisible];
    [_alertWindow addSubview:self];
//    [self setShowAnimation];
}

/**
 删除
 */
- (void)dismiss
{
    [self removeFromSuperview];
    [_alertWindow resignKeyWindow];
}
-(void)setShowAnimation{
    
    switch (_animationStyle) {
            
        case YLLXASAnimationDefault:
        {
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [_alertView.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        [_alertView.layer setValue:@(.9) forKeyPath:@"transform.scale"];
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            [_alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
        }
            break;
            
        case YLLXASAnimationLeftShake:{
            
            CGPoint startPoint = CGPointMake(-kScreenWidth, self.center.y);
            _alertView.layer.position=startPoint;
            
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case YLLXASAnimationTopShake:{
            
            CGPoint startPoint = CGPointMake(self.center.x, -_alertView.frame.size.height);
            _alertView.layer.position=startPoint;
            
            //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
            //velocity:弹性复位的速度
            [UIView animateWithDuration:.8 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                _alertView.layer.position=self.center;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case YLLXASAnimationNO:{
            
        }
            
            break;
            
        default:
            break;
    }
    
}



@end
