//
//  ChangeXPassWordViewController.m
//  LvJie
//
//  Created by bilin on 2017/1/16.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "ChangeXPassWordViewController.h"

@interface ChangeXPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *xNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *surePassword;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceToTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *完成 按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *wanchengB;

@end

@implementation ChangeXPassWordViewController
- (void)addNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHiddenKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEding:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textfieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
    
}
-(void)textfieldChanged{
    if (IS_VALID_STRING(self.oldPassword.text)&&IS_VALID_STRING(self.xNewPassword.text)&&IS_VALID_STRING(self.surePassword.text)) {
        self.wanchengB.backgroundColor = ButtonBackGroudRGB;
//        254, 60 , 45 红色
//    (123, 171, 240) 正真栏
//  (166, 211, 254) 半蓝
    }else{
        
     self.wanchengB.backgroundColor =ButtotUnNormalRGB;
        
    }
    
    
}
- (void)willShowKeyBoard:(NSNotification *)notification
{
    if (self.view.window) {
        
        if (kScreenHeight == 480.0) {
            _imageView.transform = CGAffineTransformMakeScale(0.0, 0.0);
            return ;
        }
        
        if (iPhone4 | iPhone5) {
            _imageView.transform = CGAffineTransformMakeScale(0.0, 0.0);

        } else {
            _imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
        
    }
    
    
    
}

- (void)beginEding:(NSNotification *)notification
{
    if (self.view.window) {
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            if (kScreenHeight == 480.0) {
                _distanceToTop.constant = -80;
                return ;
            }
            
            if (iPhone4 | iPhone5) {
                _distanceToTop.constant = -60;
            } else {
                _distanceToTop.constant = 20;
            }
            ;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
}
- (void)willHiddenKeyBoard:(NSNotification *)notification
{
    if (self.view.window) {
        _imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            _distanceToTop.constant = 20;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotificationCenter];
    self.wanchengB.backgroundColor = ButtotUnNormalRGB;
  
    
    
}



// 完成的点击事件
- (IBAction)okAction:(UIButton *)sender {
    if (!IS_VALID_STRING(self.oldPassword.text)) {
        [AlertPool alertMessage:@"请输入原密码" xlViewController:self WithBlcok:nil];
        return;
    }
    if (!IS_VALID_STRING(self.xNewPassword.text)) {
        [AlertPool alertMessage:@"请输入新密码" xlViewController:self WithBlcok:nil];
        return;
    }
    if (!IS_VALID_STRING(self.surePassword.text)) {
        [AlertPool alertMessage:@"请输入确认密码" xlViewController:self WithBlcok:nil];
        return;
    }
    
    if (![self.xNewPassword.text isEqualToString:self.surePassword.text]) {
        [AlertPool alertMessage:@"原密码与新密码不一致" xlViewController:self WithBlcok:nil];
        return;
        
    }
    // 参数 token,oldpassword， newpassword， newpassword1
    [self netWorkHelperWithPOST:EditPassword parameters:@{@"token" :TOKEN, @"oldPassword" : self.oldPassword.text, @"newPassword":self.xNewPassword.text} success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        BaseModel *baseModel = [BaseModel loadModelWithDictionary:dic];
        baseModel.userModel = [UserModel loadModelWithDictionary:dic[@"Info"]];
        baseModel.userModel.Auth = dic[@"Auth"];
        switch ([baseModel.Result integerValue]) {/** 网络请求的返回的状态 200 ---成功， 500 -- 系统内部错误， 404 ---- 信息不存在， 300 ---- 信息不存在*/
            case 200://成功
            {
                // 1清除 用户信息
                [[UserManager sharedManager] cleanUserInfo];
                // 将手机号
                // 密码是是不是记住密码 如果记住密码 的话需要将新的密码写入，做一步安全操作就是如果不是记住密码的话将原先的密码清除掉
                isChanagePassword(self.surePassword.text);
                
                // 2重新登录
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
                
            default:
                break;
        }

    } failure:^(NSError *error) {
        
    }];
    
    
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
