//
//  NODataView.m
//  LvJie
//
//  Created by bilin on 2018/2/9.
//  Copyright © 2018年 Bilin-Apple. All rights reserved.
//

#import "NODataView.h"


@interface NODataView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *desLb;



@end
@implementation NODataView


+ (instancetype)noDataViewWithImage:(NSString *)imageString withDescription:(NSString *)description
{
    NODataView *view = [[[self class] alloc] initWithFrame:CGRectZero withImageString:imageString withDescription:description];
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame withImageString:(NSString *)imageString withDescription:(NSString *)description
{
    UIImage *image = [UIImage imageNamed:imageString];
    CGFloat h = image.size.height;
    h += 20 +12;
    frame = CGRectMake(0, 0, kScreenWidth, h);
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
        self.desLb = [[UILabel alloc] init];
        self.desLb.font = [UIFont fontWithName:FontName size:14];
        self.desLb.textColor = [UIColor darkGrayColor];
        self.desLb.text = description;
        [self addSubview:self.imageView];
        [self addSubview:self.desLb];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        [self.desLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(12);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
    return self;
}
@end
