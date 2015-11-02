//
//  ZYReportViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/15.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYReportViewController.h"

@interface ZYReportViewController ()

@end

@implementation ZYReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)selctBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)sendBtnClick:(UIButton *)sender {
    sender.selected = 1;
    [MBProgressHUD showSuccess:@"发送成功"];
}

-(void)btnClick:(UIButton *)sender
{
    NSLog(@"取消 ");
}
@end
