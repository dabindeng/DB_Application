//
//  WKWebViewTestViewController.m
//  DB_Application
//
//  Created by epwk on 16/9/6.
//  Copyright © 2016年 DBAPP. All rights reserved.
//   wkwebview  与  js 交互

#import "WKWebViewTestViewController.h"
#import <WebKit/WebKit.h>

#define SCREEN_RECT [UIScreen mainScreen].bounds
//刨去状态栏的尺寸
#define SCREEN_REMOVE_APPLICATION  [UIScreen mainScreen].applicationFrame

@interface WKWebViewTestViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
{
    WKWebView *Web;
}
@end

@implementation WKWebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    //注册js方法
    [config.userContentController addScriptMessageHandler:self name:@"webViewApp"];
    Web = [[WKWebView alloc]initWithFrame:SCREEN_RECT configuration:config];
    //    NSURL *baidu = [NSURL URLWithString:@"http://www.youshaa.cn/app/boutique"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:baidu];
    //    [Web loadRequest:request];
    //加载本地页面
//    [Web loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"html" ofType:@"html"]]]];
    [Web loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.youqiwu.com/youhuistorm.html?epi=123&utm_source=baidu&utm_medium=banner&utm_campaign=&utm_content=&utm_term=%E4%B8%BB%E7%AB%99%E5%9B%BE%E5%8C%85%E5%B9%BF%E5%91%8A"]]];
    Web.navigationDelegate = self;
    Web.UIDelegate = self;
//    Web.estimatedProgress  加载进度获取
    [self.view addSubview:Web];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
// 当内容开始返回时调用
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
// 页面加载完成之后调用
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;

// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;


//直接调用js
//webView.evaluateJavaScript("hi()", completionHandler: nil)
//调用js带参数
//webView.evaluateJavaScript("hello('liuyanwei')", completionHandler: nil)
//调用js获取返回值
//webView.evaluateJavaScript("getName()") { (any,error) -> Void in
//    NSLog("%@", any as! String)
//}

//实现js调用iOS的handle委托
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //接受传过来的消息从而决定app调用的方法
    NSDictionary *dict = message.body;
    NSString *method = [dict objectForKey:@"method"];
    if ([method isEqualToString:@"hello"]) {
        [self hello:[dict objectForKey:@"param1"]];
    }else if ([method isEqualToString:@"Call JS"]){
        [self callJS];
    }else if ([method isEqualToString:@"Call JS Msg"]){
        [self callJSMsg:[dict objectForKey:@"param1"]];
    }
}


- (void)hello:(NSString *)param{
    [self showAlert:param Title:@"js Call iOS"];
}

- (void)callJS{
    [Web evaluateJavaScript:@"iOSCallJSON()" completionHandler:nil];
}

- (void)callJSMsg:(NSString *)msg{
    [Web evaluateJavaScript:[NSString stringWithFormat:@"iOSCallJS('%@')",msg] completionHandler:nil];
}
//WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation { // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    //[self resetControl];
    if (webView.title.length > 0) {
        self.title = webView.title;
    }
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    NSLog(@"didFailProvisionalNavigation");
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    NSLog(@"4.%@",navigationAction.request);
    //    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSString *url = navigationAction.request.URL.absoluteString;
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}


//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
//    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,internal);
//}


//WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 接口的作用是打开新窗口委托
    //[self createNewWebViewWithURL:webView.URL.absoluteString config:Web];
    
    return Web;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

//  js 里面的alert实现，如果不实现，网页的alert函数无效
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    completionHandler(@"Client Not handler");
    
}

- (void)showAlert:(NSString *)content Title:(NSString *)title{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:content
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
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
