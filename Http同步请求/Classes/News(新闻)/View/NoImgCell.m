//
//  NoImgCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/23.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "NoImgCell.h"
#import "NewsModel.h"
@interface NoImgCell()
@property (weak, nonatomic) IBOutlet UILabel *timeOutherLabel;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation NoImgCell
+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"id2";
    NoImgCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoImgCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(NewsModel *)model{
    _model = model;
       
    _readCountLabel.text = [NSString stringWithFormat:@"%@",model.hot]  ;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.time intValue]];
    
    NSMutableString *dateStr = [NSMutableString stringWithString:date.description];
    NSRange range = NSMakeRange(11, 5);
    
    
    _timeOutherLabel.text = [NSString stringWithFormat:@"%@ %@",model.source,[dateStr substringWithRange:range]];
    // NSLog(@"%@ ",model.source);
    _titleLabel.text = model.title;
}
+ (CGFloat)rowHeight{
    return 89;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
