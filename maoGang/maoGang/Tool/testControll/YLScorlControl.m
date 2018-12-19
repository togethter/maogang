//
//  ScorllView.m
//  TestControl
//
//  Created by lanouhn on 16/4/1.
//  Copyright © 2016年 ZS. All rights reserved.
//

#import "YLScorlControl.h"
#define  orColor [UIColor lightGrayColor]
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define Default_BottomLineColor     [UIColor redColor]
#define Default_BottomLineHeight
#define Default_ButtonHeight        45
#define Default_TitleColor          [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.000]
#define Default_HeadViewBackgroundColor  [UIColor colorWithRed:0.842 green:0.917 blue:1.000 alpha:1.000]
#define Default_FontSize            14
#define MainScreenWidth             [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight            [[UIScreen mainScreen]bounds].size.height
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define SeletBtnColor [UIColor blackColor]
@interface YLScorlControl () <UIScrollViewDelegate>
/* 文字scrollView */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/* 控制器 */
@property (nonatomic, strong) UIScrollView *contentScrollView;
/* 标签按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;
/* 选中的按钮 */
@property (nonatomic, strong) UIButton *selectedBtn;
/* 选中的按钮背景图 */
@property (nonatomic, strong) UIView *imageBackView;

@property (nonatomic ,strong) NSMutableArray *frameArray;



@end


static CGFloat const titleH = 60;/** 文字高度  */
static CGFloat const leftMargin = 30;// 左边的间距
//static CGFloat const midMargin = 20;// 中间的间距
static CGFloat const LineBottomMargin = 12;// 下划线距离下边的间距
static CGFloat const lineHeight = 3;// 下划线的高度

@implementation YLScorlControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleScrolEnabled = YES;
        self.midMargin = 30;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleScrolEnabled = YES;
        self.midMargin = 30;

    }
    return self;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        self.buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)frameArray {
    if (!_frameArray) {
        _frameArray = [NSMutableArray array];
        for (int i = 0; i < self.buttons.count; i++) {
            if (i + 1 == self.buttons.count) {
                break;
            }
            UIButton *btn = self.buttons[i];
            UIButton *net = nil;
            if (i + 1 < self.buttons.count) {
                net = self.buttons[i + 1];
            }
            CGPoint btncenter = btn.center;
            CGPoint netcenter = net.center;
            CGFloat length = netcenter.x - btncenter.x;
            NSDictionary *dic = @{@"btn":btn,@"length":@(length)};
            [_frameArray addObject:dic];
        }
    }
    return _frameArray;
}

- (void)show {
    [self setTitleScrollView]; /* 添加文字标签 */
    [self setContentScrollView]; /* 添加scrollView */
    [self setupTitle]; /* 设置标签按钮 文字 背景图*/
    UIViewController *superVC = [self findViweController:self];
    self.contentScrollView.contentSize = CGSizeMake(superVC.childViewControllers.count * ScreenW, 0);
    // 整屏翻页
    self.contentScrollView.pagingEnabled = YES;
    // 不显示水平指示器
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    // 反弹效果
    self.contentScrollView.bounces = NO;
}

/**
 *  找到自己的视图控制器
 */
- (UIViewController *)findViweController:(UIView *)sourceView {
    id target = sourceView;
    while (target) {
        // 自己肯定不是, 直接跳过自己查找, 提高代码执行的效率
        // 通过UIResponder的属性, 查找上一级
        target = ((UIResponder *)target).nextResponder;
        // 对比类
        if ([target isKindOfClass:[UIViewController class]]) {
            // 找到后直接跳出循环, 提高代码的执行效率 (可以先执行一次, 记录这个控制器, 之后就不用一直调用此方法了)
            break;
        }
    }
    return target;
}

/**
 *  给自己所在的视图控制器添加子视图控制器, 并利用title属性记录标签名
 */
- (void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle {
    UIViewController *superVC = [self findViweController:self];
    childVC.title = vcTitle;

    [superVC addChildViewController:childVC];
    
    
}

/**
 *  设置文字标签ScrollView
 */
- (void)setTitleScrollView {
    
    UIViewController *superVC = [self findViweController:self];
    CGRect rect = CGRectMake(0, 0, ScreenW, titleH);
    // 此时只设置frame
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
  
    // 添加到父视图上, 这个父视图是父视图控制器的根视图
    if (self.contentView) {
        [self.contentView addSubview:self.titleScrollView];
        return;
    }
    [superVC.view addSubview:self.titleScrollView];
}

/**
 *  设置子视图控制器所在的ScrollView
 */
- (void)setContentScrollView {
    UIViewController *superVC = [self findViweController:self];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGFloat H = CGRectGetHeight(superVC.view.frame);
    CGFloat w = ScreenW;
    if (self.contentView) {
        H = CGRectGetHeight(self.contentView.frame);
        w = CGRectGetWidth(self.contentView.frame);
    }
    CGRect rect = CGRectMake(0, y, ScreenW, H - titleH);
    // 此时只设置frame,
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    // 添加到父视图, 这个父视图也是父视图控制器的根视图
     UIView *contentView = nil;
    if (self.contentView) {
        [self.contentView addSubview:self.contentScrollView];
        contentView = self.contentView;
    } else {
        [superVC.view addSubview:self.contentScrollView];
        contentView = superVC.view;
    }
   
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_top).offset(y);
        make.left.mas_equalTo(contentView.mas_left);
        make.right.mas_equalTo(contentView.mas_right);
        make.bottom.mas_equalTo(contentView.mas_bottom);
        
    }];
}

/**
 *  设置标签
 */
- (void)setupTitle {
    UIViewController *superVC = [self findViweController:self];
    // 标签的个数, 根据父视图控制器的子视图控制器个数获得
    NSUInteger count = superVC.childViewControllers.count;
#pragma mark---更改下面线的位置  及  宽度
    // 图片在x轴上的初始位置
    CGFloat x = 18;
    // 标签的宽
    CGFloat w = kScreenWidth / superVC.childViewControllers.count;
    // 标签的高
    CGFloat h  = titleH;
    {
//    // 添加图片  (文字下的横线)
//    self.imageBackView = [[UIView alloc] initWithFrame:CGRectMake(x, titleH-3, w - 2 * x  , 2)];
////    self.imageBackView.layer.cornerRadius = 5;
////    self.imageBackView.layer.masksToBounds = YES;
////    self.imageBackView.image = [UIImage imageNamed:@"b1.png"];
////    self.imageBackView.backgroundColor = [UIColor colorWithRed:0.000 green:0.522 blue:0.847 alpha:0.669];
//    self.imageBackView.backgroundColor = [UIColor colorWithRed:126/256.0f green:202/256.0f blue:255/256.0f alpha:1];
//
////    self.imageBackView.userInteractionEnabled = YES;
//    [self.titleScrollView addSubview:self.imageBackView];
    }
    // 创建标签button
    for (int i = 0; i < count; i++) {
        // 找到对应的controller
        UIViewController *vc = superVC.childViewControllers[i];
        // 设置每个标签的x
        x = i * w;
        // 设置每个标签的frame
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        // 利用button的tag属性做下记录(记录button对应的Controller在childControllers的下标)
        btn.tag = i;
        // 设置标签的文字
        [btn setTitle:vc.title forState:(UIControlStateNormal)];
        [btn setTitleColor:Default_TitleColor forState:(UIControlStateNormal)];
        [btn sizeToFit];
        CGFloat btnX = 0.f;
        if (self.buttons.count == i && self.buttons.count != 0) {
            UIButton *btn = self.buttons[i - 1];
            btnX = btn.mj_x + btn.mj_w;
        }
        i == 0 ? (btnX = leftMargin):(btnX+= self.midMargin);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        CGRect rect = CGRectMake(btnX, 0,btn.mj_w , h);
        btn.frame = rect;
        
        
        
      

      //  btn.backgroundColor = [UIColor purpleColor];
        // 添加标签点击事件
        [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        // 把标签添加到标签数组中
        [self.buttons addObject:btn];
        // 展示在标签ScrollView上
        [self.titleScrollView addSubview:btn];
        if (i == 0) {
            // 开始的时候默认选中第一个button
            [self click:btn];
        }
        
        
        
    }
    
    // 设置标签ScrollView的内容页大小
   
    UIButton *btn =  self.buttons.lastObject;
    self.titleScrollView.contentSize = CGSizeMake(btn.mj_x + btn.mj_w, 0);
    
    // 添加图片  (文字下的横线)
    UIButton *fistBtn = self.buttons.firstObject;
    self.imageBackView = [[UIView alloc] initWithFrame:CGRectMake(0, titleH-LineBottomMargin, fistBtn.mj_w *.5  , lineHeight)];
    self.imageBackView.backgroundColor = Default_BottomLineColor;
    [self.titleScrollView addSubview:self.imageBackView];
    self.imageBackView.layer.cornerRadius = lineHeight/2.f;
    self.imageBackView.layer.masksToBounds = YES;
    
    CGPoint centerFistBtn = fistBtn.center;
    CGPoint centerimageBack = self.imageBackView.center;
    centerimageBack.x = centerFistBtn.x;
    self.imageBackView.center = centerimageBack;
    
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    
   
    
}



/**
 *默认 选中 按钮
 */
-(void)selectedButtonClicked:(NSInteger) index{

   
    if (self.buttons.count<index) {
        
        return;
        
    }
    UIButton * button = (UIButton * )[self viewWithTag:index];
    // 设置为选中的标签
    [self selectTitleBtn:button];
    
    //    // 点击对应的的按钮的回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(ScorlControlDismissActionWithIndex:)]) {
        [self.delegate ScorlControlDismissActionWithIndex:index];
    }
    CGFloat x = index * ScreenW;
    
    //    // 设置子视图控制器ScrollView的偏移量
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    //    // 设置该内容页内容展示
    [self setUpOneChildControllder:index];

    
    
}



/**
 *  标签点击事件
 */
- (void)click:(UIButton *)sender {
    // 设置为选中的标签
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
//    // 点击对应的的按钮的回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(ScorlControlDismissActionWithIndex:)]) {
        [self.delegate ScorlControlDismissActionWithIndex:i];
    }
    CGFloat x = i * ScreenW;
  
//    // 设置子视图控制器ScrollView的偏移量
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
//    // 设置该内容页内容展示
    [self setUpOneChildControllder:i];
    CGPoint senderCenter = sender.center;
    [UIView animateWithDuration:0.1 animations:^{
        CGPoint imageBackViewcenter = self.imageBackView.center;
        imageBackViewcenter.x = senderCenter.x;
        self.imageBackView.mj_w = sender.mj_w * .5;
        self.imageBackView.center = imageBackViewcenter;
    }];

}

/**
 *  把点击的button设置为选中的button
 */
- (void)selectTitleBtn:(UIButton *)btn {
    [self.selectedBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
//    [self.selectedBtn setImage:[[UIImage imageNamed:@"session_whole_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]forState:(UIControlStateNormal)];
    // 设置选中的button的颜色
        [btn setTitleColor:SeletBtnColor forState:(UIControlStateNormal)];


    
    self.selectedBtn = btn;
    // 把选中的button移动到屏幕的中央
    [self setupTitleCenter:btn];
}

/**
 *  把选中的button移动到屏幕的中央
 */
- (void)setupTitleCenter:(UIButton *)sender {
    // 找到选中的button距离屏幕的中心有多远
    CGFloat offset = sender.center.x - ScreenW * 0.5;
    // 如果在屏幕中心的左边
    if (offset < 0) {
        // 不做偏移
        offset = 0;
    }
    // 标签ScrollView的偏移量打到最右时
    CGFloat maxOffset = self.titleScrollView.contentSize.width - ScreenW;
    // 如果这个偏移量大于最大
    if (offset > maxOffset && maxOffset >0) {
        // 设置为最大
        offset = maxOffset;
    }
    // 偏移
    if (self.titleScrolEnabled) {
        self.titleScrollView.contentOffset = CGPointMake(offset, 0);
    }
    
    
}

/**
 *  把子视图控制器上的内容展示出来
 */
- (void)setUpOneChildControllder:(NSInteger)index {
    UIViewController *superVC = [self findViweController:self];
    CGFloat x = index * ScreenW;
        UIViewController *vc = superVC.childViewControllers[index];
       if (vc.view.superview) {
        // 如果已经展示过, 直接返回
        return;
    }
    CGFloat w = CGRectGetWidth(self.contentScrollView.frame);
    CGFloat h = self.contentScrollView.frame.size.height;
    if (self.contentView) {// 如果内容存在的话就是内容的大小
        w = CGRectGetWidth(self.contentView.frame);
        h = CGRectGetHeight(self.contentView.frame);
    } else {// 不是的话就是
        
    }
    vc.view.frame = CGRectMake(x, 0, w, h);
    self.contentScrollView.backgroundColor = [UIColor colorWithRed:236/256.0f green:240/256.0f blue:241/256.0f alpha:1];
//     self.contentScrollView.backgroundColor = [UIColor colorWithRed:126/256.0f green:202/256.0f blue:255/256.0f alpha:1];
    
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark --- UIScrollViewDelegate
/**
 *  scrollView滑动结束时触发
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = self.contentScrollView.contentOffset.x / ScreenW;
    // 设置选中的button
    [self selectTitleBtn:self.buttons[i]];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ScorlControlDismissActionWithIndex:)]) {
        [self.delegate ScorlControlDismissActionWithIndex:i];
    }
    
    // 设置展示的页面
    [self setUpOneChildControllder:i];
    
    if (self.frameArray.count > i) {
        [UIView animateWithDuration:0.1 animations:^{
            UIButton *xsender = self.buttons[i];
            CGPoint imageBackViewcenter = self.imageBackView.center;
            imageBackViewcenter.x = xsender.center.x;
            self.imageBackView.mj_w =  xsender.mj_w * .5;
            self.imageBackView.center = imageBackViewcenter;
        }];
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            UIButton *xsender = self.buttons[i];
            CGPoint imageBackViewcenter = self.imageBackView.center;
            imageBackViewcenter.x = xsender.center.x;
            self.imageBackView.mj_w =  xsender.mj_w * .5;
            self.imageBackView.center = imageBackViewcenter;
        }];
    }
       

}
/**
 *  scrollView交互, 就会触发
 */



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 此时的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;// 偏移量
    NSInteger index = offsetX / kScreenWidth;// 下表
    CGFloat rare = offsetX / kScreenWidth;
   
    if (self.frameArray.count > index) {
        NSDictionary *dic = self.frameArray[index];
        CGFloat width = [dic[@"length"] floatValue];
        UIButton *btn = dic[@"btn"];
        [UIView animateWithDuration:0.1 animations:^{
            CGPoint center = self.imageBackView.center;
            center.x =   btn.center.x + width * (rare - index);
//            self.imageBackView.mj_w = btn.mj_w * (rare - index) + 8;
            self.imageBackView.center = center;
        }];
    }


    
    
    
    // 设置图片的偏移量
//    NSLog(@"%d",rare);

}


@end