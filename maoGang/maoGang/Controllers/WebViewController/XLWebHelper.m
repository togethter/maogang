//
//  XLWebHelper.m
//  chongfa
//
//  Created by bilin on 2017/3/28.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import "XLWebHelper.h"
@implementation XLWebHelper
+ (void)xlWebHeler:(EWebType)webType
  withRequestBlock:(requestBlock)requestBlock
            withVC:(UIViewController *)VC
{
    NSURLRequest *request;
    switch (webType) {
//
       case EWebTypeAbout:
        {
//            VC.navigationItem.title = @"崇法提现协议";
//            request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",AgreementPrivate]]];
        }
            break;
        case 1:
        {
//            request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",PublicAgreement]]];
        }
            break;
            
        case 11:
        {
//                   request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?token=%@",UserOrder,TOKEN]]];
        }
            break;
            
        case 111:
        {
//            request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",AgreementPay]]];
        }
            break;
        default:
            break;
    }
    
    
    if (requestBlock) {
        requestBlock(request);
    }
    
}


@end