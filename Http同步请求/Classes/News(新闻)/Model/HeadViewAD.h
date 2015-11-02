//
//  HeadViewAD.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadViewAD : UIView
@property (nonatomic, strong) UIScrollView * scroView;
+ (void)initWithScroView:(UIScrollView *)scroView  andADModel:(NSArray *)modelArr WithTarget:(id)target WithAction:(SEL)action;
/**
 *  返回动画uiview
 */
+ (void)initWithScroView:(NSArray*)modelArr view:(UIView *)view WithTarget:(id)target WithAction:(SEL)action;
@end
//creat table myTable (name varchar(100),age integer)
//delete from mytable where name = '小红'
//insert into mytable values ('小明', 15)
///update mytable set age = 28 where name = '小明'