//
//  BaseDetailCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface BaseDetailCell : UITableViewCell
@property (nonatomic, strong) NewsModel * model;
+ (instancetype)initWithTableView:(UITableView *)tableView;
+ (CGFloat)rowHeight;
@end
