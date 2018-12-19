//
//  ArticleDetailBottomView.h
//  LvJie
//
//  Created by bilin on 2018/1/4.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleDetailBottomView;

@protocol ArticleDetailBottomViewDelegate <NSObject>

/**
 点击写评论的输入框
 */
- (void)articleDetailBottomViewTFDBecaseFistResponder;



/**
 点赞这篇文章

 @param sender 试图
 */
- (void)articleDetailBottomViewlike:(ArticleDetailBottomView *)sender;



/**
 回复的点击事件带有红色回复的个数

 @param sender 试图
 */
- (void)articleDetailBottomViewReplay:(ArticleDetailBottomView *)sender;



/**
 收藏和取消收藏 文章

 @param sender  试图
 @param isCollection YES 收藏 NO取消收藏
 */
- (void)articleDetailBottomViewCollectionOrCancleCollection:(ArticleDetailBottomView *)sender withCollection:(BOOL)isCollection;


@end


typedef NS_ENUM(NSInteger,ButtonsType) {
    buttonsTypeHuiFuAndCollection,
    buttonsTypeLike,
};
@interface ArticleDetailBottomView : UIView


@property (nonatomic, weak) id<ArticleDetailBottomViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame withbuttonsType:(ButtonsType)buttontype;

@end
