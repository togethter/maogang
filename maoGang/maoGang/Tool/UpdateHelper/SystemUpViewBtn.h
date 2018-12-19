//
//  SystemUpViewBtn.h
//  OPEN
//
//  Created by bilin on 16/10/9.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(BOOL);
@interface SystemUpViewBtn : UIView

/**! 
 版本升级的工具
 回调
 描述
 版本
 YES 代表升级
 NO 代表删除
 
 */

+ (void)alertWithClickBlock:(ClickBlock)alertBlock
                      title:(NSArray *)titleArray
                   subTitle:(NSString *)subTitle
         canHiddenDeleteBtn:(BOOL)isvisualDeleteBtn;
@end
