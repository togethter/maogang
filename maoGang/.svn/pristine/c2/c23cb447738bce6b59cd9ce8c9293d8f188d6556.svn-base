//
//  UserModel.m
//  maoGang
//
//  Created by xl on 2018/11/29.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"ToKen"]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:@"Token"];
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_Auth forKey:XLStringSelector(Auth)];
    [aCoder encodeObject:_MemberId forKey:XLStringSelector(MemberId)];
    [aCoder encodeObject:_Token forKey:XLStringSelector(Token)];
    [aCoder encodeObject:_Sex forKey:XLStringSelector(Sex)];
    [aCoder encodeObject:_Nick forKey:XLStringSelector(Nick)];
    [aCoder encodeObject:_Autograph forKey:XLStringSelector(Autograph)];
    [aCoder encodeObject:_HeadPic forKey:XLStringSelector(HeadPic)];
    [aCoder encodeObject:_RealName forKey:XLStringSelector(RealName)];
    [aCoder encodeObject:_MemberType forKey:XLStringSelector(MemberType)];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _Auth = [aDecoder decodeObjectForKey:XLStringSelector(Auth)];
        _MemberId = [aDecoder decodeObjectForKey:XLStringSelector(MemberId)];
        _Token= [aDecoder decodeObjectForKey:XLStringSelector(Token)];
        _Sex= [aDecoder decodeObjectForKey:XLStringSelector(Sex)];
        _Nick= [aDecoder decodeObjectForKey:XLStringSelector(Nick)];
        _Autograph= [aDecoder decodeObjectForKey:XLStringSelector(Autograph)];
        _HeadPic= [aDecoder decodeObjectForKey:XLStringSelector(HeadPic)];
        _RealName= [aDecoder decodeObjectForKey:XLStringSelector(RealName)];
        _MemberType= [aDecoder decodeObjectForKey:XLStringSelector(MemberType)];
    }
    return self;
}



@end
