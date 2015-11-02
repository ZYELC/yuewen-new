//
//  HeadViewAD.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "HeadViewAD.h"
#import "HeadADModel.h"
#import "UIImageView+WebCache.h"
#import "MainFtTableViewController.h"
@interface HeadViewAD ()

@end
@implementation HeadViewAD


+ (void)initWithScroView:(UIScrollView *)scroView andADModel:(NSArray*)modelArr WithTarget:(id)target WithAction:(SEL)action
{
    
        scroView.frame = CGRectMake(0, 0, KWIDTH, 200);
        scroView.pagingEnabled = YES;
        for (UIView *view in scroView.subviews) {
            [view removeFromSuperview];
        }
        for (int i = 0; i<modelArr.count ; i++)
        {
           
            HeadADModel *ADModel = modelArr[i];
            
            CGRect imageFrame = CGRectMake( i * KWIDTH, 0, KWIDTH, 200);
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageFrame];
            //添加点按手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [tap addTarget:target action:action];
            imageView.tag = i;
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            
            [imageView setImageWithURL:[NSURL URLWithString:ADModel.img]];
            [scroView addSubview:imageView];
            if (ADModel.title.length == 0) {
                continue;
            }
            //添加标题背景颜色以及背景view
            UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake( 0, imageFrame.size.height - 50, KWIDTH, 50)];
            baseView.backgroundColor = [UIColor blackColor];
            baseView.alpha = 0.5;
            [imageView addSubview:baseView];
            
            //添加标题
            UILabel *label = [[UILabel alloc]initWithFrame:baseView.frame];
            label.text = ADModel.title;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:20];
            [imageView addSubview:label];
            
        }
    
    if (modelArr.count > 1) {
        CGRect imageFrame = CGRectMake( (modelArr.count )*KWIDTH, 0, KWIDTH, 200);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageFrame];
        //添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:target action:action];
        //imageView.tag = 0;
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        HeadADModel *ADModel = modelArr[0];
        [imageView setImageWithURL:[NSURL URLWithString:ADModel.img]];
        [scroView addSubview:imageView];
        
        //如果没有标题则不添加
        if (ADModel.title.length != 0) {
            
            //添加标题背景颜色以及背景view
            UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake( 0, imageFrame.size.height - 50, KWIDTH, 50)];
            baseView.backgroundColor = [UIColor blackColor];
            baseView.alpha = 0.5;
            [imageView addSubview:baseView];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( 0, imageFrame.size.height - 50, KWIDTH, 50)];
            label.text = ADModel.title;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:20];
            [imageView addSubview:label];
        }
        scroView.contentSize = CGSizeMake((modelArr.count + 1) * KWIDTH, 200);
    }
    
    
       scroView.contentSize = CGSizeMake(modelArr.count  * KWIDTH, 200);
//
    
    
    
//    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(30, 540, 315, 30)];
//    //设置页数
//    _pageControl.numberOfPages=3;
//    //设置当前页码
//    _pageControl.currentPage=0;
//    //设置页码指示器的颜色
//    _pageControl.pageIndicatorTintColor=[UIColor greenColor];
//    //设置当前页码的颜色
//    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
//    [self.view addSubview:_pageControl];
//    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

   
}
+ (void)initWithScroView:(NSArray*)modelArr view:(UIView *)view WithTarget:(id)target WithAction:(SEL)action{
    
    view.frame = CGRectMake(0, 0, KWIDTH, 200);
    for (int i = 0; i < modelArr.count; i ++) {
        HeadADModel *ADModel = modelArr[i];
        CGRect imageFrame = CGRectMake( i * KWIDTH, 0, KWIDTH, 200);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageFrame];
        [imageView setImageWithURL:[NSURL URLWithString:ADModel.img]];
        [view addSubview:imageView];
        if (ADModel.title.length == 0) {
            continue;
        }
        //添加标题背景颜色以及背景view
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake( 0, imageFrame.size.height - 50, KWIDTH, 50)];
        baseView.backgroundColor = [UIColor blackColor];
        baseView.alpha = 0.5;
        [imageView addSubview:baseView];
        
        //添加标题
        UILabel *label = [[UILabel alloc]initWithFrame:baseView.frame];
        label.text = ADModel.title;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        [imageView addSubview:label];

    }
    HeadADModel *ADModel = modelArr[0];
    CGRect imageFrame = CGRectMake( modelArr.count * KWIDTH, 0, KWIDTH, 200);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageFrame];
    [imageView setImageWithURL:[NSURL URLWithString:ADModel.img]];
    [view addSubview:imageView];
    if (ADModel.title.length == 0) {
        return;
    }
    //添加标题背景颜色以及背景view
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake( 0, imageFrame.size.height - 50, KWIDTH, 50)];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.5;
    [imageView addSubview:baseView];
    
    //添加标题
    UILabel *label = [[UILabel alloc]initWithFrame:baseView.frame];
    label.text = ADModel.title;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [imageView addSubview:label];


}
- (void)initscroview:(UIScrollView *)scroview
{
    _scroView = scroview;
}

@end
