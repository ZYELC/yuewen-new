//
//  HotSoundController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/28.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "HotSoundController.h"

@interface HotSoundController ()

@end

@implementation HotSoundController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.url = SDDayHot;
    [self loadData:self.url removeAll:0];
    
}


@end
