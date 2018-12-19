//
//  YLTabBarItem.h
//  LeForProject
//
//  Created by zhangzhen on 2018/6/5.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLTabBarItem : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic, strong)UILabel * L_title;
@property (nonatomic, strong)UIImage * image;
@property (nonatomic, strong)UIImage * selectImage;
@property (nonatomic, strong)UIImageView * M_iconImageView;
@property (nonatomic,assign) BOOL isSelect;



@end

