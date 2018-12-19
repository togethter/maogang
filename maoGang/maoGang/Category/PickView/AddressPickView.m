//
//  PopupView.m
//  买布易
//
//  Created by 张建 on 15/6/26.
//  Copyright (c) 2015年 张建. All rights reserved.
//

#import "AddressPickView.h"

#import "UIView+Extension.h"

#define navigationViewHeight 44.0f
#define pickViewViewHeight 200.0f
#define buttonWidth 60.0f

//131 8507 7686


//#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
@interface AddressPickView ()

@property(nonatomic,strong)NSDictionary *pickerDic;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)NSArray *selectedArray;
@property(nonatomic,strong)NSMutableArray *cityArray;
@property(nonatomic,strong)NSArray *townArray;
@property(nonatomic,strong)UIView *bottomView;//包括导航视图和地址选择视图
@property(nonatomic,strong)UIPickerView *pickView;//地址选择视图
@property(nonatomic,strong)UIView *navigationView;//上面的导航视图
//@property (nonatomic, strong) NSMutableArray *areaArray;// 区域数组



@end

@implementation AddressPickView
+ (instancetype)shareInstance
{
    
    static AddressPickView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[AddressPickView alloc] init];
    });
    [shareInstance showBottomView];
    return shareInstance;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self _addTapGestureRecognizerToSelf];
        [self _getPickerData];
        [self _createView];
    }
    return self;
    
}


//- (NSMutableArray *)areaArray
//{
//    if (!_areaArray) {
//        _areaArray = [NSMutableArray array];
//    }
//    return _areaArray;
//}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}
#pragma mark - get data
- (void)_getPickerData
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xlCity" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *xlProviceDic = self.pickerDic[@"province"];
    for (NSString *key in xlProviceDic) {
        NSDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:xlProviceDic[key] forKey:key];
        [self.provinceArray addObject:dic];
    }
    
    
    NSDictionary *xlcityDic = self.pickerDic[@"city"];
    NSDictionary *xProviceDic = self.provinceArray.firstObject;
    if (xProviceDic && [xProviceDic isKindOfClass:[NSDictionary class]] && xProviceDic.count) {
        NSDictionary *newDic = xlcityDic[xlProviceDic.allKeys.firstObject];
        for (NSString *key in newDic) {
            NSDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:newDic[key] forKey:key];
            [self.cityArray addObject:dic];
        }
        
    }

    
//    NSDictionary *xareadic = self.cityArray.firstObject;
//    if (xareadic && [xareadic isKindOfClass:[NSDictionary class]] && xareadic.count) {
//        NSDictionary *newAreaDic = self.pickerDic[@"area"];
//        NSDictionary *xlAreaDic = newAreaDic[xareadic.allKeys.firstObject];
//        for (NSString *key in xlAreaDic) {
//            NSDictionary *xlAre = [NSMutableDictionary dictionary];
//            [xlAre setValue:xlAreaDic[key] forKey:key];
//            [self.areaArray addObject:xlAre];
//        }
//
//
//
//    }
//
    
    
   
    
    
    

}
-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
-(void)_createView
{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
    
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationViewHeight)];
    _navigationView.backgroundColor = [UIColor whiteColor];
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(kScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_navigationView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, navigationViewHeight, kScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    _pickView.dataSource = self;
    _pickView.delegate =self;
    [_bottomView addSubview:_pickView];
    
    
}
-(void)tapButton:(UIButton*)button
{
    
    BOOL isok = [self anySubViewScrolling:self.pickView];
    if (isok) {
        //如果是正在滑动的话就不要他选择
        return;
    }
    //点击确定回调block
    if (button.tag == 1) {
        if (IS_VALID_ARRAY(self.provinceArray) && IS_VALID_ARRAY(self.cityArray)) {
            NSDictionary *proviceDic = [self.provinceArray objectAtIndex:[_pickView selectedRowInComponent:0]];
            NSDictionary *cityDic = [self.cityArray objectAtIndex:[_pickView selectedRowInComponent:1]];
//            NSDictionary *townDic = [self.areaArray objectAtIndex:[_pickView selectedRowInComponent:2]];
            if (self.block) {
                self.block(proviceDic,cityDic,@{});
            }
        }
        if (IS_VALID_ARRAY(self.provinceArray) && !IS_VALID_ARRAY(self.cityArray)) {
            NSDictionary *proviceDic = [self.provinceArray objectAtIndex:[_pickView selectedRowInComponent:0]];
            NSDictionary *cityDic = [self.cityArray objectAtIndex:[_pickView selectedRowInComponent:1]];
            if (self.block) {
                self.block(proviceDic,@{},@{});
            }
        }
    }
    
    [self hiddenBottomView];
    
    
}
-(void)showBottomView
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        
//        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight-50;
//        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight - 50;
        _bottomView.top  = kScreenHeight - pickViewViewHeight - navigationViewHeight;
        
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.numberOfLines = 0;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:14];
    if (component == 0) {
        if (self.provinceArray.count > row) {
            NSDictionary *dic = self.provinceArray[row];
            lable.text = dic.allValues.firstObject;
        }

    } else if (component == 1) {
        if (self.cityArray.count > row) {
            NSDictionary *dic = self.cityArray[row];
            lable.text = dic.allValues.firstObject;
        }
        
    }
    return lable;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat pickViewWidth = kScreenWidth/3;
    
    return pickViewWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        if (self.provinceArray.count > row) {
            [self.cityArray removeAllObjects];
//            [self.areaArray removeAllObjects];
            NSDictionary *dic = self.provinceArray[row];
            NSDictionary *cityDic = self.pickerDic[@"city"];
            NSDictionary *selectDic = cityDic[dic.allKeys.firstObject];
            for (NSString *key in selectDic) {
                NSDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:selectDic[key] forKey:key];
                [self.cityArray addObject:dic];
            }
            
        }
            NSDictionary * xdic = self.cityArray.firstObject;
            NSDictionary *areaDic = self.pickerDic[@"area"];
            NSDictionary *xselectDic = areaDic[xdic.allKeys.firstObject];
        
        for (NSString *key in xselectDic) {
                NSDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:xselectDic[key] forKey:key];
//                [self.areaArray addObject:dic];
            }
            
        [pickerView reloadComponent:1];
//        [pickerView reloadComponent:2];
        if (self.cityArray.count) {
            
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
//        if (self.areaArray.count) {
//            [pickerView selectRow:0 inComponent:2 animated:YES];
//
//        }
        

    }
    
    if (component == 1) {
        if (self.cityArray.count > row) {
            NSDictionary * dic = self.cityArray[row];
            NSDictionary *areaDic = self.pickerDic[@"area"];
            NSDictionary *selectDic = areaDic[dic.allKeys.firstObject];
//            [self.areaArray removeAllObjects];
            for (NSString *key in selectDic) {
                NSDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:selectDic[key] forKey:key];
//                [self.areaArray addObject:dic];
            }
            
        }
        
//        [pickerView reloadComponent:2];
//        if (self.areaArray.count) {
//            [pickerView selectRow:0 inComponent:2 animated:YES];
//
//        }
    }

    
    
}
- (BOOL)anySubViewScrolling:(UIView *)view{
    if ([view isKindOfClass: [UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}

@end



