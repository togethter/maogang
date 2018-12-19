//
//  TBTabBar.m
//  TabbarBeyondClick
//
//  Created by 卢家浩 on 2017/4/17.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "TBTabBar.h"
#import "UIView+TBFrame.h"
#import "UIButton+SSEdgeInsets.h"
#import "BXTabBarBigButton.h"
#import "UIImage+Extension.h"
@interface TBTabBar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;



@end

@implementation TBTabBar





- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.shadowColor = RGBACOLOR(0, 0, 0, .2).CGColor;
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowOffset = CGSizeMake(0,0);
    
  
//    CGFloat w = self.width/5.0;
////    self.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabs_background"]];
////    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabs_background"]];
//    if (!self.plusBtn) {
//        BXTabBarBigButton *publishBtn = [[BXTabBarBigButton alloc]init];
//        publishBtn.backgroundColor = RGBCOLOR(78, 150, 225);
//        [publishBtn setImage:[UIImage imageNamed:@"icon_add_vandp"] forState:UIControlStateNormal];
//        [publishBtn setImage:[UIImage imageNamed:@"icon_add_vandp"] forState:UIControlStateHighlighted];
////        [publishBtn setTitle:@"添加" forState:UIControlStateNormal];
////        publishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [publishBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
//        publishBtn.adjustsImageWhenHighlighted = NO;
//        publishBtn.size = CGSizeMake(w, 48);
//        publishBtn.centerX = self.width / 2;
////        publishBtn.centerY = 18;
//        publishBtn.y = 0;
////        [publishBtn setTitleColor:RGBCOLOR(182, 188, 210) forState:UIControlStateNormal];
////        [publishBtn setTitleColor:RGBCOLOR(123, 171, 240) forState:UIControlStateHighlighted];
//        [self addSubview:publishBtn];
//        self.plusBtn = publishBtn;
////        [publishBtn setImagePositionWithType:SSImagePositionTypeTop spacing:5];
//
//    }
    

    // 其他位置按钮
    NSUInteger count = self.subviews.count - 3;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.width = self.width / 5.0;
            view.x = self.width * j / 5.0;
            
            j++;
            if (j == 2) {
                j++;
            }
        }
    }
    
}

// 点击发布
- (void) didClickPublishBtn:(UIButton*)sender {
    //    NSLog(@"点击了发布");
    if (self.didClickPublishBtn) {
        self.didClickPublishBtn();
    }
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
   
    if (self.isHidden == NO) {

        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];

        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了

            return [super hitTest:point withEvent:event];
        }
    }else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        
        return [super hitTest:point withEvent:event];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
