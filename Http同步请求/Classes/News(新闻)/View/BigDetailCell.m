//
//  BigDetailCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "BigDetailCell.h"
#import "NewsModel.h"
#import "SoundModel.h"

@interface BigDetailCell()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOutherLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation BigDetailCell

+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"bigdetail";
    BigDetailCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BigDetailCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
+ (CGFloat)rowHeight{
    return 260;
}
- (void)setModel:(NewsModel *)model{
    
    [_imgView setImageWithURL:[NSURL URLWithString:model.img]];
    _readCountLabel.text = [NSString stringWithFormat:@"%@",model.hot]  ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    
    NSMutableString *dateStr = [NSMutableString stringWithString:date.description];
    NSRange range = NSMakeRange(11, 5);
    
    _timeOutherLabel.text = [NSString stringWithFormat:@"%@ %@",model.source,[dateStr substringWithRange:range]];
  
    _titleLabel.text = model.title;

}
- (void)setSoundModel:(SoundModel *)soundModel{
    [_imgView setImageWithURL:[NSURL URLWithString:soundModel.pic_640]];
    _readCountLabel.text = [NSString stringWithFormat:@"%@",soundModel.like_count]  ;
   // NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    
  //  NSMutableString *dateStr = [NSMutableString stringWithString:date.description];
   // NSRange range = NSMakeRange(11, 5);
    
    [_timeOutherLabel  removeFromSuperview];
    
    _titleLabel.text = soundModel.name;

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
