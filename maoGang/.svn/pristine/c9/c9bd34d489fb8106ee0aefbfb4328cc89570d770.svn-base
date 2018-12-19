//
//  WorshipTheJudgeNetworkViewController.m
//  ChongFa
//
//  Created by zhangzhen on 16/8/23.
//  Copyright © 2016年 lixueliang. All rights reserved.
//

#import "WorshipTheJudgeNetworkViewController.h"

@interface WorshipTheJudgeNetworkViewController ()


@property (nonatomic, assign) NSUInteger loadCount;

@end

@implementation WorshipTheJudgeNetworkViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self)weakSelf = self;
    [self configureWkWebViewWithMinimunFontSize:12 target:self WithNameKey:nil configure:^(WKWebView *wkWebView) {
        [weakSelf.view addSubview:wkWebView];
        [weakSelf.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }];
    [self addloadingFromObserver];
    [XLWebHelper xlWebHeler:self.webType withRequestBlock:^(NSURLRequest *requset) {
    DLog(@"====");
    [self.wkWebView loadRequest:requset];
    } withVC:self];
    
 
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self clearWebViewCache];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    // http://dudu.chongfa.cn/dudu/page/registrationProtocol
//    [self.wkWebView loadRequest:[self requestWithUrlString:@"http://lvjie.chongfa.com/Agreement.html"]];
    
    
    
}


- (void)dealloc
{
    [self removeLodingFromObserver];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
        
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
    }
    self.navigationItem.title = self.wkWebView.title;
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
}


#pragma mark - WKNavigationDelegate  有用到的协议有 这个代理中主要是页面跳转的 ----n 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
/**! 这个是决定是否Request --- 在发送请求之前，决定是否跳转*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/**! 要获取response，通过WKNavigationResponse对象获取 ---- 在收到响应后，决定是否跳转*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**! 当main frame的导航开始请求时，会调用此方法 --- 页面开始加载时调用*/
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    self.loadCount ++;
}

/**!当main frame接收到服务重定向时，会回调此方法 --- 接收到服务器跳转请求之后调用*/
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

/**! 当main frame开始加载数据失败时，会回调*/
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

/**! 当main frame的web内容开始到达时，会回调 -----当内容开始返回时调用*/
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    self.loadCount --;
}

/**! 当main frame导航完成时，会回调 -- 页面加载完成之后调用*/
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

/**! 当main frame最后下载数据失败时，会回调 --- 加载失败时调用*/
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    self.loadCount --;
}

/**!这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的*/
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
//{
//
//}

#pragma mark - WKUIDelegate 协议有 这个代理主要是 UI层的 UI->JS之间的交互 ------ 提供用原生控件显示网页的方法回调。
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    
    if (!navigationAction.targetFrame.isMainFrame) {
        
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
    }
    
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    completionHandler();
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    
}
/**!
 * web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    completionHandler(YES);
}

/**!修改web内容*/
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    
}





@end
