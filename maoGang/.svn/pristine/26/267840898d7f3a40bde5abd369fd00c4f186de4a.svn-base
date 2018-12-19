//
//  SectionFooterView.m
//  gaofangPenYouQuan
//
//  Created by zhangzhen on 2018/11/19.
//  Copyright © 2018 zhangzhen. All rights reserved.
//

#import "SectionFooterView.h"



@implementation SectionFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setTop];
    }
    return self;
}

-(void)setTop{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
