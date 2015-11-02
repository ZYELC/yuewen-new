//
//  ZYVersionCheckTool.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/13.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYVersionCheckTool.h"
#import "ZYNewfeatureViewController.h"
#import "MainController.h"

@implementation ZYVersionCheckTool
+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MainController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZYNewfeatureViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
