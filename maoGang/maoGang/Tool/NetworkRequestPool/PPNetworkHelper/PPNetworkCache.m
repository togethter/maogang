//
//  PPNetworkCache.m
//  PPNetworkHelper
//
//  Created by AndyPang on 16/8/12.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import "PPNetworkCache.h"
#import "YYCache.h"

@implementation PPNetworkCache
static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;


+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}





+ (NSString * )getAllHttpCacheSize
{
    // 总大小
    unsigned long long diskCache = [_dataCache.diskCache totalCost];
    
    NSString *sizeText = nil;
    
    if (diskCache >= pow(10, 9)) {
        // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", diskCache / pow(10, 9)];
    } else if (diskCache >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", diskCache / pow(10, 6)];
    } else if (diskCache >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", diskCache / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%zdB", diskCache];
    }
    
    
    return sizeText ;

}

+ (void)removeAllHttpCache
{
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters
{
    if(!parameters){return URL;};
    
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return cacheKey;
}

#pragma mark - 过期方法
+ (void)saveHttpCache:(id)httpCache forKey:(NSString *)key
{
    [self setHttpCache:httpCache URL:key parameters:nil];
}

+ (id)getHttpCacheForKey:(NSString *)key
{
    return [self httpCacheForURL:key parameters:nil];
}

@end

