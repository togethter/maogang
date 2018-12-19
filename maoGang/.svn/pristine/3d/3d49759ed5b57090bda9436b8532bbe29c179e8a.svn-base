//
//  LCMD5Tool.m
//  LvJie
//
//  Created by zhangzhen on 2017/7/1.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "LCMD5Tool.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation LCMD5Tool
#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - 返回时间戳

+ (NSString *)returnsTheTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

#pragma mark - 返回加密时间戳

+ (NSString *)returnsTheMD5EncryptionTimestamp:(NSString *)timeString{
    NSString *timeLocation = timeString;
    NSString *timefirstTwo = [timeLocation substringFromIndex:2];
    NSString *timeEndOf = [timeLocation substringToIndex:2];
    NSString *timeCode = [NSString stringWithFormat:@"%@%@",timefirstTwo,timeEndOf];
    NSString *md5Time = [LCMD5Tool MD5ForLower32Bate:[NSString stringWithFormat:@"%@%@",timeCode,@"panjueshu.com"]];

    return md5Time;
}
@end
