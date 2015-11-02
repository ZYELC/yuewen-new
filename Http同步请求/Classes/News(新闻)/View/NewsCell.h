//
//  NewsCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel,SoundModel;
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (nonatomic, strong) UILabel * noImgLabel;
@property (nonatomic, strong) NewsModel * model;
@property (nonatomic, strong) SoundModel * soundModel;
+ (instancetype)initWithTableView:(UITableView *)tableView;
+ (CGFloat)rowHeight;
@end
