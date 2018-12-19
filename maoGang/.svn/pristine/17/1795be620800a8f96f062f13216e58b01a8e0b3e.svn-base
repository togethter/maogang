//
//  YLPushUMModel.m
//  maoGang
//
//  Created by zhangzhen on 2018/12/13.
//  Copyright © 2018 bilin. All rights reserved.
//

#import "YLPushUMModel.h"

@implementation YLPushUMModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"aps"]) {
        NSDictionary * dic = (NSDictionary *)value;
        self.apsModel = [YLPushApsModel loadModelWithDictionary:dic];
    }
    
}

@end
