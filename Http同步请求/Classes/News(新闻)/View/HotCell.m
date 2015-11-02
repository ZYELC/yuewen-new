//
//  HotCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "HotCell.h"
@interface HotCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation HotCell
+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"id5";
    HotCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
+ (CGFloat)rowHeight{
    return 74;
}
- (void)setModel:(NewsModel *)model{
    _model = model;
    _titleLabel.text = model.title;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
