//
//  ImageChangeScrollView.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/6.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "ImageChangeScrollView.h"
/**
 *  标题高度
 */
#define TitleH 50
/**
 *  标题背景透明度
 */
#define TitleBack 0.5
/**
 标题字体大小
 */
#define TitleSize 20

@implementation ImageChangeScrollView

+ (instancetype)initWithImage:(NSArray *)imageArr andTitle:(NSArray *)titleArr andFrame:(CGRect )frame andTarget:(id)target andAction:(SEL)action{
    
    ImageChangeScrollView *scrollView = [[ImageChangeScrollView alloc] initWithFrame:frame];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(imageArr.count * frame.size.width, 0);
    for (int i = 0; i < imageArr.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollView.width, 0, scrollView.width, scrollView.height)];
        //添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:target action:action];
        imageView.tag = i;
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;

        //添加图片
        [scrollView addSubview:imageView];
        [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]]];
        if (titleArr) {
            if (titleArr[i]) {
                //添加标题背景颜色以及背景view
                UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake( 0, imageView.size.height - TitleH, scrollView.width, TitleH)];
                baseView.backgroundColor = [UIColor blackColor];
                baseView.alpha = TitleBack;
                [imageView addSubview:baseView];
                
                //添加标题
                UILabel *label = [[UILabel alloc]initWithFrame:baseView.frame];
                label.text = titleArr[i];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont boldSystemFontOfSize:TitleSize];
                [imageView addSubview:label];

            }
        }
    }    
    
    return scrollView;
}

@end
