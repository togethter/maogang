//
//  NSString+Extension.m
//  ChongFa
//
//  Created by bilin on 16/8/18.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import "NSString+Extension.h"
#import "PathPool.h"
//#import "FmdbPool.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
//#import "MBProgressHUD.h"
#import "GTMBase64.h"
@implementation NSString (Extension)

#pragma Hash
+ (void)xiazaiLieBiao
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"indexForDownLoad"];// 下载类表里
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XLDownLoad" object:nil];
}

+ (void)uploadLieBiao
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"indexForDownLoad"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XLUpload" object:nil];
}
- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
    
}

- (NSString *)sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

#pragma mark - Helpers

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}


#pragma mark ---


#pragma mark - 正则匹配
/**
 *  匹配Email
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配URL
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配电话号码
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isTelephone {
    
    NSString * MOBILE = @"^1[0-9][0-9]\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)isValidZipcode {
    const char *cvalue = [self UTF8String];
    
    long len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}


/**
 *返回  年月日  时 分
 */
+(NSString *)addTimes:(NSString * )times{
    NSString *str=times;//时间戳
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
    
    
    
    
}

/**
 *返回  年月日  时 分
 */
+(NSString *)addTimeSchedule:(NSString * )times{
    NSString *str=times;//时间戳
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
    
    
    
    
}



+(NSString *)addshifenTimes:(NSString * )times{
    NSString *str=times;//时间戳
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
    
    
    
    
}



/**
 *返回  月日  时分
 */
+(NSString *)addSecondDateTimes:(NSString * )times{
    NSString *str=times;//时间戳
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM月dd日"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
//    NSLog(@"%@",currentDateStr);
    return currentDateStr;
    
    
    
    
}

/**
 * 秒 转换成  时分秒
 */
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    NSInteger hour = [str_hour integerValue];
    NSInteger minute = [str_minute integerValue];
    NSInteger ylsecond = [str_second integerValue];
    
    if (hour>0) {
        
          if (minute >0) {
            
              if (ylsecond >0) {
                
                  format_time = [NSString stringWithFormat:@"%ld小时%ld分钟%ld秒",(long)hour,(long)minute,(long)ylsecond];
                
              }else{
            
               format_time = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)minute];
            
               }
            
            
            
          }else{
        
              if (ylsecond>0) {
                
                format_time = [NSString stringWithFormat:@"%ld小时%ld分钟%ld秒",(long)hour,(long)minute,(long)ylsecond];
               }else{
            
                format_time = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)minute];
               }
            
            
         
          }
        
        
      

        
        
    }else{
    
      
            
            format_time = [NSString stringWithFormat:@"%ld分钟%ld秒",(long)minute,(long)ylsecond];
            
        
    
    }
    
    
    
 
    
    
    return format_time;
}


/**
 *  由英文、字母或数字组成 6-18位
 *
 *  @return YES 验证成功 NO 验证失败
 */
- (BOOL)isPassword {
    NSString * regex = @"^[A-Za-z0-9_]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
    
}

/**
 *  匹配数字
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isNumbers {
    NSString *regEx = @"^-?\\d+.?\\d?";
    NSPredicate *pred= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isLetter {
    NSString *regEx = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配大写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isCapitalLetter {
    NSString *regEx = @"^[A-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配小写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isSmallLetter {
    NSString *regEx = @"^[a-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配小写英文字母
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isLetterAndNumbers {
    NSString *regEx = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配中文，英文字母和数字及_
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLine {
    NSString *regEx = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配中文，英文字母和数字及_ 并限制字数
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10 {
    NSString *regEx = @"[\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  匹配含有汉字、数字、字母、下划线不能以下划线开头和结尾
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast {
    NSString *regEx = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

/**
 *  最长不得超过7个汉字，或14个字节(数字，字母和下划线)正则表达式
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL)isBelow7ChineseOrBlow14LetterAndNumberAndBelowLine {
    NSString *regEx = @"^[\u4e00-\u9fa5]{1,7}$|^[\dA-Za-z_]{1,14}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

#pragma mark - 加密
/**
 *  md5加密(32位 常规)
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/**
 *  md5加密(16位)
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5_16 {
    // 提取32位MD5散列的中间16位
    NSString *md5_32=[self md5];
    // 即9～25位
    NSString *result = [[md5_32 substringToIndex:24] substringFromIndex:8];
    return result;
}

/**
 *  sha1加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  sha256加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)sha256 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  sha384加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)sha384 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  sha512加密
 *
 *  @return 加密后的字符串
 */
- (NSString*)sha512 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/**
 *  base64加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)base64Encode {
#if 0
    NSString *base64String = [GTMBase64 encodeBase64String:self];
    return base64String;
#endif
    return @"";
}

/**
 *  base64解密
 *
 *  @return 解密后的字符串
 */
- (NSString *)base64Decode {
#if 0
    NSString *base64String = [GTMBase64 decodeBase64String:self];
    return base64String;
#endif
    return @"";
}

// des
- (NSString *)encryptWithKey:(NSString *)key
{
    return [self encrypt:self encryptOrDecrypt:kCCEncrypt key:key];
}
- (NSString *)decryptWithKey:(NSString *)key
{
     return [self encrypt:self encryptOrDecrypt:kCCDecrypt key:key];
}

/**
 *  加密或解密
 *
 *  @param sText            需要加密或解密的字符串
 *  @param encryptOperation kCCDecrypt 解密 kCCEncrypt 加密
 *  @param key              加密解密需要的key
 *
 *  @return 返回加密或解密之后得到的字符串
 */
- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOperation == kCCDecrypt)
    {
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];
    }
    else
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [encryptData length];
        vplainText = (const void *)[encryptData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *initVec = @"lvjiecom";//修改iv
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOperation,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    }
    else
    {
        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:data];
    }
    
    return result;
}

/**

#pragma mark - 计算字符串尺寸
/**
 *  计算字符串高度 （多行）
 *
 *  @param width 字符串的宽度
 *  @param font  字体大小
 *
 *  @return 字符串的尺寸
 */
- (CGSize)heightWithWidth:(CGFloat)width andFont:(CGFloat)font {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin  |NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return size;
}



#pragma mark - 检测是否含有某个字符
/**
 *  检测是否含有某个字符
 *
 *  @param string 检测是否含有的字符
 *
 *  @return YES 含有 NO 不含有
 */
- (BOOL)containString:(NSString *)string {
    return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
}

/**
 *  是否含有汉字
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)containsChineseCharacter {
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 计算String的字数(中英混合)
/**
 *  计算string字数
 *
 *  @return 获得的中英混合字数
 */
- (NSInteger)stringLength {
    NSInteger strlength = 0;
    NSInteger elength = 0;
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            // 汉字
            strlength++;
        } else {
            // 英文
            elength++;
        }
    }
    return strlength+elength;
}

#pragma mark - 时间戳转换
/**
 *  毫秒级时间戳转日期
 *
 *  @return 日期
 */
- (NSDate *)dateValueWithMillisecondsSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
}

/**
 *  秒级时间戳转日期
 *
 *  @return 日期
 */
- (NSDate *)dateValueWithTimeIntervalSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
}

#pragma mark - 判断特殊字符
/**
 *  判断字符串是否为空
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)empty {
    return [self length] > 0 ? NO : YES;
}

/**
 *  判断是否为整形
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isInteger {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

/**
 *  判断是否为浮点形
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  判断是否有特殊字符
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isHasSpecialcharacters {
    NSString *  englishNameRule = @"^[(A-Za-z0-9)*(\u4e00-\u9fa5)*(,|\\.|，|。|\\:|;|：|；|!|！|\\*|\\×|\\(|\\)|\\（|\\）|#|#|\\$|&#|\\$|&|\\^|@|&#|\\$|&|\\^|@|＠|＆|\\￥|\\……)*]+$";
    
    NSPredicate * englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    
    if ([englishpredicate evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
        
    }
}

/**
 *  判断是否含有数字
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isHasNumder {
    NSString *  englishNameRule = @"[A-Za-z]{2,}|[\u4e00-\u9fa5]{1,}[A-Za-z]+$";
    NSString * chineseNameRule =@"^[\u4e00-\u9fa5]{2,}$";
    
    NSPredicate * englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    NSPredicate *chinesepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseNameRule];
    
    if ([englishpredicate evaluateWithObject:self] == YES||[chinesepredicate evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
    }
    
}

#pragma mark - 获得特殊字符串
//日期+随机数
/**
 *  日期+随机数的字符串（比如为文件命名）
 *
 *  @return 得到的字符串
 */
+ (NSString*)getTimeAndRandomString {
    
    int iRandom=arc4random();
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d",[tFormat stringFromDate:[NSDate date]],iRandom];
    return tResult;
}

#pragma mark - json转义
/**
 *  将得到的json的回车替换转义字符
 *
 *  @return 得到替换后的字符串
 */
- (NSString *)changeJsonEnter {
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
}

#pragma mark -  email 转换为 312******@qq.com 形式
- (NSString *)emailChangeToPrivacy {
    
    if (![self isEmail]) {
        return @"";
    }
    
    NSRange range = [self rangeOfString:@"@"];
    
    NSMutableString *changeStr = [NSMutableString stringWithString:self];
    if (range.location > 2) {
        NSRange changeRange;
        changeRange.location = 3;
        changeRange.length = range.location - 3;
        
        NSMutableString *needChanegeToStr = [NSMutableString string];
        for (int i = 0; i < changeRange.length ; i ++) {
            
            [needChanegeToStr appendString:@"*"];
        }
        
        [changeStr replaceCharactersInRange:changeRange withString:needChanegeToStr];
    }
    
    return changeStr;
}

#pragma mark - Emoji相关
/**
 *  判断是否是Emoji
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

/**
 *  判断字符串时候含有Emoji
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

/**
 *  移除掉字符串中得Emoji
 *
 *  @return 得到移除后的Emoji
 */
- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}






+ (NSString *)HEHE:(NSString *)time {
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy.MM.dd"];
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    return string;
}

/** 第二个yyyy-MM-dd*/
+ (NSString *)twoTimes:(NSString *)time
{
    NSString *str=time;//时间戳
    NSTimeInterval times=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:times];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
    
}
// 当前日期转化为yyyy-MM-dd
+ (NSString *)getCTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dataTime = [formatter stringFromDate:[NSDate date]];
    return dataTime;
}
// 年月日
+ (NSDate *)NYRWithString:(NSString *)string
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date  = [dateFormatter dateFromString:string];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeData = [date dateByAddingTimeInterval:interval];
    return localeData;
}
+ (NSString *)addTime:(NSString *)time
{
    NSString *timeStamp = [NSString twoTime:time];
    NSString *timeSt = [NSString twoTimes:time];
    NSDate *longDate = [NSString getDateWithString:timeStamp];
    
    //把字符串转为NSdate
    //    DLog(@"%@", longDate);
    NSString *timeStr = [NSString getCurrentTime];
    NSString *timeS = [NSString getCTime];
    NSDate *currentDate = [NSString getDateWithString:timeStr];
    //    DLog(@"%@", currentDate);
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:longDate];
    long temp = 0;
    NSString *result;
    NSString *string;
    if ([[NSString NYRWithString:timeSt] isEqual: [NSString NYRWithString:timeS]]) { //大前提 当天
        if (timeInterval/60 < 1) {
            
            result = [NSString stringWithFormat:@"刚刚"];
            
            DLog(@"%@", result);
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"HH:mm:ss"];
            string=[dateFormat stringFromDate:confromTimesp];
            
            
        }
        
        else if((temp = timeInterval/60) <60){
            
            result = [NSString stringWithFormat:@"%ld分钟前",temp];
            
            DLog(@"%@", result);
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"HH:mm:ss"];
            string=[dateFormat stringFromDate:confromTimesp];
            
            
        }
        
        else if((temp = temp/60) <24){
            
            result = [NSString stringWithFormat:@"%ld小时前",temp];
            
            DLog(@"%@", result);
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"HH:mm:ss"];
            string=[dateFormat stringFromDate:confromTimesp];
            
            
        }
    } else { // 大前天 不是当天
        
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy.MM.dd"];
        string=[dateFormat stringFromDate:confromTimesp];
        
    }

 
    
    return string;
    
}


//NSString *timeStamp = [NSString twoTime:str];
//NSDate *longDate = [NSString getDateWithString:timeStamp];
//
////把字符串转为NSdate
////    DLog(@"%@", longDate);
//NSString *timeStr = [NSString getCurrentTime];
//NSDate *currentDate = [NSString getDateWithString:timeStr];
////    DLog(@"%@", currentDate);
//NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:longDate];
//long temp = 0;
//
//NSString *result;
//else if((temp = temp/60) <24){
//    
//    result = [NSString stringWithFormat:@"%ld小时前",temp];
//    
//}

/**
 *  是否是字符串有几种情况是不是 null <null> @""
 *
 *  @param sting 给的字符串
 *
 *  @return 返回的BOOL值 如果 是是字符串就返回YES 如果不是字符串就是NO
 */
+ (BOOL)isSting:(NSString *)sting {
        sting = [NSString stringWithFormat:@"%@", sting];
//    NSLog(@"%@", sting);
    if (sting == nil || [sting isEqual:[NSNull null]] || [sting isEqualToString:@""] || [sting isEqualToString:@"(null)"]) {
//        NSLog(@"haha");
        return NO;
        
    }
    return YES;
}


/**
 *  获取当前的时间
 *
 *  @return 返回的时间字符串
 */
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dataTime = [formatter stringFromDate:[NSDate date]];
    return dataTime;
}
/**
 *  获取到当前时间加一个小时
 *
 *  @return 返回当前时间加一个小时
 */
+ (NSString *)getCurrentTimeOfAddOneHour {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time =  60 * 60 * 1;//一个的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即当前时间的一个小时之前），如果没有，则表示向后的时间间隔（即当前时间的一个小时之后））
    NSDate * lastYear = [date dateByAddingTimeInterval:time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    return startDate;
}

/**
 *  获取到当前时间加三天
 *
 *  @return 返回当前时间加三天
 */
+ (NSString *)getCurrentTimeOfAddThreeDay {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time =  60 * 60 * 1 * 24 * 3;//一个的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即当前时间的一个小时之前），如果没有，则表示向后的时间间隔（即当前时间的一个小时之后））
    NSDate * lastYear = [date dateByAddingTimeInterval:time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    return startDate;
}

/**
 *  获取到当前时间加一天
 *
 *  @return 返回当前时间加一天
 */
+ (NSString *)getCurrentTimeOfOneDay {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time =  24 * 60 * 60 ;//一个的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即当前时间的一个小时之前），如果没有，则表示向后的时间间隔（即当前时间的一个小时之后））
    NSDate * lastYear = [date dateByAddingTimeInterval:time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    return startDate;
}



/**
 *  获取去年的当前时间
 *
 *  @return 返回去年的当前时间
 */
+ (NSString *)getCurrentTimeOfReductionOneYear {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time = 365 * 24 * 60 * 60;//一年的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即去年），如果没有，则表示向后的时间间隔（即明年））
    
    NSDate * lastYear = [date dateByAddingTimeInterval:-time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    return startDate;

}

/**
 *  获取明年的当前时间
 *
 *  @return 返回明年的当前时间
 */
+ (NSString *)getCurrentTimeOfAddOneYear {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //设置时间间隔（秒）（这个我是计算出来的，不知道有没有简便的方法 )
    NSTimeInterval time = 365 * 24 * 60 * 60;//一年的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即去年），如果没有，则表示向后的时间间隔（即明年））
    
    NSDate * lastYear = [date dateByAddingTimeInterval:+time];
    
    //转化为字符串
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    return startDate;
    
}
/**
 *  将时间字符串转换成date
 *
 *  @param string 时间字符串
 *
 *  @return date
 */
+ (NSDate *)getDateWithString:(NSString *)string
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date  = [dateFormatter dateFromString:string];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeData = [date dateByAddingTimeInterval:interval];
    return localeData;
}

/**
 *  将时间字符串转换成date
 *
 *  @param string 时间字符串
 *
 *  @return date
 */
+ (NSDate *)YLgetDateWithString:(NSString *)string
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSDate *date  = [dateFormatter dateFromString:string];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeData = [date dateByAddingTimeInterval:interval];
    return localeData;
}



/**
 *  去AppStore去评分
 */
+ (void)pingFenAction {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *URL = nil;
    NSString *idstr = @"1121257704";
    if(version <7.0){
        URL = [NSString stringWithFormat:@"itms://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",idstr];
    }else{
        URL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%ld",(long)[idstr integerValue]];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL]];
}

#pragma 评分一次的方法

+ (void)goPenFenActionOnceAction:(UIViewController *)viewController {
    
    id a =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *as = [NSString stringWithFormat:@"%@", a]; //版本号获得了
    NSString *xlbanbenHao = [[NSUserDefaults standardUserDefaults] objectForKey:@"xlhehe"];// 沙河中的版本号获得了
//    NSLog(@"%@--%@", as, xlbanbenHao);
    if ([as isEqualToString:xlbanbenHao]) { // 一致
        // 是否有标志 如果有标志的话
        // 点击评分
        // 存上
        if (IS_VALID_STRING([[NSUserDefaults standardUserDefaults] objectForKey:@"xxlqupingfenyici"])) { // 点击过去评分 有标识符
            // 版本号是否一致
            
            if ([as isEqualToString:xlbanbenHao]) { // 如果一致说明没有版本更新不做任何操作
                
            } else { // 不一致说明升级了 评分去
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"求鼓励" message:@"问题解决啦~给我们个好评吧，我们会努力做得更好!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"赏个好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    /** 去评分*/
                    [self pingFenAction];
                    [[NSUserDefaults standardUserDefaults] setObject:@"xl" forKey:@"xxlqupingfenyici"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"默默忽视" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"xl" forKey:@"xxlqupingfenyici"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }];

                [alertVC addAction:okAction];
                [alertVC addAction:cancleAction];
                [viewController presentViewController:alertVC animated:YES completion:nil];
                
            }
            
            
        } else { // 没有点击过去评分
            
//            if (1) { // 去评分
//                // 存上标识符
//            } else { // 不去评分
//                // 存上标识符
//            }
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"求鼓励" message:@"问题解决啦~给我们个好评吧，我们会努力做得更好!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"赏个好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                /** 去评分*/
                [self pingFenAction];
                [[NSUserDefaults standardUserDefaults] setObject:@"xl" forKey:@"xxlqupingfenyici"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"默默忽视" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [[NSUserDefaults standardUserDefaults] setObject:@"xl" forKey:@"xxlqupingfenyici"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }];
            
            [alertVC addAction:okAction];
            [alertVC addAction:cancleAction];
            [viewController presentViewController:alertVC animated:YES completion:nil];

            
        }

        
    } else { // 不一致
        // 不显示版本更新
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"求鼓励" message:@"问题解决啦~给我们个好评吧，我们会努力做得更好!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"赏个好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            /** 去评分*/
            [self pingFenAction];
            [[NSUserDefaults standardUserDefaults] setObject:@"xl" forKey:@"xxlqupingfenyici"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"默默忽视" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setObject:@"xl" forKey:@"xxlqupingfenyici"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }];
        
        [alertVC addAction:okAction];
        [alertVC addAction:cancleAction];
        [viewController presentViewController:alertVC animated:YES completion:nil];
        
        // 新的版本了需要将存的沙河中的标志去除掉
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xxlqupingfenyici"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:as forKey:@"xlhehe"];
    [[NSUserDefaults standardUserDefaults] synchronize];// 同步

}
#if 0
+ (void)goPenFenActionOnceAction:(UIViewController *)viewController
{
    NSString *pathString = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"once.text"];
    NSString *sting = [NSString stringWithContentsOfFile:pathString encoding:NSUTF8StringEncoding error:nil];
    if (!IS_VALID_STRING(sting)) {// 如果存在的话就去评分
         NSString* cName = [NSString stringWithFormat:@"RootViewController %@", @"应用评分", nil];
        [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"求鼓励" message:@"问题解决啦~给我们个好评吧，我们会努力做得更好!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"赏个好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString* cName = [NSString stringWithFormat:@"RootViewController %@", @"应用评分", nil];
            [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
            [@"once" writeToFile:pathString atomically:YES encoding:NSUTF8StringEncoding error:nil];
            /** 去评分*/
            [self pingFenAction];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"默默忽视" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [@"once" writeToFile:pathString atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
        }];
        
        [alertVC addAction:okAction];
        [alertVC addAction:cancleAction];
        [viewController presentViewController:alertVC animated:YES completion:nil];
    }
}
#endif




+(NSDate * )toTiomeString:(NSString * )time{

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSDate *StartdestDate= [dateFormatter dateFromString:time];
    
    return StartdestDate;
    

}



/** 第二个时间戳转字符串*/
+ (NSString *)twoTime:(NSString *)time
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    return string;
}

+ (NSString *) compareCurrentTime:(NSString *)str

{
    
    NSString *timeStamp = [NSString twoTime:str];
    NSDate *longDate = [NSString getDateWithString:timeStamp];
    
    //把字符串转为NSdate
    //    DLog(@"%@", longDate);
    NSString *timeStr = [NSString getCurrentTime];
    NSDate *currentDate = [NSString getDateWithString:timeStr];
    //    DLog(@"%@", currentDate);
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:longDate];
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    
    else if((temp = temp/24) <30){
        
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    
    else if((temp = temp/30) <12){
        
        result = [NSString stringWithFormat:@"%ld月前",temp];
        
    }
    
    else{
        
        temp = temp/12;
        
        result = [NSString stringWithFormat:@"%ld年前",temp];
        
    }
    
    return result;
    
}


/**
 *  自适应设置高度
 *
 *  @param str  要自适应的字符
 *  @param size size
 *  @param dic  字典一些设置
 *
 *  @return CGFloat
 */
+ (CGFloat)setSelfH:(NSString *)str withSize:(CGSize )size withDic:(NSDictionary *)dic
{
    return  [str boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
}
//返回size大小
+ (CGSize)setSizeSelfH:(NSString *)str withSize:(CGSize )size withDic:(NSDictionary *)dic
{
    return [str boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}
//+ (void)showMessage:(NSString *)message toView:(UIView *)view {
//    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText = message;
//    // 再设置模式
//    hud.mode = MBProgressHUDModeCustomView;
//    
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    
//    // 1秒之后再消失
//    [hud hide:YES afterDelay:0.7];
//}
- (NSString *)changeAction
{
    return [self stringByReplacingOccurrencesOfString:@"\r" withString:@"\n"];
    
}

- (NSString *)newChangeAction
{
    NSString *xlChangeSting  = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSString *newChangeString =    [xlChangeSting stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *secondChangeString = [newChangeString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return [secondChangeString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}
- (NSString *)jAction
{
    NSString *xlChangeSting  = [self stringByReplacingOccurrencesOfString:@"<p><strong>" withString:@"\n"];
    NSString *newChangeString =    [xlChangeSting stringByReplacingOccurrencesOfString:@"</strong></p><p>" withString:@"\n"];
    NSString *j = [newChangeString stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    NSString *cocoAction = [j stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    NSString *iooi = [cocoAction stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
    NSString *joo = [iooi stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    NSString *go =  [joo stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
    NSString *iog =   [go stringByReplacingOccurrencesOfString:@"<br/><strong>" withString:@"\n"];
    NSString *dididS =   [iog stringByReplacingOccurrencesOfString:@"<strong>" withString:@"\n"];
    NSString *heSt =  [dididS stringByReplacingOccurrencesOfString:@"</strong>" withString:@"\n"];
    NSString *jous =  [heSt stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    NSString *yy =    [jous stringByReplacingOccurrencesOfString:@"<span>" withString:@"\n"];
    
    NSString *uu =    [yy stringByReplacingOccurrencesOfString:@"</span><span><span>" withString:@"\n"];
    
    NSString *jou = [uu stringByReplacingOccurrencesOfString:@"</span></span>" withString:@"\n"];
    NSString *yueer = [jou stringByReplacingOccurrencesOfString:@"</span>" withString:@"\n"];
    NSString * jjnnn = @"<p style=\"text-indent:24.0pt;\">";
    
    NSString *buibui = [yueer stringByReplacingOccurrencesOfString: [jjnnn stringByReplacingOccurrencesOfString:@"\\" withString:@""] withString:@"\n"];
    NSString *qwe = [buibui stringByReplacingOccurrencesOfString:@"<div>" withString:@"\n"];
      NSString *qwer = [qwe stringByReplacingOccurrencesOfString:@"</div>" withString:@"\n"];

    
    
    return qwer;
}

- (NSString *)removeHuanHangAction
{
    NSString *xlChangeSting  = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return xlChangeSting;

}
+(NSString * )creatAskTypeWithDateArryId:(NSArray * )typeids{
    
    NSString * userTypeId = [NSString new];
    NSMutableArray * dateArr = [NSMutableArray array];
    
    for (NSString * idType in typeids) {
        
        if ([idType isEqualToString:@"1"]) {//1
            [dateArr addObject:@"婚姻家庭"];
        }else if ([idType isEqualToString:@"2"]){//2
            
            [dateArr addObject:@"交通事故"];
            
        }else if ([idType isEqualToString:@"3"]){//3
            [dateArr addObject:@"刑事辩护"];
            
        }else if ([idType isEqualToString:@"4"]){//4
            
            [dateArr addObject:@"劳动工伤"];
        }else if ([idType isEqualToString:@"5"]){//5
            [dateArr addObject:@"土地房产"];
            
        }else if ([idType isEqualToString:@"6"]){//6
            
            [dateArr addObject:@"债权债务"];
        }else if ([idType isEqualToString:@"7"]){//7
            
            [dateArr addObject:@"合同事务"];
        }else if ([idType isEqualToString:@"8"]){//8
            
            [dateArr addObject:@"医疗纠纷"];
        }else if ([idType isEqualToString:@"9"]){//9
            [dateArr addObject:@"公司经营"];
            
        }else if ([idType isEqualToString:@"10"]){//10
            [dateArr addObject:@"损害赔偿"];
            
        }else if ([idType isEqualToString:@"11"]){//11
            
            [dateArr addObject:@"知识产权"];
        }
        // else if([idType isEqualToString:@"12"]){
        
        
        //   [dateArr addObject:@"其他问题"];
        //  }
        
        
        
        
    }
    
    if (IS_VALID_ARRAY(dateArr)) {
        NSMutableString * speciality= [NSMutableString stringWithFormat:@"%@", dateArr[0]];
        
        
        for (int i = 1;i< dateArr.count ; i++) {
            
            [speciality appendString:[NSString stringWithFormat:@",%@",dateArr[i]]];
            
        }
        userTypeId =   speciality.copy;
        
        
    }
    
    
    
    
    return userTypeId;
    
    
}

+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}
/**
 *返回  日 月
 */
+(NSString *)YLaddSecondDateTimes:(NSString * )times{

    //    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *timeStamp = [NSString twoTime:times];
    NSDate *longDate = [NSString getDateWithString:timeStamp];
    
    //把字符串转为NSdate
    //    DLog(@"%@", longDate);
    NSString *timeStr = [NSString getCurrentTime];
    NSDate *currentDate = [NSString getDateWithString:timeStr];
    //    DLog(@"%@", currentDate);
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:longDate];
    NSString *result;
    
    if (timeInterval<=60*60*24) {//两天内
        
        NSString * need_yMd = [timeStamp componentsSeparatedByString:@" "].firstObject;
        NSString *now_yMd = [timeStr componentsSeparatedByString:@" "].firstObject;
    
        if ([need_yMd isEqualToString:now_yMd]) {
            //// 在同一天
            result = @"今天";
        }else{
            ////  昨天
            result = @"昨天";
        }
        
    }
    else{
        
           [dateFormatter setDateFormat:@"dd MM月"];
           result = [dateFormatter stringFromDate: longDate];
        
    }
    
    return result;
 
}

+ (NSString *)importStyleWithHtmlString:(NSString *)HTML
{
    //老的字符串通过HTML这个参数传递过来

    //先找到布局文件的路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"style" ofType:@"css"];
    //    NSLog(@"-%@",filePath);

    //替换HTML字符串中的布局， 修改为通过本地文件配置
    //1.先写一个可用于配置布局的字符串命令，并设置配置类型为本地的文件（命令都是HTML语言， 可以不用懂， 大致知道什么意思就可以了， 文件内容可以让webView中的图片适应屏幕宽度）
    NSString *replace = [NSString stringWithFormat:@"<link href=\"%@\" rel=\"stylesheet\" type=\"text/css\"/>",filePath];
    //2.替换原有的命令字符串
    HTML = [HTML stringByReplacingOccurrencesOfString:@"</head>" withString:replace];
    //    NSLog(@"HTML:%@",HTML);

    //返回新配置的HTML字符串
    return HTML;
//
//    return [self autoWebAutoImageSize:HTML];
    
}
+ (NSString *)autoWebAutoImageSize:(NSString *)html{
    
    NSString * regExpStr = @"<img\\s+.*?\\s+(style\\s*=\\s*.+?\")";
    NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches=[regex matchesInString:html
                                    options:0
                                      range:NSMakeRange(0, [html length])];
    
    
    NSMutableArray * mutArray = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSString* group1 = [html substringWithRange:[match rangeAtIndex:1]];
        [mutArray addObject: group1];
    }
    
    NSUInteger len = [mutArray count];
    for (int i = 0; i < len; ++ i) {
        html = [html stringByReplacingOccurrencesOfString:mutArray[i] withString: @"style=\"width:90%; height:auto;\""];
    }
    
    return html;
}
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font {
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.5f};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:textcolor,NSFontAttributeName:font};
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    return attriStr;
}

-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


+ (void)dataBaseCacheAction
{

    //    NSLog(@"---%@", [ClearCacheTool getSDWebimageSize]);
    NSDate *date = [PathPool getConversionDataFromTheTimePathOfSting];
    //    NSLog(@"%@", date);
    //    DLog(@"%@", date);
    if (date) {
        NSDate *nowDate = [self getDateWithString:[self getCurrentTime]];
        //        NSLog(@"%@", nowDate);
        //        DLog(@"%@", nowDate);
        NSDate *earData = [nowDate earlierDate:date];
        //        NSLog(@"%@", earData);
        //        DLog(@"%@", earData);
        if (earData == date) {
            //说明过了一个小时多了
            //需要删除表
            //            NSLog(@"%@", date);
            //            DLog(@"%@", date);
//            [ClearCacheTool clearSDWebImageCacheSize];// 清除数据
            [self clearCache:nil];// 清理缓存
            NSString *nowSting = [NSString getCurrentTimeOfOneDay];
            NSString *path = [NSString stringWithFormat:@"%@", [PathPool timePath]];
            BOOL isok = [nowSting writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            //            isok ? NSLog(@"写入成功"):NSLog(@"写入失败");
            
            
        } else {
            // 不需要操作
            //            NSLog(@"不需要操作");
            //            DLog(@"不需要操作");
        }
        
    } else {// 路径下没有存的时间
        // 需要将现在的时间加一个小时存入的沙河中
        // 不做操作
        NSString *nowSting = [NSString getCurrentTimeOfOneDay];
        NSString *path = [NSString stringWithFormat:@"%@", [PathPool timePath]];
        //        NSLog(@"%@", path);
        BOOL isok = [nowSting writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
        //        isok ? NSLog(@"写入成功"):NSLog(@"写入失败");
        //        NSLog(@"%@", nowSting);
    }
    
}
+(void)clearCache:(void(^)())cacheBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cacheBlock) {
                cacheBlock();
            }
        });
    });
}

/* 获取单个文件数据大小*/
+ (long long)fileSizeAtPath:(NSString*)filePath {
    /* 创建文件管理者对象 */
    NSFileManager *manager = [NSFileManager defaultManager];
    /* 判断文件中是否存在该文件 */
    if ([manager fileExistsAtPath:filePath]) {
        /* 返回文件大小 */
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    /* 不存在则返回0 */
    return 0;
}

+ (int64_t)folderSizeAtPath:(NSString*)folderPath {
    /* 创建文件管理者对象 */
    NSFileManager *manager = [NSFileManager defaultManager];
    /* 如果没有, 则返回0 */
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    /* 挨个遍历, 判断是否全部遍历 */
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        /* 逐个计算数据大小 */
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    /* 转换为字节返回 */
    return folderSize;
}
+(void)clearCacheSuccess
{
    
}

@end