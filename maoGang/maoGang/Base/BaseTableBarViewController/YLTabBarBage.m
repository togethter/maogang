//
//  YLTabBarBage.m
//  LeForProject
//
//  Created by zhangzhen on 2018/6/6.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import "YLTabBarBage.h"
#define K_WIDTH_QW   [UIScreen mainScreen].bounds.size.width
@implementation YLTabBarBage

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        //boldSystemFontOfSize  字体会加粗
        self.font = [UIFont boldSystemFontOfSize:10];
        
        self.textAlignment = NSTextAlignmentCenter;
        //就是当它取值为 YES 时，剪裁超出父视图范围的子视图部分；当它取值为 NO 时，不剪裁子视图(裁减超出父视图的部分)
        //https://www.jianshu.com/p/d50789913a65
        self.clipsToBounds = YES;
    }
    return self;
    
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.layer.cornerRadius = self.frame.size.height/2.0f;
 
}
-(void)setBadge:(NSInteger)badge{
    NSString * badgeStr;
    if (badge>99) {
        badgeStr = @"99+";
    }else if(badge<=0){
        self.hidden = YES;
        self.text = @"";
        return;
    }else{
        badgeStr = [NSString stringWithFormat:@"%ld",badge];
        
    }
    self.hidden = NO;
    CGFloat widths = badgeStr.length*9<18?18:badgeStr.length*9;
    CGFloat swith = K_WIDTH_QW/_itemCount;
    self.frame = CGRectMake(swith/2+8+(self.tag-10086), 5, widths, 18);
    self.text = badgeStr;
    
}




@end
