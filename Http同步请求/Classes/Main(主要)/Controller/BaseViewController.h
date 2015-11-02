//
//  BaseViewController.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, strong)UINavigationController * navigationControll;

@property (nonatomic, strong) UIScrollView * topBtnScroView;
@property (nonatomic, strong) UIButton * topCateBtn;
/**
 *  顶部下划线数组
 */
@property (nonatomic, strong) NSMutableArray * topULineArray;
/**
 *  顶部按钮数组
 */
@property (nonatomic, strong) NSMutableArray * topViewBtnArray;
/**
 *  创建顶部导航栏  传入标题数组
 */
- (void)creatUITopView:(NSArray *)titleArray withTarget:(id)target withAction:(SEL)action;
/**
 *  处理顶部按钮颜色
 *
 *  @param page 滑动后的页面
 */
- (void)setTopBtnColor:(NSInteger)page;
@end
