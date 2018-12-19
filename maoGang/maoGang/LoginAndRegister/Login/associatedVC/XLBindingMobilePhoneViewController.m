//
//  BindingMobilePhoneViewController.m
//  LvJie
//
//  Created by bilin on 2017/10/9.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "XLBindingMobilePhoneViewController.h"
#import "YLWXLoginModel.h"
#import "SetPasswordViewController.h"
#import "RegCodeModel.h"
#import "AlertForRegister.h"
#import "sys/utsname.h"
#import "TBTabBarController.h"

@interface XLBindingMobilePhoneViewController ()
@property (nonatomic, strong) UITextField *ATextField;
@property (nonatomic, strong) UITextField *BTextField;
@property (nonatomic, strong) UIButton * verificationBtn;
@property (nonatomic, strong) UIButton * netBtn;


@property (nonatomic, strong) RegCodeModel *codeModel;

//记录 是否弹框 1弹  2不弹
@property (nonatomic, copy) NSString * ShowAlertWX;

/** 取消*/
@property (nonatomic, assign) BOOL isCancel;

@end

@implementation XLBindingMobilePhoneViewController
- (void)dealloc
{
    PushSingleton *pushTon = [PushSingleton pushSharedInstance];
    [pushTon clearNavcAndVC];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (IS_VALID_STRING(self.ShowAlertWX)&&[self.ShowAlertWX isEqualToString:@"1"]) {
        
        [self showAlert];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 最下面的View
    UIView *view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    view.backgroundColor = [UIColor whiteColor];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(nackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    UILabel *backLabel = [UILabel new];
    backLabel.userInteractionEnabled = NO;
    backLabel.text = @"返回";
    backLabel.font = [UIFont systemFontOfSize:15];
    backLabel.textColor = RGBCOLOR(85, 135, 249);
    [self.view addSubview:backLabel];
    
    UIButton * B_left = [UIButton buttonWithType:UIButtonTypeCustom];
//    B_left.backgroundColor = [UIColor redColor];
    [B_left addTarget:self action:@selector(nackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:B_left];
    
    
    
    UILabel *titlLable = [[UILabel alloc] init];
    titlLable.font = [UIFont systemFontOfSize:17];
    titlLable.text = @"绑定手机号";
    UIImageView *A = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_shoujihao_n"]];
    UIImageView *B = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_yanzhengma_n"]];

    
    UITextField *ATextField = [[UITextField alloc] init];
    ATextField.placeholder = @"请输入手机号";
    ATextField.keyboardType = UIKeyboardTypeNumberPad;
    ATextField.font = [UIFont systemFontOfSize:14];
    self.ATextField = ATextField;

    
    UITextField *BTextField = [[UITextField alloc] init];
    self.BTextField = BTextField;
    BTextField.placeholder = @"请输入验证码";
    BTextField.font = [UIFont systemFontOfSize:14];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBCOLOR(221, 221, 221);
    
    
    UIView *fengeLineView = [UIView new];
    fengeLineView.backgroundColor = RGBCOLOR(221, 221, 221);
    
    UIButton *huoquYanZhengMaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [huoquYanZhengMaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [huoquYanZhengMaBtn setTitleColor:RGBCOLOR(0, 128, 252) forState:UIControlStateNormal];
    huoquYanZhengMaBtn.font = [UIFont systemFontOfSize:12];
    [huoquYanZhengMaBtn addTarget:self action:@selector(huoquYanzhengMa:) forControlEvents:UIControlEventTouchUpInside];
    self.verificationBtn = huoquYanZhengMaBtn;
    
    UIButton *netBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.netBtn = netBtn;
    [netBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [netBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    netBtn.backgroundColor = RGBCOLOR(62,168, 243);
    [netBtn addTarget:self action:@selector(netBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *desl = [[UILabel alloc] init];
    desl.textColor = RGBCOLOR(184, 183, 183);
    desl.font = [UIFont fontWithName:FontName size:14];
    desl.text = @"请妥善保管您的验证码, 不要轻易告诉他人!";
    
    
    // 添加子视图
    [self.view addSubview:view];
    
    [view addSubview:titlLable];// 绑定手机号
    [view addSubview:A];
    [view addSubview:B];
    [view addSubview:ATextField];
    [view addSubview:BTextField];
    [view addSubview:lineView];
    [view addSubview:fengeLineView];
    [view addSubview:huoquYanZhengMaBtn];
    [view addSubview:netBtn];
    [view addSubview:desl];
    
    
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
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(554 / 2);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    [titlLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(36/2);
    }];
    
    
    
    [A mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left);
        make.width.and.height.mas_equalTo(25);
        make.top.mas_equalTo(titlLable.mas_bottom).offset(134/2);
    }];
    
    [ATextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(A.mas_right).offset(12);
        make.centerY.mas_equalTo(A.mas_centerY);
        make.right.mas_equalTo(view.mas_right);
        make.height.mas_equalTo(A.mas_height);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(A.mas_bottom).offset(20);
        make.left.mas_equalTo(A.mas_left);
        make.right.mas_equalTo(view.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [B mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(A.mas_left);
        make.width.and.height.mas_equalTo(25);
        make.top.mas_equalTo(lineView.mas_bottom).offset(20);
    }];
    [BTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(A.mas_right).offset(12);
        make.centerY.mas_equalTo(B.mas_centerY);
        make.right.mas_equalTo(fengeLineView.mas_left).offset(-15);
        make.height.mas_equalTo(B.mas_height);
    }];
    
    
    [fengeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(B.mas_height);
        make.right.mas_equalTo(huoquYanZhengMaBtn.mas_left).offset(-15);
        make.centerY.mas_equalTo(B.mas_centerY);
        
        
    }];
    
    
    [huoquYanZhengMaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.right.mas_equalTo(view.mas_right);
        make.centerY.mas_equalTo(B.mas_centerY);
        make.height.mas_equalTo(B.mas_height);

    }];
    
    [netBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left);
        make.right.mas_equalTo(view.mas_right);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(B.mas_bottom).offset(96/2);
    }];
    
    netBtn.layer.cornerRadius = 8;
    netBtn.layer.masksToBounds = YES;
    
    [desl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(netBtn.mas_bottom).offset(52/2);
        make.centerX.mas_equalTo(netBtn.mas_centerX);
    }];
    

}

#pragma mark --- 下一步
- (void)netBtnAction:(UIButton *)sender
{
    
    if (!IS_VALID_STRING(self.BTextField.text)) {
        [GiFHUD show:@"请输入验证码" view:self.view];
        return;
    }
    if (!IS_VALID_STRING(self.OpenId)) {
        [GiFHUD show:@"服务器返回异常~" view:self.view];
    }
    if (IS_VALID_STRING(self.ATextField.text)&&[self.ATextField.text isTelephone]) {
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        
        NSString * url = [NSString string];
        if([self.type isEqualToString:@"1"]) {// QQ
            url =   MemberBindQQ;
            
        }else {//WX
            
             url =  MemberBindWeChat;
            
        }
        
        [ [YXHTTPRequst shareInstance]networking:url parameters:@{@"phone":self.ATextField.text,@"code":self.BTextField.text,@"openId":self.OpenId} method:YXRequstMethodTypePOST success:^(NSDictionary *obj) {
            YLWXLoginModel * model = [YLWXLoginModel loadModelWithDictionary:obj];
            if ([model.Result isEqualToString:@"200"]) {
                
                if (IS_VALID_STRING(model.OpenId)) {//授权
//
//                    DLog(@"调制下一步");
//                    SetPasswordViewController * passV = [[SetPasswordViewController alloc]init];
//                    passV.openID = model.OpenId;
//                    passV.phoneNumber = self.ATextField.text;
//                    passV.code = self.BTextField.text;
//                    passV.type = self.type;
//                    [self.navigationController pushViewController:passV animated:YES];
//
                    
                    
                }else{//登录
                  
                    model.userModel = [UserModel loadModelWithDictionary:obj[@"Info"]];
                    model.userModel.Auth = obj[@"Auth"];
                    // 清除之前的用户信息
                    [[UserManager sharedManager] cleanUserInfo];
                    // 保存登录的信息
                    [[UserManager sharedManager] savaUserInfoWith:model.userModel];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    PushSingleton *pushSingleton = [PushSingleton pushSharedInstance];
                    [pushSingleton configurationRemoToPushWith:model];
                    
                    
                }
            
                
                
            }else{
                
                
                [AlertPool alertMessage:model.message xlViewController:self WithBlcok:nil];
             
            }
            
        } failsure:^(NSError *error) {
            
        }];
        
        
    }else{
        
        
        [GiFHUD show:@"请输入正确手机号" view:self.view];
        
    }
    
    
    
    
}


#pragma mark --- 获取验证码
- (void)huoquYanzhengMa:(UIButton*)sender
{
    if (!IS_VALID_STRING(self.ATextField.text)) {
        [GiFHUD show:@"请输入手机号码" view:self.view];
        return;
    }
    if (![self.ATextField.text isTelephone]) {
        [GiFHUD show:@"请输入正确的手机号码" view:self.view];
        return;
    }
   
    sender.userInteractionEnabled = NO;
    NSString *time = [LCMD5Tool returnsTheTimestamp];
    NSString *code = [LCMD5Tool returnsTheMD5EncryptionTimestamp:time];
    if (!IS_VALID_STRING(time)) {
        time = @"";
    }
    if (!IS_VALID_STRING(code)) {
        code = @"";
    }
    [ [YXHTTPRequst shareInstance]networking:MemberBindPhoneSendCode parameters:@{@"phone":self.ATextField.text,@"time":time,@"code":code} method:YXRequstMethodTypePOST success:^(NSDictionary *obj) {
        YLWXLoginModel * model = [YLWXLoginModel loadModelWithDictionary:obj];
         RegCodeModel *modelSkipTime = [RegCodeModel loadModelWithDictionary:obj];
         NSString *SkipTime = modelSkipTime.SkipTime;
        if ([model.Result isEqualToString:@"200"]) {
          
            if (IS_VALID_STRING(SkipTime)) {
                [self startTimeWithAlertTime:[SkipTime intValue]];
            } else {
                // 这里定时器显示倒计时
                [self startTimeWithAlertTime:VerificationCodeTime];
            }
        }else{
            [AlertPool alertMessage:model.message xlViewController:self WithBlcok:nil];
              sender.userInteractionEnabled = YES;
        }
    } failsure:^(NSError *error) {
          sender.userInteractionEnabled = YES;
    }];
    
    
    
    
}
- (void)showAlert
{
    __weak typeof(self)weakSelf = self;
    if (self.view.window) {// 当该试图控制器在window里的下
        AlertForRegister *alert = [[AlertForRegister alloc] initWithalertWithWithModel:nil withAlertBlock:^(clickEnum toWhathEnum) {
            weakSelf.ShowAlertWX = @"2";
            weakSelf.isCancel = YES;
            switch (toWhathEnum) {
                case wxLogin:// 微信登录
                    [weakSelf loginWX];
                    break;
                default:
                    break;
            }
            
        } ClickItem:nil withViewSubViewView:nil] ;
        
        [alert show];
    }
}

-(void)loginWX
{
    
    if (!IS_VALID_STRING(self.ATextField.text)) {
        [GiFHUD show:@"请输入正确的手机号~" view:self.view];
        return;
    }
   
    if (IS_VALID_STRING(self.OpenId)) {
        
        [self loginLvJieWithUid:self.OpenId];
    }
    
    
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
-(void)loginLvJieWithUid:(NSString * )uid
{
    NSString * platform = [self datePlatform];
    if (!IS_VALID_STRING(platform)) {
        platform = @"";
    }
    if (!IS_VALID_STRING(uid)) {
        [AlertPool alertMessage:@"uid为空" xlViewController:self WithBlcok:nil];
        return;
    }
#pragma mark ---  用户手机号为空提示
    if (!IS_VALID_STRING(self.ATextField.text)) {
        [AlertPool alertMessage:@"手机号为空" xlViewController:self WithBlcok:nil];
        return;
    }
    
    NSString *time = [LCMD5Tool returnsTheTimestamp];// time
    NSString *code = [LCMD5Tool returnsTheMD5EncryptionTimestamp:time]; //code
    // 注册的网络请求
    // 关闭交互 开启动画
//    [self actioncloseUserInteractionEnabledAction];
    NSString *url = @"";
    if ([self.type isEqualToString:@"1"]) {//QQ
        url = QQRegSkip;
    } else {// WX
        url = WeChatRegSkip;
    }
    [self netWorkHelperWithPOST:url parameters:@{@"sign" : code,@"time":time,@"phone" : self.ATextField.text,@"openId":uid , @"phoneType" : @"1",@"phoneModel":platform,@"province":@"",@"city":@"",@"area":@""} success:^(id responseObject) {
        // 开启交互 关闭动画
//        [self actionOpenUserInteractionEnabledAction];
        NSDictionary *dic = responseObject;
        BaseModel *baseModel = [BaseModel loadModelWithDictionary:dic];
        
        switch ([baseModel.Result integerValue]) {/** 网络请求的返回的状态 200 ---成功， 500 -- 系统内部错误， 404 ---- 信息不存在， 300 ---- 信息不存在*/
            case 200://成功
            {
                self.isCancel = NO;// 点击获取验证码的时候
                LRWeakSelf(self);
                baseModel.userModel = [UserModel loadModelWithDictionary:dic[@"Info"]];
                baseModel.userModel.Auth = dic[@"Auth"];
                [AlertPool alertMessage:@"注册成功" xlViewController:self WithBlcok:^{ // 点击确定话直接进入APP
                    // 将手机号写入 将密码清空
                    writePhoneOrPassword(self.ATextField.text, @"");
                    // 清除用户保存的数据
                    [[UserManager sharedManager] cleanUserInfo];
                    // 保存新的用户数据
                    [[UserManager sharedManager] savaUserInfoWith:baseModel.userModel];
                    // 直接进入 APP 或者 登录页
                    weakself.view.window.rootViewController = [[TBTabBarController alloc] init];
                }];
                
                
            }
                break;
                
            default:
                break;
        }
        
    } failure:^(NSError *error) {
        // 开启交互关闭动画
//        [self actionOpenUserInteractionEnabledAction];
    }];
}

- (void)startTimeWithAlertTime:(int)alertTime {
    __block int timeout=VerificationCodeTime; //倒计时时间
    __weak typeof(self)wsSelf = self;
    __block NSString * isShow = @"1";//是否显示  1显示  2不显示
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [wsSelf.verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [wsSelf.verificationBtn setTitleColor:RGBCOLOR(0, 128, 252) forState:UIControlStateNormal];
                wsSelf.verificationBtn.userInteractionEnabled = YES;
                wsSelf.ShowAlertWX = @"1";
                if (self.isCancel) {//点击了叉号
                    isShow = @"1";
                }
                if ([isShow isEqualToString:@"1"]) {
                    [wsSelf showAlert];
                }
            });
        }else{
            int seconds = timeout ;
            int alertTimeShow = VerificationCodeTime-alertTime;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [wsSelf.verificationBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送", strTime] forState:UIControlStateNormal];
                [wsSelf.verificationBtn setTitleColor:[UIColor colorWithWhite:0.702 alpha:1.000] forState:UIControlStateNormal];
                wsSelf.verificationBtn.userInteractionEnabled = NO;
                
                if (seconds==alertTimeShow) {
                    wsSelf.ShowAlertWX = @"1";
                    isShow = @"2";
                    [wsSelf showAlert];
                }else{
                    if (![wsSelf.ShowAlertWX isEqualToString:@"1"]) {
                        
                        wsSelf.ShowAlertWX = @"2";
                    }
                }
            });
           
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

- (void)nackBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    PushSingleton *pushTon = [PushSingleton pushSharedInstance];
    [pushTon clearNavcAndVC];
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
