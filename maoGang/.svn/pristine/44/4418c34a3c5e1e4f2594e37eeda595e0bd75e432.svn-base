//
//  YLRootViewController.h
//  LeForProject
//
//  Created by zhangzhen on 2018/6/20.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//


typedef enum :NSUInteger{
    xForOther,
    xForChuChuo,
    xForWuShuJu,
    XForWuWangluo
}xlQuanXianEnum;
/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);
/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

#import <UIKit/UIKit.h>
#import "WkWebViewProTocol.h"
#import "AlertCustomViewForNetwork.h"

@class WKWebView;
@interface YLRootViewController : UIViewController<WkWebViewProTocol,WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler,alertCustomViewForNetworkDelegate>


@property (nonatomic, assign) BOOL isCanHiddenXlContentView;
// 网络不好的弹框
@property (nonatomic, strong) AlertCustomViewForNetwork *netWorkCustomView;

/**
 *暂无数据  图标
 */
@property(nonatomic,strong)UIImageView * temporarilyNodataImageV;

/**
 *暂无数据  文字
 */
@property(nonatomic,strong)UILabel * temporarilyNodataTitleV;

// 展示无网络无数据程序错误等
@property (nonatomic, strong) UIView *xlContentView;
// 枚举值  出错 无网络
@property (nonatomic, assign) xlQuanXianEnum xlQuanXian;


//暂无数据
@property (nonatomic, strong) UILabel *Icon_label;
@property (nonatomic, strong) UIImageView *Icon_backImage;


//是否显示返回按钮
@property (nonatomic, assign) BOOL noAddBackBtn;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/**wkWebView 对象 在夫类里默认设置的frame（0，0，0，0） 子类需要重新设置*/
@property (nonatomic, strong) WKWebView *wkWebView;
/**configuration配置 对象 子类可以自定义设置*/
@property (nonatomic, strong) WKWebViewConfiguration *configuration;
/** 通过JS与webview内容交互*/
@property (nonatomic, strong) WKUserContentController *wkuserConentVC;
/**! 进度条*/
@property (nonatomic, strong) UIProgressView *progressView;

/** 注入JS对象 用户js 与webView内容之间的交互*/
- (void)addScriptMessageHandlerWith:(UIViewController*)viewController name:(NSString *)nameKey;
/** 空实现*/
- (void)configureWkWebView;
/** 配置wkWebView */
- (void)configureWkWebViewWithMinimunFontSize:(CGFloat)miniFont target:(nullable id)ViewController WithNameKey:(nullable NSString *)nameKey configure:(void(^)(WKWebView *wkWebView))wkWebBlock;
/** 清除webViewCache的缓存*/
- (void)clearWebViewCache;
// 添加前进和后退
- (void)webViewBackAndForward;
/**添加观察者为了有一个加载的进度 需要在添加的类中dealloc 中手动调用 RemoveObserver*/
- (void)addloadingFromObserver;
/** 移除观察者 --- loding 注意！！！不能随便调用和 addloadingFromObserver 成对出现*/
- (void)removeLodingFromObserver;
/** 布局子视图*/
- (void)xllayOutChildenViews;
/**! 这个比较重要 添加的桥梁的名字需要用这个去移除掉代理 要不然页面不释放*/
@property (nonatomic, strong) NSString *scriptMessageName;

/** 根据name 移除注入的scriptMessageHandler*/
- (void)removeScriptMessageHandkerForNameForKey:(nullable NSString *)name;
/** 移除script 方法*/
- (void)removewScriptAction;

/**
 *  POST请求,无缓存
 *
 *  @param url        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 */
- (void)netWorkHelperWithPOST:(NSString *)url parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure;


/* nagationBar 的黑线**/
- (void)setNavigationBarTypeHiddenBottomLine;
/**
 *添加 导航栏   右侧点击事件
 */
-(void)addRightItemTitle:(NSString * )rightTitle withtitleColor:(UIColor *)titleColor addAction:(SEL)action;
/**
 *添加 导航栏   左侧点击事件
 */
-(void)addLeftItemAction:(SEL)action;
/**
 *获取 当前网络状态
 */
- (NSString * )monitorNetworking;


@end
