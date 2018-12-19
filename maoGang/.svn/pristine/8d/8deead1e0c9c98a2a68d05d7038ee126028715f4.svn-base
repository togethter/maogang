//
//  CircleItem.h
//  gaofangPenYouQuan
//
//  Created by zhangzhen on 2018/11/19.
//  Copyright © 2018 zhangzhen. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CircleItem : BaseModel
/**
 *作品编号
 */
@property(nonatomic,copy)NSString * PostId;
/**
 *作者id
 */
@property (nonatomic, assign) NSString * MemberId;
/**
 *昵称
 */
@property (nonatomic, copy) NSString *MemberNick;
/**
 *头像
 */
@property (nonatomic, copy) NSString *MemberHeadPic;
/**
 *创建时间
 */
@property (nonatomic, copy) NSString *Created;
/**
 *是否点赞   1是 0否
 */
@property (nonatomic, copy) NSString *IsLike;
/**
 *点赞数
 */
@property (nonatomic, copy) NSString *LikesNum;

/**
 *收藏数
 */
@property (nonatomic, copy) NSString *CollectionNum;

/**
 *是否收藏   1是 0否
 */
@property (nonatomic, copy) NSString *IsCollection;
/**
 *发布内容
 */
@property (nonatomic, copy) NSString *PostContent;
/**
 *缩略图图片 list
 */
@property (nonatomic, copy) NSArray *ThumbnailPic;
/**
 *水印图图片 list
 */
@property (nonatomic, copy) NSArray *WaterPic;

/**
 *原图图片 list
 */
@property (nonatomic, copy) NSArray *Pic;
/**
 *点赞 list
 */
@property (nonatomic, copy) NSArray *LikeList;
/**
 *回复列表
 */
@property (nonatomic, copy) NSArray *replys;

/**
 * 评论 高度 集
 */
@property (nonatomic, strong) NSMutableArray *commentHeightArr;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat headerHeight;
/**
 * 名字高度
 */
@property (nonatomic, assign) CGFloat nameLabelHeight;
/**
 * 文字内容 高度
 */
@property (nonatomic, assign) CGFloat contentLabelHeight;
/**
 * 图片 高度
 */
@property (nonatomic, assign) CGFloat imgBgViewHeight;

@property (nonatomic, assign) CGFloat footerHeight;
/**
 * 点赞 高度
 */
@property (nonatomic, assign) CGFloat likerHeight;

@property (nonatomic, assign) BOOL isSpread; //全文是否展开







@end

NS_ASSUME_NONNULL_END
