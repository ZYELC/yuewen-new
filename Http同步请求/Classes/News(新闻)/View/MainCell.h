//
//  MainCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/20.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface MainCell : UITableViewCell
+ (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) NewsModel * model;
@end
