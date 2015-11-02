//
//  ZYMovieWebView.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/22.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYMovieWebView.h"

@interface ZYMovieWebView ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation ZYMovieWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, KWIDTH, KHIGHT - 100)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
   [_webView loadRequest:request];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

#pragma mark -- 视图出现的时候
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark -- 视图消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark -- 当webview开始加载内容时调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [MBProgressHUD showHUDAddedTo:webView animated:YES];
    [MBProgressHUD showMessage:nil toView:_webView.scrollView];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:webView.scrollView animated:YES];

}
@end
