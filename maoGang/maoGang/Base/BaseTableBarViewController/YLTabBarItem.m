//
//  YLTabBarItem.m
//  LeForProject
//
//  Created by zhangzhen on 2018/6/5.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import "YLTabBarItem.h"

@implementation YLTabBarItem
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView{
    
    _isSelect = NO;
    _M_iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-10, 9, 20, 20)];
    _M_iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_M_iconImageView];
    _L_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, self.frame.size.width, 14)];
    _L_title.textAlignment = NSTextAlignmentCenter;
    _L_title.font = [UIFont systemFontOfSize:9];
    [self addSubview:_L_title];
    
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.L_title.text = _title;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.M_iconImageView.image = _image;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect) {
        self.M_iconImageView.image = _selectImage;
    }else{
        self.M_iconImageView.image = _image;
    }
}




@end
