//
//  ArticleDetailBottomInputView.h
//  LvJie
//
//  Created by bilin on 2018/1/4.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWTextView.h"


@protocol ArticleDetailBottomInputViewdelegate <NSObject>

- (void)articleDetailBottomInputViewUpdateY:(CGFloat) Y;


/**
 发送输入的文本
 
 @param inputString 文本
 */
- (void)articleDetailBottomInputViewWithInputString:(NSString *)inputString withButton:(UIButton *)sender withModel:(id)model;

@end

@interface ArticleDetailBottomInputView : UIView
@property (nonatomic, strong) IWTextView *textView;


@property (nonatomic, weak) id<ArticleDetailBottomInputViewdelegate> delegate;
// 这个是模型
@property (nonatomic, weak) id model;

- (void)updateHeight:(UITextView *)textView;



@end

