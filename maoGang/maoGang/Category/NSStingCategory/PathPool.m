//
//  PathPool.m
//  ChongFa
//
//  Created by bilin on 16/8/19.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import "PathPool.h"
#import "NSString+Extension.h"
/** 过一个小时清除缓存的时间路径*/
static NSString *timeSting = @"xltime.text";
/** 一天的时间*/
static NSString *oneDayTime = @"xlOneDayTime.text";
@implementation PathPool



+ (NSString *)timePath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     return  [documentPath stringByAppendingPathComponent:timeSting];
}

+ (NSString *)oneDayPath
{
   NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  return  [documentPath stringByAppendingPathComponent:oneDayTime];
}

//获取存到沙河中的时间然后转换成data
+ (NSDate *)getConversionDataFromTheTimePathOfSting {
    NSData *data = [NSData dataWithContentsOfFile:self.timePath];
    if (data) {
        NSString *sting = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return [NSString getDateWithString:sting];
    } else {
        return nil;
    }
    
}
/** 得到存入沙河里存入的一天的时间*/
+ (NSDate *)getOneDayTime {
    NSData *data = [NSData dataWithContentsOfFile:self.oneDayPath];
    if (data) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return [NSString getDateWithString:string];
    } else {
        return nil;
    }
    
}


/**
 *  删除某一路径下的文件
 *
 *  @param path 路径
 *
 *  @return YES成功NO失败
 */
+ (BOOL)clearFileSomeThingFromPath:(NSString *)path
{
    NSFileManager *manger = [NSFileManager defaultManager];
    return [manger removeItemAtPath:path error:nil];
}


@end
