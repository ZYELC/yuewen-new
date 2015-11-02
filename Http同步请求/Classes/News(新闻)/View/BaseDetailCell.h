//
//  BaseDetailCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface BaseDetailCell : UITableViewCell
@property (nonatomic, strong) NewsModel * model;
+ (instancetype)initWithTableView:(UITableView *)tableView;
+ (CGFloat)rowHeight;
@end
