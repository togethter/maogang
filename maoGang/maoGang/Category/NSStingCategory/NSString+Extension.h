//
//  NSString+Extension.h
//  ChongFa
//
//  Created by bilin on 16/8/18.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
// 下载
+ (void)xiazaiLieBiao;

// 上传
+ (void)uploadLieBiao;

/** 计算cache 的大小*/
+ (int64_t)folderSizeAtPath:(NSString*)folderPath;
/** 清除cache 大小*/
+(void)clearCache:(void(^)())cacheBlock;
/**
 *返回  日 月
 */
+(NSString *)YLaddSecondDateTimes:(NSString * )times;

/**
 *  将时间戳转化成时间
 *
 *  @param time 时间戳字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)addTime:(NSString *)time;
/**
 *  判断是否是字符串
 *
 *  @param sting 给的字符串
 *
 *  @return 返回的BOOL值 如果 是是字符串就返回YES 如果不是字符串就是NO
 */
//+ (BOOL)isSting:(NSString *)sting;
/**
 *  获取当前的时间
 *
 *  @return 返回的时间字符串
 */
+ (NSString *)getCurrentTime;
/**
 *  获取到当前时间加一个小时
 *
 *  @return 返回当前时间加一个小时
 */
+ (NSString *)getCurrentTimeOfAddOneHour;

/**
 *  获取到当前时间加三天
 *
 *  @return 返回当前时间加三天
 */
+ (NSString *)getCurrentTimeOfAddThreeDay;

/**
 获取一当前的时间加1天

 @return 返回当前时间加一天
 */
+ (NSString *)getCurrentTimeOfOneDay;
/**
 *  获取去年的当前时间
 *
 *  @return 返回去年的当前时间
 */
+ (NSString *)getCurrentTimeOfReductionOneYear;

/**
 *  获取明年的当前时间
 *
 *  @return 返回明年的当前时间
 */
+ (NSString *)getCurrentTimeOfAddOneYear;

/**
 *  获取明年的当前时间
 *
 *  @return 返回 年  月  日
 */
+ (NSString *)twoTimes:(NSString *)time;

/**
 *  传入  2109/09/12 12:22
 *
 *  @return nsdate
 */
+(NSDate * )toTiomeString:(NSString * )time;

/**
 *  将时间字符串转换成date
 *
 *  @param string 时间字符串
 *
 *  @return date
 */
+ (NSDate *)YLgetDateWithString:(NSString *)string;

/**
 *  将时间字符串转换成date
 *
 *  @param string 时间字符串
 *
 *  @return date
 */
+ (NSDate *)getDateWithString:(NSString *)string;
/**
 *  是否删除数据库的一些操作
 */
+ (void)dataBaseCacheAction;



/**
 *  单独调用方法去AppStore去评分
 */
+ (void)pingFenAction;


+ (NSString *) compareCurrentTime:(NSString *)str;

/**
 *  返回 时 分
 */
+(NSString *)addshifenTimes:(NSString * )times;

/**
 *返回  年月日  时 分
 */
+(NSString *)addTimes:(NSString * )times;
/**
 *返回  年/月/日  时 分
 */
+(NSString * )addTimeSchedule:(NSString *)times;

/**
*返回  月 日  时 分
*/
+(NSString *)addSecondDateTimes:(NSString * )times;

/**
 * 秒 转换成  时分秒
 */
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds;

+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+(NSString * )creatAskTypeWithDateArryId:(NSArray * )typeids;
/**
 *  自适应设置高度
 *
 *  @param str  要自适应的字符
 *  @param size size
 *  @param dic  字典一些设置
 *
 *  @return CGFloat
 */


+ (CGFloat)setSelfH:(NSString *)str withSize:(CGSize )size withDic:(NSDictionary *)dic;
//返回size大小
+ (CGSize)setSizeSelfH:(NSString *)str withSize:(CGSize )size withDic:(NSDictionary *)dic;


+(void)clearCache;
/**
 *  设置段落样式
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

+ (NSString *)importStyleWithHtmlString:(NSString *)HTML;
#pragma Hash
@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1String;
@property (readonly) NSString *sha256String;
@property (readonly) NSString *sha512String;

- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 判断特殊字符
- (BOOL)empty;
- (BOOL)isInteger;
- (BOOL)isFloat;
- (BOOL)isHasSpecialcharacters;
- (BOOL)isHasNumder;

#pragma mark - 时间戳转换
- (NSDate *)dateValueWithMillisecondsSince1970;
- (NSDate *)dateValueWithTimeIntervalSince1970;

#pragma 计算字数(中英混合 都算一个)
- (NSInteger)stringLength;

#pragma mark - 计算是否含有
- (BOOL)containString:(NSString *)string;
- (BOOL)containsChineseCharacter;

#pragma mark - 计算字符串尺寸
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font;
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font;

#pragma mark - 正则匹配
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isTelephone;
- (BOOL)isValidZipcode;
- (BOOL)isPassword;

- (BOOL)isNumbers;
- (BOOL)isLetter;
- (BOOL)isCapitalLetter;
- (BOOL)isSmallLetter;
- (BOOL)isLetterAndNumbers;
- (BOOL)isChineseAndLetterAndNumberAndBelowLine;
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10;
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;
- (BOOL)isBelow7ChineseOrBlow14LetterAndNumberAndBelowLine;

#pragma mark - 加密
// md5
- (NSString*)md5;

// sha
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha384;
- (NSString *)sha512;



// des
- (NSString *)encryptWithKey:(NSString *)key;
- (NSString *)decryptWithKey:(NSString *)key;

#pragma mark - 获得特殊字符串
+ (NSString*)getTimeAndRandomString;

#pragma mark - json转义
- (NSString *)changeJsonEnter;
#pragma mark -  email 转换为 312******@qq.com 形式
- (NSString *)emailChangeToPrivacy;

#pragma mark - Emoji
- (BOOL)isIncludingEmoji;
- (instancetype)removedEmojiString;

// 替换的方法
- (NSString *)changeAction;
- (NSString *)newChangeAction;

- (NSString *)jAction;
- (NSString *)removeHuanHangAction;

+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;

@end
