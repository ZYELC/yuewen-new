//
//  WebDetailView.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "WebDetailView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"
#import "ZYCommentTableViewController.h"
#import "ZYReportViewController.h"
#import "MCFireworksButton.h"
#import "ZYNewsDBManager.h"


@interface WebDetailView ()<UIWebViewDelegate>
{
  
    MPMoviePlayerController *_moviePlayer;
}
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet MCFireworksButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *comentNumLabel;
@property (weak, nonatomic) IBOutlet UIView *reportView;
@end

@implementation WebDetailView


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //_webView.scrollView.pagingEnabled = YES;
    //_webView.paginationMode = UIWebPaginationModeLeftToRight;
    _webView.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:@"http://stcv5.vivame.cn/spider/article/2015/09/30/%@",_url];
   // NSLog(@"新闻网址：%@ ",urlStr);
    NSURL *urlRealStr = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlRealStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [_webView loadRequest:request];
    
    [self creatBackButton];//创建顶部按钮
    [self loadComentData];
    
    _comentNumLabel.layer.cornerRadius = 7;
    _comentNumLabel.clipsToBounds = YES;
}

#pragma mark 创建顶部navigation
- (void)creatBackButton{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 50 )];
    imageView.backgroundColor = [UIColor colorWithRed:50 / 255 green:60 / 255  blue:30 / 255  alpha:1 ];
    imageView.userInteractionEnabled = YES;
    imageView.alpha = 0.8;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50 );
//    [btn setImage:ZYOriginalImage(@"abc_ic_ab_back_mtrl_am_alpha") forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [imageView addSubview:btn];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, KWIDTH - 100, 50)];
    title.text = @"新闻详情";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:title];
    [self.view addSubview:imageView];
    
}
#pragma mark 获取评论数
- (void)loadComentData{
    NSString *comUrl = [NSString stringWithFormat:@"http://interfacev5.vivame.cn/x1-interface-v5/json/commentlist.json?platform=android&installversion=5.6.6.3&channelno=MZSDA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=13fab674-07a9-4476-8eb8-59edf54674cb&type=1&id=%@&commentType=1",_url];
    
    [ZYTool sendGetWithUrl:comUrl parameters:nil success:^(id data) {
        NSDictionary *comdata = ZYJsonParserWithData(data);
        _comentNumLabel.text = [NSString stringWithFormat:@"%@",comdata[@"data"][@"commentCount"]] ;
        if (![_comentNumLabel.text isEqualToString:@"0"]) {
            _commentBtn.selected = YES;
        }
    } fail:^(NSError *error) {
        NSLog(@"%@ ",error);
    }];
}

#pragma mark -- 当时图将要显示的时候 显示tabbar 和顶部状态栏
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark -- 当时图将要隐藏的时候 显示tabbar 和顶部状态栏
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark 点击了评论按钮
- (IBAction)commentBtnClick:(UIButton *)sender {
    ZYCommentTableViewController *comentVC = [[ZYCommentTableViewController alloc] init];
    comentVC.commenID = _url;
    [self.navigationController pushViewController:comentVC animated:YES];
    
}


#pragma mark 点击分享按钮
- (IBAction)shareBtnClick:(UIButton *)sender {
    sender.selected = YES;
    NSString *urlStr = [NSString stringWithFormat:@"http://stcv5.vivame.cn/spider/article/2015/09/30/%@",_url];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5610aa0167e58e7bc1003e02"
                                      shareText:[NSString stringWithFormat:@"分享了一个新闻 :%@",urlStr]
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                       delegate:nil];

}
#pragma mark -- 点击了收藏按钮
- (IBAction)collectBtnClick:(UIButton *)sender {
    if (sender.selected) {
        [MBProgressHUD showSuccess:@"已取消"];
        [self.collectBtn popInsideWithDuration:0.4];
        
        sender.selected = NO;
        // 取消收藏: 删除数据
//        [ZYNewsDBManager deleteDataWithType:_url];
        
        
    }else{
        [self.collectBtn popOutsideWithDuration:0.5];
        [self.collectBtn animate];
        [MBProgressHUD showSuccess:@"收藏成功"];
        sender.selected = YES;
        // 收藏: 插入数据
//        [ZYNewsDBManager addStatus:_model];
        
        
    }
}
#pragma mark -- 点击了设置按钮
- (IBAction)settinBtnClick:(UIButton *)sender {
    _reportView.hidden = !_reportView.hidden;
}
#pragma mark -- 返回按钮的操作
-(void)btnClick:(UIButton *)sender
{
    [_webView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 当webview开始加载内容时调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showMessage:nil toView:_webView.scrollView];
    
}
#pragma mark 点击了举报Btn
- (IBAction)reportBtn:(id)sender {
    _reportView.hidden = YES;
    ZYReportViewController *reportVC = [[ZYReportViewController alloc] init];
    [self.navigationController pushViewController:reportVC animated:YES];
}
#pragma mark 点击了取消Btn
- (IBAction)cancelBtn:(id)sender {
    _reportView.hidden = YES;
}
#pragma mark -- 当webview加载完内容时候隐藏
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_webView stopLoading];
    [MBProgressHUD hideHUDForView:_webView.scrollView animated:YES];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
    //webView  高度获取
//       CGRect frame = webView.frame;
//        NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@ "document.body.scrollHeight;" ];
//        frame.size.height = [fitHeight floatValue];
//        webView.frame = frame;
//
//    
//        //修改服务器页面的meta的值
//        NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
//        [webView stringByEvaluatingJavaScriptFromString:meta];
//    
//    //给网页增加utf-8编码
//    [webView stringByEvaluatingJavaScriptFromString:
//     @"var tagHead =document.documentElement.firstChild;"
//     "var tagMeta = document.createElement(\"meta\");"
//     "tagMeta.setAttribute(\"http-equiv\", \"Content-Type\");"
//     "tagMeta.setAttribute(\"content\", \"text/html; charset=utf-8\");"
//     "var tagHeadAdd = tagHead.appendChild(tagMeta);"];
//    
//    //拦截网页图片  并修改图片大小
//    [webView stringByEvaluatingJavaScriptFromString:
//     @"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function ResizeImages() { "
//     "var myimg,oldwidth;"
//     "var maxwidth=380;" //缩放系数
//     "for(i=0;i <document.images.length;i++){"
//     "myimg = document.images[i];"
//     "if(myimg.width > maxwidth){"
//     "oldwidth = myimg.width;"
//     "myimg.width = maxwidth;"
//     "myimg.height = myimg.height * (maxwidth/oldwidth);"
//     "}"
//     "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
   // [self.view addSubview:webView];
}
#pragma mark -- 按下了返回按钮
- (IBAction)backBtn:(UIButton *)sender {
    [self btnClick:sender];
}



@end
