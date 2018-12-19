//
//  BaseModel.m
//  LeForProject
//
//  Created by zhangzhen on 2018/6/20.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([value isKindOfClass:[NSNumber class]]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
        
    }
    else if ([value isEqual:[NSNull null]]||value==nil){
        [self setValue:@"" forKey:key];
    }
    else{
        [super setValue:value forKey:key];
    }
    
}
//当value为nil时，将调用
-(void)setNilValueForKey:(NSString *)key{
    
    [self setValue:@"" forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self=[super init]) {
        
        if ([dic isKindOfClass:[NSDictionary class]]) {
            
            [self setValuesForKeysWithDictionary:dic];
            self.xlDic = dic;
        }
        
    }
    return self;
}

+(instancetype)loadModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}


@end
