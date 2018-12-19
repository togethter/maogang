//
//  FontMnager.h
//  maoGang
//
//  Created by xl on 2018/12/19.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontMnager : NSObject
@property (nonatomic, copy) NSString *fontName;
+ (instancetype)fontInstance;

- (UIFont *)fontMangerFontSize:(CGFloat)size;

- (void)registerFontWithPath:(NSURL *)filePath;
// 字体是否下载过
+ (BOOL)fontPathisExist:(NSString *)path;
- (NSURL *)fileURLWithUrlPath:(NSString *)downLoadPath;
// 文件保存后缀
- (NSString *)fileName:(NSString *)downLoadPath;

@end

NS_ASSUME_NONNULL_END
