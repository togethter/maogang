//
//  WkWebViewProTocol.h
//  LvJie
//
//  Created by bilin on 2017/1/11.
//  Copyright © 2017年 Bilin-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WkWebViewProTocol <NSObject>


#pragma mark - WKScriptMessageHandler 只有一个协议很重要jS OC 之间的交互就靠它 主要用于JS<--->OC 交互 ------提供从网页中收消息的回调方法
/**从web界面中接收到一个脚本时调用 --- 冲协议中我们可以看出这里使用了两个类WKUSerContentController 和WKScriptMessage  WKUSerContentController可以理解为调度器  WKScriptMessage -- 可以理解为携带的数据*/
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;


#pragma mark - WKNavigationDelegate  有用到的协议有 这个代理中主要是页面跳转的 ----n 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
/**! 这个是决定是否Request --- 在发送请求之前，决定是否跳转*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

/**! 要获取response，通过WKNavigationResponse对象获取 ---- 在收到响应后，决定是否跳转*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

/**! 当main frame的导航开始请求时，会调用此方法 --- 页面开始加载时调用*/
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

/**!当main frame接收到服务重定向时，会回调此方法 --- 接收到服务器跳转请求之后调用*/
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;

/**! 当main frame开始加载数据失败时，会回调*/
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

/**! 当main frame的web内容开始到达时，会回调 -----当内容开始返回时调用*/
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

/**! 当main frame导航完成时，会回调 -- 页面加载完成之后调用*/
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;

/**! 当main frame最后下载数据失败时，会回调 --- 加载失败时调用*/
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;

/**!这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的*/
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;

#pragma mark - WKUIDelegate 协议有 这个代理主要是 UI层的 UI->JS之间的交互 ------ 提供用原生控件显示网页的方法回调。
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
/**!
 * web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;

/**!修改web内容*/
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler;
@end
