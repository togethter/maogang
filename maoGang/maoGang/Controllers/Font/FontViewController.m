//
//  FontViewController.m
//  maoGang
//
//  Created by xl on 2018/11/13.
//  Copyright © 2018年 bilin. All rights reserved.
//

#import "FontViewController.h"
#import "PanViewController.h"
#import "BrushViewController.h"
#import "NotingViewController.h"
#import "YLScorlControl.h"
#import "FontDaquanViewController.h"
#import "TBTabBarController.h"
#import "MyZiTieViewController.h"
@interface FontViewController ()<ScorlControlDelegate>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textfied;
@end

@implementation FontViewController
- (void)ScorlControlDismissActionWithIndex:(NSInteger)index {
    if (index <= 1) {
        UIViewController *vc =  self.childViewControllers[index];
        [vc performSelector:@selector(fontNetwork) withObject:nil];
    }
}

- (void)viewDidLoad {
    self.noAddBackBtn = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"首页";
    YLScorlControl *control = [[YLScorlControl alloc] init];
    [self.view addSubview:control];
    control.delegate = self;
    PanViewController   *panVC    = [[PanViewController alloc] init];
    BrushViewController *brushVC  = [[BrushViewController alloc] init];
    NotingViewController*NOVC       = [[NotingViewController alloc] init];
    [control addChildViewController:panVC title:@"钢笔"];
    [control addChildViewController:brushVC title:@"毛笔"];
    [control addChildViewController:NOVC title:@"空白字帖"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xxbackAction:) name:@"backRootAction" object:nil];
    [control show];
}
- (void)xxbackAction:(NSNotification *)notification {
    [self.navigationController popToRootViewControllerAnimated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        TBTabBarController * tabVC = (TBTabBarController *) [UIApplication sharedApplication].delegate.window.rootViewController;
        tabVC.selectedIndex = 2;
        UINavigationController *navc =  tabVC.childViewControllers[tabVC.selectedIndex];
        MyZiTieViewController *ziteiVC = [[MyZiTieViewController alloc] init];
        [navc pushViewController:ziteiVC animated:NO];
    });
    
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)rightButton:(UIBarButtonItem *)right {
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
