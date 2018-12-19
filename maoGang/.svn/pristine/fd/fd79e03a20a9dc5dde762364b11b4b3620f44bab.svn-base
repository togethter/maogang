
//
//  FontMnager.m
//  maoGang
//
//  Created by xl on 2018/12/19.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "FontMnager.h"

@implementation FontMnager

+ (instancetype)fontInstance {
    static FontMnager *fontMa = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fontMa = [FontMnager new];
    });
    return fontMa;
}

- (void)setFontName:(NSString *)fontName {
    if (!fontName || [_fontName isEqualToString: fontName]) return;
    _fontName = fontName;
}

- (UIFont *)fontMangerFontSize:(CGFloat)size {
   BOOL exist = self.fontName? YES:NO;
    if (exist) {
        return [UIFont fontWithName:self.fontName size:size];
    }
    return [UIFont systemFontOfSize:size];
}

// 注册字体
- (void)registerFontWithPath:(NSURL *)filePath {
    NSString *imgFilePath = [filePath path];
    NSURL *fontUrl = [NSURL fileURLWithPath:imgFilePath];
    CGDataProviderRef fontDataProvider =  CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    self.fontName = fontName;
}
+ (BOOL)fontPathisExist:(NSString *)path {
    // 1. cache 路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //1.0.1 XLFont文件夹
    cachePath = [cachePath stringByAppendingPathComponent:@"XLFont"];
    
    if (!IS_VALID_STRING(path)) {
        return NO;
    }
    if ([UIDevice currentDevice].systemName.floatValue <= 9.0) {
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<>"].invertedSet];
    }
    NSString *filePath = [cachePath stringByAppendingPathComponent:path.md5];
   return  [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}
- (NSURL *)fileURLWithUrlPath:(NSString *)downLoadPath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //1.0.1 XLFont文件夹
    cachePath = [cachePath stringByAppendingPathComponent:@"XLFont"];
    NSString *fileName =  [self fileName:downLoadPath];
    cachePath = [cachePath stringByAppendingPathComponent:fileName];
    NSURL *fileUrl = [NSURL fileURLWithPath:cachePath];
    return fileUrl;
    
}

- (NSString *)fileName:(NSString *)downLoadPath {
    if ([UIDevice currentDevice].systemName.floatValue <= 9.0) {
        downLoadPath = [downLoadPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        downLoadPath = [downLoadPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<>"].invertedSet];
    }
    return downLoadPath.md5;
}
@end
