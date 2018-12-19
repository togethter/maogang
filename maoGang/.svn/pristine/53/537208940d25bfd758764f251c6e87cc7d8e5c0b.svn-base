//
//  SystemUpdateManager.m
//  ChongFa
//
//  Created by bilin on 2017/3/23.
//  Copyright © 2017年 lixueliang. All rights reserved.
//ljVersion

#import "SystemUpdateManager.h"
#import "SystemUpModel.h"
#import "SystemUpViewBtn.h"
@interface SystemUpdateManager ()
@end
@implementation SystemUpdateManager

//updateAll // 0 部分跟新 1 所有的强制更新  2所有不更新 appstore的时候选择2，  3 所有版本都不需要强制跟新
//
//其中在versionDicArr 中每一个版本的数组中最后一位有一个标识符位改标志服非空（YES）或者（NO）—————YES 表示强制更新， NO —— 表示不强制跟新
//如果选择0的话， 返回的数据中最后一位是YES， （改版本）表示强制跟新， 返回的是NO的话 （改版本）表示不强制跟新
//选择1的话， 所有版本都要强制更新
+ (void)showVersionWith:(AppDelegate *)delegate{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[YXHTTPRequst shareInstance]networking:UpdateIOS parameters:nil method:YXRequstMethodTypePOST success:^(NSDictionary *obj) {
                SystemUpModel *systemUpModel = [SystemUpModel new];
                [systemUpModel setValuesForKeysWithDictionary:obj];
                NSArray *desArray =  systemUpModel.versionDicArr[[self getVersion]];
                
                if ([systemUpModel.updateAll isEqualToString:@"1"]) {// 所有强制更新
                    
                    [self VersionButton:delegate isHiddenDeleteBtn:YES withArray:desArray];
            
                } else if ([systemUpModel.updateAll isEqualToString:@"0"]) { // 部分跟新 我们现在总共有5个版本
                    
                    if ([systemUpModel.versionArray containsObject:[self getVersion]]) {
                        
                        if ([desArray.lastObject isEqualToString:@"YES"]) { // 部分强制跟新
                            [self VersionButton:delegate isHiddenDeleteBtn:YES withArray:desArray];
                            
                        } else if ([desArray.lastObject isEqualToString:@"NO"]) {// 部分不需要强制更新
                            
                            [self VersionButton:delegate isHiddenDeleteBtn:NO withArray:desArray];
                        }
                    }
                } else if ([systemUpModel.updateAll isEqualToString:@"2"]) {// 所有不跟新
                    
                    
                } else if ([systemUpModel.updateAll isEqualToString:@"3"]) {// 版本不强制跟新显示❌号
                    if ([systemUpModel.versionArray containsObject:[self getVersion]]) {
                        
                        [self VersionButton:delegate isHiddenDeleteBtn:NO withArray:desArray];
                        
                    }
                }
            
           
            
        } failsure:^(NSError *error) {
            
        }];
        
        
//        NSDictionary  * JJJJJdic  = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:UpdateIOS]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            DLog(@"JJJJJdic=%@",JJJJJdic);
//            SystemUpModel *systemUpModel = [SystemUpModel new];
//            [systemUpModel setValuesForKeysWithDictionary:JJJJJdic];
//            NSArray *desArray =  systemUpModel.versionDicArr[[self getVersion]];
//
//            if ([systemUpModel.updateAll isEqualToString:@"1"]) {// 所有强制更新
//
//                [self VersionButton:delegate isHiddenDeleteBtn:YES withArray:desArray];
//            } else if ([systemUpModel.updateAll isEqualToString:@"0"]) { // 部分跟新 我们现在总共有5个版本
//
//                if ([systemUpModel.versionArray containsObject:[self getVersion]]) {
//
//                    if ([desArray.lastObject isEqualToString:@"YES"]) { // 部分强制跟新
//                        [self VersionButton:delegate isHiddenDeleteBtn:YES withArray:desArray];
//
//                    } else if ([desArray.lastObject isEqualToString:@"NO"]) {// 部分不需要强制更新
//
//                        [self VersionButton:delegate isHiddenDeleteBtn:NO withArray:desArray];
//                    }
//                }
//            } else if ([systemUpModel.updateAll isEqualToString:@"2"]) {// 所有不跟新
//
//
//            } else if ([systemUpModel.updateAll isEqualToString:@"3"]) {// 版本不强制跟新显示❌号
//                if ([systemUpModel.versionArray containsObject:[self getVersion]]) {
//
//                    [self VersionButton:delegate isHiddenDeleteBtn:NO withArray:desArray];
//
//                }
//            }
//        });
        
//    });
}


// 版本更新
+ (void)VersionButton:(AppDelegate *)delegate isHiddenDeleteBtn:(BOOL)isHiddenDeleteBtn withArray:(NSArray *)xarray
{
   
    [[YXHTTPRequst shareInstance] noSignNetworking:@"http://itunes.apple.com/lookup?id=1440263218" parameters:nil method:YXRequstMethodTypePOST success:^(NSDictionary *dic) {
        DLog(@"dic---%@",dic);
        NSArray *array = dic[@"results"];
        NSDictionary *verDic = array.firstObject;
        NSString * version = verDic[@"version"];

        if (version != nil) {
            [self checkAppUpdate:version appDelegate:delegate isHiddenDeleteBtn:isHiddenDeleteBtn withArray:xarray];
        }
        
    } failsure:^(NSError *error) {
        
    } ];
    
}

+ (NSString *)getVersion
{
    id a =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *as = [NSString stringWithFormat:@"%@", a]; //版本号获得了
    return as;
}


#pragma mark ---- 比较当前版本与最新上线版本作比较
+ (void)checkAppUpdate:(NSString *)appInfo appDelegate:(AppDelegate *)delegate isHiddenDeleteBtn:(BOOL)isHidden withArray:(NSArray *)array
{
    // 获取当前版本
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    /*
     *  判断， 如果当前版本与发布的版本不相同， 则进入更新， 如果相等， 那么当前的版本就是最高版本
     */
    if (![appInfo isEqualToString:version]) {
        
        [SystemUpViewBtn alertWithClickBlock:^(BOOL isok) {
            if (isok) {
//                itms-apps://：itunes.apple.com/cn/app/Zhen-Zhen/id1433342486?mt=8
                NSString *url = @"https://itunes.apple.com/cn/app/nightchat/id1440263218?mt=8";

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
            
        } title:array subTitle:appInfo canHiddenDeleteBtn:isHidden];
        
    } else {
        
    }
}
@end
