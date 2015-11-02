//
//  BaseViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "BaseViewController.h"
//顶部状态栏高度
#define KTopViewH 50
/**
 *  顶部按钮宽度
 */
#define KTopViewBtnW 65
@interface BaseViewController ()
{
/**
 *  顶部下划线数组
 */
NSMutableArray *_topULineArray;
/**
 *  顶部按钮数组
 */
NSMutableArray *_topViewBtnArray;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}
- (void)creatUITopView:(NSArray *)titleArray withTarget:(id)target withAction:(SEL)action
{
    _topBtnScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, KWIDTH - 50, KTopViewH)];
    _topViewBtnArray = [[NSMutableArray alloc]init];
    _topULineArray = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i <titleArray.count; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn.frame = CGRectMake( i * KTopViewBtnW, 0, KTopViewBtnW, KTopViewH - 2);
//                btn.backgroundColor = [UIColor blackColor];
                btn.titleLabel.font = ZYFont(18);
                [btn setTitle:titleArray[i] forState:UIControlStateNormal];
                [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
                [btn setBackgroundImage:ZYImage(@"CategoryCellNor") forState:UIControlStateNormal];
                 btn.tag = i;
                [self.topBtnScroView addSubview:btn];
                [_topViewBtnArray addObject:btn];
        
                UIImageView *redView = [[UIImageView alloc]initWithFrame:CGRectMake( i * KTopViewBtnW, KTopViewH - 2, KTopViewBtnW, 2)];
                redView.backgroundColor = [UIColor blackColor];
                [_topULineArray addObject:redView];
                [self.topBtnScroView addSubview:redView];
    }
    if (titleArray.count > 0) {
        UIButton *topButn = _topViewBtnArray[0];
        [topButn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _topBtnScroView.contentSize = CGSizeMake( KTopViewBtnW * titleArray.count, KTopViewH);
        [_topBtnScroView setBackgroundColor:ZYColor(23, 23, 23)];
        _topBtnScroView.alpha = 1;
        
        UIImageView *topImg = _topULineArray[0];
        topImg.backgroundColor = [UIColor redColor];
    }
    
    
    _topCateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topCateBtn.backgroundColor = [UIColor blackColor];
    _topCateBtn.alpha = 0.96;
    _topCateBtn.frame = CGRectMake(KWIDTH - 50, 20, 50, self.topBtnScroView.height);
    [_topCateBtn setImage:ZYOriginalImage(@"CategoryNavButton.png")  forState:UIControlStateNormal];
    [self.view addSubview:_topCateBtn];

    [self.view addSubview:_topBtnScroView];
}

/**
 *  处理顶部按钮颜色
 *
 *  @param page 滑动后的页面
 */
- (void)setTopBtnColor:(NSInteger)page
{
    for (int i = 0; i < self.topViewBtnArray.count; i++) {
        UIButton *topButn = self.topViewBtnArray[i];
        [topButn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImageView *topImg = self.topULineArray[i];
        topImg.backgroundColor = [UIColor blackColor];
    }
    
    UIImageView *topImg = self.topULineArray[page];
    UIButton *topButn = self.topViewBtnArray[page];
    [topButn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    topImg.backgroundColor = [UIColor redColor];
    
    if (page >= 3) {
       // self.topBtnScroView.contentOffset = CGPointMake((page - 2) * KTopViewBtnW, 0);
        [self.topBtnScroView setContentOffset:CGPointMake((page - 2) * KTopViewBtnW, 0) animated:YES];
    }else if(page == 0) {
//        self.topBtnScroView.contentOffset = CGPointMake( page *  KTopViewBtnW, 0);
        [self.topBtnScroView setContentOffset:CGPointMake( page *  KTopViewBtnW, 0) animated:YES];
        
    }
}

@end
