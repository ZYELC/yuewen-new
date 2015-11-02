//
//  CurrentTableViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/20.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "CurrentTableViewController.h"

@interface CurrentTableViewController ()

@end

@implementation CurrentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.url = NEWCurrent;
    
}

@end
