//
//  MusicHeardView.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/8.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "MusicHeardView.h"
#import "ImageChangeScrollView.h"

@implementation MusicHeardView
- (void)initWithImage:(NSArray *)imageArr andTitle:(NSArray *)titleArr andFrame:(CGRect )frame andTarget:(id)target andAction:(SEL)action{
    self.frame = frame;
   // MusicHeardView *view = [[MusicHeardView alloc] initWithFrame:frame];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:[ImageChangeScrollView initWithImage:imageArr andTitle:titleArr andFrame:frame andTarget:target andAction:action]];
   
}
+ (NSString *)identifier{
    return @"myView";
}
@end
