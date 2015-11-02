//
//  IWTabBar.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"

@interface IWTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, weak) IWTabBarButton *selectedButton;
@end

@implementation IWTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"update_top_bar"]];

        
        // 添加一个加号按钮
//        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
//        [self addSubview:plusButton];
//        self.plusButton = plusButton;
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    IWTabBarButton *button = [[IWTabBarButton alloc] init];
    [self addSubview:button];
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(IWTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 1.取出按钮
        IWTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
@end
