//
//  YXHTTPRequst.h
//  JS_Block&Networking
//
//  Created by 向乾操 on 16/2/29.
//  Copyright © 2016年 向乾操. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPNetworkHelper.h"
@class AFHTTPSessionManager;
@class PPNetworkHelper;
typedef NS_ENUM(NSInteger, YXRequstMethodType) {
    YXRequstMethodTypeGET   = 0,
    YXRequstMethodTypePOST  = 1
};

@interface YXHTTPRequst : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *mamager;

- (void)YXHTTPRequstCachePolicy:(NSURLRequestCachePolicy)cachePolicy;
+ (YXHTTPRequst *)shareInstance;
// 不需要singn的网络请求用户升级请求appStore的
- (void)noSignNetworking:(NSString *)urlString
        parameters:(NSDictionary *)parame
            method:(YXRequstMethodType)TYPE
           success:(void (^) (NSDictionary *))success
          failsure:(void (^) (NSError *))failsure;

- (void)networking:(NSString *)urlString
        parameters:(NSDictionary *)parame
            method:(YXRequstMethodType)TYPE
          withView:(UIViewController *)VC
           success:(void (^) (NSDictionary *))success
          failsure:(void (^) (NSError *))failsure;

- (void)networking:(NSString *)urlString
        parameters:(NSDictionary *)parame
            method:(YXRequstMethodType)TYPE
           success:(void (^) (NSDictionary *))success
          failsure:(void (^) (NSError *))failsure;




- (NSString*)iphoneType;

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
- (void)uploadImagesWithURL:(NSString *)URL
                 parameters:(id)parameters
                       name:(id)name
                     images:(NSArray<UIImage *> *)images
                  fileNames:(NSArray<NSString *> *)fileNames
                 imageScale:(CGFloat)imageScale
                  imageType:(NSString *)imageType
                   progress:(PPHttpProgress)progress
                    success:(PPHttpRequestSuccess)success
                    failure:(PPHttpRequestFailed)failure;

@end
