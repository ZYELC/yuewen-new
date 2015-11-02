//
//  MainController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MainController.h"
#import "InforViewController.h"
#import "FindViewController.h"
#import "UserViewController.h"
#import "MainSoundViewController.h"
#import "MainNavigationController.h"
#import "IWTabBar.h"

@interface MainController ()<IWTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) IWTabBar *customTabBar;
@end

@implementation MainController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}



/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    IWTabBar *customTabBar = [[IWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    InforViewController *home = [[InforViewController alloc] init];
    [self setupChildViewController:home title:@"热文" imageName:@"rss_gray" selectedImageName:@"rss"];
    
    // 2.消息
    MainSoundViewController *message = [[MainSoundViewController alloc] init];
    [self setupChildViewController:message title:@"音乐" imageName:@"channel" selectedImageName:@"channel2"];
    
    // 3.广场
    FindViewController *discover = [[FindViewController alloc] init];
    [self setupChildViewController:discover title:@"视频" imageName:@"movie_nomal" selectedImageName:@"movie_press"];
    
    // 4.我
    UserViewController *me = [[UserViewController alloc] init];
    [self setupChildViewController:me title:@"用户" imageName:@"mine" selectedImageName:@"mine2"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
    
    // 2.包装一个导航控制器
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


@end
