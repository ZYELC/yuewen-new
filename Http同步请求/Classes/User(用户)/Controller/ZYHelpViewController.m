//
//  ZYHelpViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/12.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYHelpViewController.h"
#import "ImageChangeScrollView.h"

@interface ZYHelpViewController ()

@end

@implementation ZYHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *imageArr = @[@"help"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    UIImage *image = ZYImage(imageArr[0]);
    for (int i = 0; i < imageArr.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.width, 1200 * (KHIGHT / KWIDTH))];
        //添加图片
        [scrollView addSubview:imageView];
        imageView.image = ZYImage(imageArr[i]);
    }
    scrollView.contentSize = CGSizeMake(KWIDTH, 1800 * (KHIGHT / KWIDTH) );
    [self.view addSubview:scrollView];
}

#pragma mark --  当页面将要出现的时候调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- 页面消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
}
@end
