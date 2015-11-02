//
//  ZYBaseTableViewContoller.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/14.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ZYBaseTableViewContoller : UITableViewController
@property (nonatomic, strong)UINavigationController * navigationControll;
/**
 *  上一期页面时间戳
 */
@property (nonatomic, strong) NSString * oldTimestamp;

@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) UIScrollView * scroView;

@property (nonatomic, strong) NSString * type;
#pragma mark -- 加载数据
- (void)loadData:(NSString *)url  isRemoveAll:(BOOL)isRemoveAll;
@end
