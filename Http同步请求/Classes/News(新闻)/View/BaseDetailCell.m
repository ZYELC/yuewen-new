//
//  BaseDetailCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "BaseDetailCell.h"
#import "NewsModel.h"

@interface BaseDetailCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOutherLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation BaseDetailCell
+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"id2";
    BaseDetailCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BaseDetailCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(NewsModel *)model{
    _model = model;
    if (model.img.length == 0) {
        [_imgView removeFromSuperview];
        _titleLabel.frame = CGRectMake(0, 10, 300, 20);
        _readCountLabel.x = 10;
        _timeOutherLabel.x = _readCountLabel.width + 20;
        
    }else{
        [_imgView setImageWithURL:[NSURL URLWithString:model.img]];
    }
    
    _readCountLabel.text = [NSString stringWithFormat:@"%@",model.hot]  ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    
    NSMutableString *dateStr = [NSMutableString stringWithString:date.description];
    NSRange range = NSMakeRange(11, 5);
   
    
    _timeOutherLabel.text = [NSString stringWithFormat:@"%@ %@",model.source,[dateStr substringWithRange:range]];
   // NSLog(@"%@ ",model.source);
    _titleLabel.text = model.title;
}
- (void)awakeFromNib {
//    if (_model.img.length == 0) {
//        [_imgView removeFromSuperview];
//        _titleLabel.x = 10;
//        _readCountLabel.x = 10;
//        _timeOutherLabel.x = _readCountLabel.width + 20;
//        
//    }
    // Initialization code
}
+ (CGFloat)rowHeight{
    return 120;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
