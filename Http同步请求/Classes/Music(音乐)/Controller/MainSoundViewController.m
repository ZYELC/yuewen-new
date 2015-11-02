//
//  MainSoundViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/28.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MainSoundViewController.h"
#import "MagezineViewController.h"
#import "HotSoundController.h"
#import "ChanelViewController.h"

//顶部状态栏高度
#define KTopViewH 50
@interface MainSoundViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    MagezineViewController *_magezineVC;
    HotSoundController     *_hotSoundVC;
    ChanelViewController   *_channelVC;
}
@end

@implementation MainSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNacigationBar];
    [self creatUI];
    
}
#pragma mark -- 创建NavigationBar
- (void)creatNacigationBar{
     NSArray *titleArray = @[@"热门",@"频道",@"排行"];
    [self creatUITopView:titleArray withTarget:self withAction:@selector(navigationBarBtnClick:)];
    [self.topCateBtn setImage:nil forState:UIControlStateNormal];
//    self.topCateBtn.alpha = 1;
    self.topCateBtn.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    self.topCateBtn.userInteractionEnabled = NO;
    [self.topCateBtn setBackgroundColor:ZYColor(23, 23, 23)];
    self.topCateBtn.alpha = 1;
//    self.topCateBt.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark-- 创建主界面
- (void)creatUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, KTopViewH + 20, KWIDTH, KHIGHT - KTopViewH - 40)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    //设置是否有回弹效果
    _scrollView.bounces=NO;
    
    //热门页面
    _magezineVC = [[MagezineViewController alloc] init];
    _magezineVC.navigationControll = self.navigationController;
    _magezineVC.view.frame = CGRectMake(0, 0, KWIDTH, _scrollView.height);
    [_scrollView addSubview:_magezineVC.view];
    
    //排行页面
    _hotSoundVC = [[HotSoundController alloc] init];
    _hotSoundVC.navigationControll = self.navigationController;
    _hotSoundVC.view.frame = CGRectMake(2 * KWIDTH, 0, KWIDTH, _scrollView.height);
    [_scrollView addSubview:_hotSoundVC.view];
    
    //频道页面
    _channelVC = [[ChanelViewController alloc] init];
    _channelVC.navigationControll = self.navigationController;
    _channelVC.view.frame = CGRectMake( KWIDTH, 0, KWIDTH, _scrollView.height);
    [_scrollView addSubview:_channelVC.view];
    
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(3 * KWIDTH, _scrollView.height);
    
}
#pragma mark scrollView打理方法-结束滚动
//结束滚动，一定要有滚动的减速过程，才会执行此协议方法，如果设置pageEnable为yes，一定会调此方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ( scrollView == _scrollView) {
        CGFloat scroOffset = scrollView.contentOffset.x;
        NSInteger num = ((NSInteger)scroOffset / KWIDTH);
        [self setTopBtnColor:num];
    }
}
#pragma mark 导航栏按钮点击事件
- (void)navigationBarBtnClick:(UIButton *)send{
    
    
    _scrollView.contentOffset = CGPointMake(send.tag * KWIDTH, 0);
    [self setTopBtnColor:send.tag];

}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationControll.navigationBarHidden = NO;
}
@end
