//
//  IWTextView.h
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWTextView;
@protocol IWTextViewDelegate <NSObject>
@optional
- (void)IWTextViewDelegateTextChangeAction:(NSString *)text count:(NSUInteger)count;
- (void)IWTextViewDelegateTextChangeAction:(NSString *)text count:(NSUInteger)count withTextView:(IWTextView *)textView;
@end
@interface IWTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, weak) id<IWTextViewDelegate> xdelegate;
@end
