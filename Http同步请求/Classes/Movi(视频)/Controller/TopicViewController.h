//
//  TopicViewController.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/6.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieModel;
@interface TopicViewController : UIViewController

@property (nonatomic, strong) UIScrollView * scroView;
/**
 *  网址
 */
@property (nonatomic, strong) NSString * url;
#pragma mark -- 加载数据
- (void)loadData:(NSString *)url  removeAll:(BOOL)isRemove;
@property (nonatomic, strong) MovieModel *model;
@end
