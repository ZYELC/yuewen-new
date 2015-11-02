//
//  BaseSoundViewController.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/28.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSoundViewController : UIViewController
@property (nonatomic, strong) UIScrollView * scroView;
/**
 *  网址
 */
@property (nonatomic, strong) NSString * url;
/**
 *  自定义
 */
@property (nonatomic, strong) UINavigationController * navigationControll;
#pragma mark -- 加载数据
- (void)loadData:(NSString *)url  removeAll:(BOOL)isRemove;

@end
