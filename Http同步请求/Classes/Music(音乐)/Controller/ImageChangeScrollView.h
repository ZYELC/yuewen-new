//
//  ImageChangeScrollView.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/6.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageChangeScrollView : UIScrollView
/**
 *  创建图片轮播器
 *
 *  @param imageArr 图片数组
 *  @param titleArr 标题数组
 *  @param frame    大小
 *
 *  @return scorrolView
 */
+ (instancetype)initWithImage:(NSArray *)imageArr andTitle:(NSArray *)titleArr andFrame:(CGRect )frame andTarget:(id)target andAction:(SEL)action;

@end
