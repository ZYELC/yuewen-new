//
//  ButtonCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface ButtonCell : UITableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) NewsModel * model;
+ (CGFloat)rowHeight;
@end
