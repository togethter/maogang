//
//  YBAreaPickerView.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWProgressView.h"

//typedef void(^YBPickerDidSelectBlock)(NSInteger indexPath,NSInteger indexSender);

@interface YLAlertAddBookTool : UIView

@property (nonatomic, strong) HWProgressView *progressView;
@property(nonatomic,strong)UILabel * numberProgressL;




- (void)show;
- (void)close;



@end
