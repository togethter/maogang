//
//  YLTabBar.h
//  LeForProject
//
//  Created by zhangzhen on 2018/6/7.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTabBarItem.h"
#import "YLTabBarBage.h"

@protocol YLTabBarDelegate<NSObject>

-(void)selectIndex:(NSInteger)index;

@end

@interface YLTabBar : UIView
//tabbar
@property(nonatomic,readonly,strong)NSMutableArray * tabBarItems;
//标题
@property(nonatomic,copy)NSArray<NSString *> *titles;
//默认图标 UIImage 类型  或者 NSString  类型
@property(nonatomic,strong)NSArray * itemImages;
//选中图标 UIImage 类型 或者 NSString 类型
@property(nonatomic,strong)NSArray * selectItemImages;
//默认标题颜色
@property(nonatomic,strong)UIColor * defColor;
//选中标题颜色
@property(nonatomic,strong)UIColor * tintColor;
//当前选中的下标
@property(nonatomic,assign)NSInteger selectIndex;
//当前选中的  TabBar
@property(nonatomic,strong)YLTabBarItem * tabBarItem;
@property(nonatomic,weak)id<YLTabBarDelegate>delegate;
//创建方法
-(instancetype)initWithTitles:(NSArray<NSString *>*)titles itemImages:(NSArray *)itemImgs selectImages:(NSArray *)selectImages;
//设置角标
-(void)setBadge:(NSInteger )count index:(NSUInteger)index;



@end
