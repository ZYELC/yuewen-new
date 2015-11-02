//
//  MusicHeardView.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/8.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicHeardView : UICollectionReusableView
@property (nonatomic, strong) NSArray * imageArr;
@property (nonatomic, strong) NSArray * titleArr;
//@property (nonatomic, assign) CGRect  frame;
/**
 *  创建图片轮播器
 *
 *  @param imageArr 图片数组
 *  @param titleArr 标题数组
 *  @param frame    大小
 *
 *  @return musiceHeadView
 */
- (void)initWithImage:(NSArray *)imageArr andTitle:(NSArray *)titleArr andFrame:(CGRect )frame andTarget:(id)target andAction:(SEL)action;
/**
 *  返回ID
 *
 *  @return 复用ID
 */
+ (NSString *)identifier;
@end
