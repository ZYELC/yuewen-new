//
//  CateView.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/25.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "CateView.h"

@implementation CateView

+ (void)initCateView:(UIView *)view withTarget:(id)target action:(SEL)action{
     NSArray *titleArray = @[@"首选",@"时事",@"娱乐",@"精读",@"美女",@"历史",@"生活",@"军事",@"数码",@"汽车",@"星座",@"热读",@"时尚"];
    
    UIView *cateView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, KWIDTH, KHIGHT)];
    
    UIView *baseView = [[UIView alloc] initWithFrame:cateView.frame];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.5;
    [cateView addSubview:baseView];
    
    cateView.tag = 100;
    for (int j = 0; j < 3; j ++) {
        for (int i = 0; i < 4; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor whiteColor];
            btn.alpha = 0.9;
            if (i == 0) {
                btn.frame = CGRectMake(i * (KWIDTH / 4.0) - 2 , j * 60, (KWIDTH / 4.0) + 2, 60);
            }else{
                btn.frame = CGRectMake(i * (KWIDTH / 4.0)   , j * 60, (KWIDTH / 4.0), 60);
            }
            
            btn.titleLabel.font = ZYFONT(16);
            btn.tag = (j * 4) + i;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:titleArray[(j * 4) + i] forState:UIControlStateNormal];
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:ZYImage(@"CategoryCellSel") forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
            [btn setBackgroundColor:[UIColor blackColor]];
            [cateView addSubview:btn];
        }
    }
    [view addSubview:cateView];

}

@end
