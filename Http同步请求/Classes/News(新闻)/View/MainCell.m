//
//  MainCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/20.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "MainCell.h"
#import "NewsModel.h"

@implementation MainCell

+ (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *ID = @"id";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    return cell;
}
- (void)addSubviews{
    
}
- (void)setModel:(NewsModel *)model{
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
