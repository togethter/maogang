//
//  BaseAlertProtocol.h
//  LvJie
//
//  Created by bilin on 2018/4/27.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseAlertProtocol <NSObject>

@required
/**在alertView 里面添加想要显示的控件*/
- (void)forAlertViewAddSubViews:(UIView *)aletView;
/** 配置约束 带有的模型 外部的试图可以为空如果为空的话就是在屏幕正中心 */
- (void)configurateLayOutWithModel:(id)model withAlertView:(UIView *)aletView outsideView:(UIView *)view withSubView:(UITableView *)tableView;
/**展示*/
- (void)show;
@optional
/**删除*/
- (void)dismiss;
@end
