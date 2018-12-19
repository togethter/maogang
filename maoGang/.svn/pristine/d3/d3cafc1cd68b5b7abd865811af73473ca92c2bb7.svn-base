//
//  YLTabBarBigItem.m
//  LeForProject
//
//  Created by zhangzhen on 2018/6/8.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import "YLTabBarBigItem.h"

@implementation YLTabBarBigItem

-(instancetype)initWithFrame:(CGRect)frame{
    
  self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    }
    return self;
    
}

-(void)creatUI{
    
    _M_bg_icon_V = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height)];
    _M_bg_icon_V.image = [UIImage imageNamed:@"tabs_Irregular_2"];
    _M_bg_icon_V.contentMode = UIViewContentModeScaleAspectFill;
//    [self addSubview:_M_bg_icon_V];
    
    _M_icon_V = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-44)/2 - 10, -9, 66, 66)];
    _M_icon_V.contentMode = UIViewContentModeScaleAspectFit;
//    _M_icon_V.image = [UIImage imageNamed:@"tab_ask_hover"];
    [self addSubview:_M_icon_V];
    
    
    
}

-(void)setM_normal_icon:(UIImage *)M_normal_icon{
    
    _M_normal_icon = M_normal_icon;
    _M_icon_V.image = _M_normal_icon;
  
}

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect) {
        _M_icon_V.image =_M_selected_icon;
        
    }else{
        _M_icon_V.image = _M_normal_icon;
    }
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
