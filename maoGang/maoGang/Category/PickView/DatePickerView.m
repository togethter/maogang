//
//  DatePickerView.m
//  DatePickerStudy
//
//  Created by 张发行 on 16/9/5.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "DatePickerView.h"





@implementation DatePickerView


- (DatePickerView *)initWithCustomeHeight:(CGFloat)height
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height=height<200?200:height)];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.05].CGColor;
        
        //创建取消 确定按钮
        UIButton *cannel = [UIButton buttonWithType:UIButtonTypeSystem];
        cannel.frame = CGRectMake(20, 5, 50, 40);
        [cannel setTitle:@"取消" forState:0];
        cannel.tag = 1;
        [cannel addTarget:self action:@selector(cannelOrConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cannel];
        
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeSystem];
        confirm.frame = CGRectMake(SCREEN_WIDTH-70, 0, 50, 40);
        [confirm setTitle:@"确定" forState:0];
        confirm.tag = 2;
        [confirm addTarget:self action:@selector(cannelOrConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirm];
        
        // 创建datapikcer
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, height-40)];
        _datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        // 本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        
        // 日期控件格式
//        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.maximumDate = [NSDate date];
        [self addSubview:_datePicker];
        
    }
    return self;
}


//计算某个时间与此刻的时间间隔（天）
- (NSString *)dayIntervalFromNowtoDate:(NSString *)dateString
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
        NSDate *nowDate = [NSDate date];
        NSString *birth = dateString;
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       //生
       NSDate *birthDay = [dateFormatter dateFromString:birth];
       
       //用来得到详细的时
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
       NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
       if([date year] >0)
    {
//        NSLog(@"%@",[NSString stringWithFormat:(@"%ld岁%ld月%ld天"),(long)[date year],(long)[date month],(long)[date day]]) ;
        return [NSString stringWithFormat:@"%d",date.year];;
    }else if([date month] >0)
    {
        return @"1";
//        NSLog(@"%@",[NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]]);
    }else if([date day]>0)
    {
        return @"1";
//        NSLog(@"%@",[NSString stringWithFormat:(@"%ld天"),(long)[date day]]);
    }
    else {
    return @"0";
      NSLog(@"0天");
    }
  
    
    

}

//选择确定或者取消
- (void)cannelOrConfirm:(UIButton *)sender
{
    if (sender.tag==2) {
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString *choseDateString = [dateformatter stringFromDate:_datePicker.date];
        
        //如果选择的日期是未来
        if ([[[NSDate date] laterDate:self.datePicker.date] isEqualToDate:self.datePicker.date]) {
            NSLog(@"对不起，不能选择将来时！");
            return;
        }
        
        //计算出剩余多久生日
        //拿到生日中的 月&日 年份为今年 拼接起来 转化为时间 与今天相减
        NSArray *tempArr = [choseDateString componentsSeparatedByString:@"-"];
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        [currentFormatter setDateFormat:@"yyyy"];
        NSString *currentYear = [currentFormatter stringFromDate:[NSDate date]];
        NSString *appendString = [NSString stringWithFormat:@"%@-%@-%@",currentYear,tempArr[1],tempArr[2]];
        NSString *intercalStr = [self dayIntervalFromNowtoDate:choseDateString];
        if (self.confirmBlock) {
            self.confirmBlock(choseDateString, intercalStr);
        }
        self.confirmBlock(choseDateString,intercalStr);
    }
    if (self.cannelBlock) {
        self.cannelBlock();
    }
    
//    [self removeFromSuperview];
}
- (void)dealloc
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@",NSStringFromClass(self.class)]);
}

@end
