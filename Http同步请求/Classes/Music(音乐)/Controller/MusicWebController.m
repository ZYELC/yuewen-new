//
//  MusicWebController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/5.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MusicWebController.h"

@interface MusicWebController ()<UIWebViewDelegate>
{
    UIWebView  *_webView;
}
@end

@implementation MusicWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, KWIDTH, KHIGHT - 70)];
    _webView.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:@"http://app-echo.com/sound/info?sound_id=%@",_usrId];
    NSLog(@"音乐网址：%@ ",urlStr);
    NSURL *urlRealStr = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlRealStr];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
@end
