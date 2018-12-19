//
//  SetPasswordViewController.m
//  LvJie
//
//  Created by bilin on 2017/10/10.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "YLWXLoginModel.h"
#import "sys/utsname.h"

@interface SetPasswordViewController ()
@property (nonatomic, strong) UIButton * loginBtn;
@property(nonatomic,strong) UITextField *ATextField;

@end

@implementation SetPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *backLabel = [[UILabel alloc] init];
    backLabel.textColor = RGBCOLOR(85, 135, 249);
    backLabel.text = @"返回";
    backLabel.userInteractionEnabled = NO;
    backLabel.font = [UIFont fontWithName:FontName size:15];
    
    UIButton * B_left = [UIButton buttonWithType:UIButtonTypeCustom];
    //    B_left.backgroundColor = [UIColor redColor];
    [B_left addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
   
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:FontName size:17];
    titleLabel.text = @"设置密码";
    
    
    UIImageView *A = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_mima_a"]];
    
    UITextField *ATextField = [[UITextField alloc] init];
    ATextField.font = [UIFont fontWithName:FontName size:14];
    ATextField.placeholder = @"请设置6-12登录密码";
    self.ATextField = ATextField;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBCOLOR(221, 221, 221);
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.backgroundColor = RGBCOLOR(62,168, 243);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(queDingAction:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.loginBtn = loginBtn;
    
    
    // 添加子视图
    [self.view addSubview:backBtn];
    [self.view addSubview:backLabel];
    [self.view addSubview:B_left];
    [self.view addSubview:titleLabel];
    [self.view addSubview:A];
    [self.view addSubview:ATextField];
    [self.view addSubview:lineView];
    [self.view addSubview:loginBtn];
    
    // 布局
    
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.top.mas_equalTo(self.view.mas_top).offset(35);
    }];
    
    [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backBtn.mas_right);
        make.centerY.mas_equalTo(backBtn.mas_centerY);
    }];
    
    [B_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backBtn);
        make.right.mas_equalTo(backLabel);
        make.centerY.mas_equalTo(backBtn);
        make.height.mas_equalTo(backLabel);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(134/ 2);
    }];
    
    [A mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_left);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(60);
        make.width.and.height.mas_equalTo(25);
    }];
    
    [ATextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(A.mas_right).offset(12);
        make.centerY.mas_equalTo(A.mas_centerY);
        make.height.mas_equalTo(A.mas_height);
        make.right.mas_equalTo(lineView.mas_right);
    }];
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(554/2);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(A.mas_bottom).offset(20);
        make.height.mas_equalTo(0.5);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(70);
        make.width.mas_equalTo(lineView.mas_width);
        make.height.mas_equalTo(45);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
 
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
}
// 确认
- (void)queDingAction:(UIButton *)sender
{
    if (!IS_VALID_STRING(self.ATextField.text)) {
        [GiFHUD show:@"请输入密码" view:self.view];
        return;
        
    }
    NSString * platform = [self datePlatform];
    if (!IS_VALID_STRING(platform)) {
        platform = @"";
    }
    NSString * url = [NSString string];
    if (IS_VALID_STRING(self.type)&&[self.type isEqualToString:@"1"]) {
        url =@"";
        
    }else{
        
        url =@"";
    }
    
    if (IS_VALID_STRING(self.openID)&&IS_VALID_STRING(self.phoneNumber)&&IS_VALID_STRING(self.code)) {
        
        
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        
        [ [YXHTTPRequst shareInstance]networking:url parameters: @{@"code" : self.code, @"phone" : self.phoneNumber, @"password" : self.ATextField.text , @"phoneType" : @(10),@"phoneModel":platform,@"province":@"",@"city":@"",@"area":@"",@"openId":self.openID} method:YXRequstMethodTypePOST success:^(NSDictionary *obj) {
            YLWXLoginModel * model = [YLWXLoginModel loadModelWithDictionary:obj];
            if ([model.Result isEqualToString:@"200"]) {
                

                    model.userModel = [UserModel loadModelWithDictionary:obj[@"Info"]];
                    model.userModel.Auth = obj[@"Auth"];
                    // 清除之前的用户信息
                    [[UserManager sharedManager] cleanUserInfo];
                    // 保存登录的信息
                    [[UserManager sharedManager] savaUserInfoWith:model.userModel];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    PushSingleton *pushSingleton = [PushSingleton pushSharedInstance];
                    [pushSingleton configurationRemoToPushWith:model];


                
            }else{
                
                
                [AlertPool alertMessage:model.message xlViewController:self WithBlcok:nil];
                
            }
            
        } failsure:^(NSError *error) {
            
        }];
    }else{
        
        [GiFHUD show:@"服务器返回异常~" view:self.view];
        
    }
    
    
    
    
    
}


// 返回
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
}
//获取手机类型
- (NSString *)datePlatform{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //（公司的应用不支持iPad）
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    //如果没有匹配直接返回系统提供的类似@"iPhone5,3"这种型号
    return deviceString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
