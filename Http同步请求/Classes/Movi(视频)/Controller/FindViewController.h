//
//  FindViewController.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

@interface FindViewController : BaseViewController

@property (nonatomic, strong) UIScrollView * scroView;
/**
 *  网址
 */
@property (nonatomic, strong) NSString * url;
#pragma mark -- 加载数据
- (void)loadData:(NSString *)url  removeAll:(BOOL)isRemove;

@end
