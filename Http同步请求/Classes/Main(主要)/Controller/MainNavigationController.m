//
//  MainNavigationController.m
//  1512LimitFree
//
//  Created by qianfeng on 14/3/12.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条标题的文字属性
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{ NSForegroundColorAttributeName : [UIColor colorWithRed:84 / 255.0 green:207 / 255.0 blue:80 / 255.0 alpha:1],
        NSFontAttributeName : ZYFont(20.0f)
     
     }];
    
    // 导航元素项的颜色
    [self.navigationBar setTintColor:[UIColor colorWithRed:84 / 255.0 green:207 / 255.0 blue:80 / 255.0 alpha:1 ]];
}


@end
