//
//  WebViewController.m
//  UPayTestDemo
//
//  Created by epwk on 16/8/8.
//  Copyright © 2016年 Epwk. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "SVProgressHUD.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property WebViewJavascriptBridge* bridge;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self loadDocument:self.fileUrl inView:self.webView];
    
    [SVProgressHUD show];
    [self.webView sizeToFit];
    self.webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.fileUrl]];
    [self.webView loadRequest:request];
    
    
//     JSBride连接
    if (_bridge)
        return;
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    /*
     *  App被调用
     */
    
    [_bridge registerHandler:@"wap_result" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"Response from Applogin");
    }];
    
}


-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSURL *url = [NSURL URLWithString:documentName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView//开始加载的时候执行该方法
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    NSString *requestString = [[request URL] absoluteString];
    
    NSString *protocol = @"tocontroller=jfgl";
    NSString *protocol1 = @"convert.html";
    
    if ([[NSString stringWithFormat:@"%@",[request URL]] isEqual:@"http://app2.api.epweike.net/m.php?do=merchatpay&view=payback"]) {
        
    }
    if ([requestString rangeOfString:protocol1].location != NSNotFound)
    {
    }
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView//加载完成的时候执行该方法。
{
    //    [self.actity stopAnimating];
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    //    [self.actity stopAnimating];
    [SVProgressHUD dismiss];
}
- (void)loadWebViewAndLogin
{
    //转圈加载中
    [self loadDocument:self.fileUrl inView:self.webView];
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
