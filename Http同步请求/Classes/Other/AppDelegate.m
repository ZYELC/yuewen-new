//
//  AppDelegate.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "InforViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "ZYVersionCheckTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _musicArr = [NSMutableArray arrayWithCapacity:0];
    MainController *root = [[MainController alloc]init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    [ZYVersionCheckTool chooseRootController];
    //友盟
     [UMSocialData setAppKey:@"5610aa0167e58e7bc1003e02"];
    
    // 微信
    [UMSocialWechatHandler setWXAppId:@"wx9bff3b1ec716170d" appSecret:@"b960ce14999bd1a330d5da60680df917" url:@"http://weibo.com/rxg9527"];
    // QQ
    [UMSocialQQHandler setQQWithAppId:@"1104691615" appKey:@"zgwgvmA2Pin65MBj" url:@"http://weibo.com/rxg9527"];

    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
@end
