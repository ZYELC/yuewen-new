//
//  MainFtTableViewController.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/17.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainFtTableViewControllerDelegate<NSObject>
- (void)mainFtTableViewControllerCateBtnClick:(NSString *)stypeName;
@end

@interface MainFtTableViewController : UITableViewController
@property (nonatomic, strong) id<MainFtTableViewControllerDelegate> delegate;
@property (nonatomic, strong) UIScrollView * scroView;
@property (nonatomic, strong)UINavigationController * navigationControll;
#pragma mark -- 加载数据
- (void)loadData:(NSString *)url isRemoveAll:(BOOL)isRemoveAll;
@end
