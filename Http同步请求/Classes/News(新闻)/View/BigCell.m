//
//  BigCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "BigCell.h"
#import "NewsModel.h"
#import "WebImageView.h"

@interface BigCell()
{
    UILabel *_label;
}
@property (weak, nonatomic) IBOutlet WebImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *tiltleLabel;

@end
@implementation BigCell
+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"id3";
    BigCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BigCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
+ (CGFloat)rowHeight{
        return 190;
}
- (void)setModel:(NewsModel *)model{
         [_photoImg setImageWithUrl1:[NSURL URLWithString:model.img]];
    
         _tiltleLabel.text = model.title;
   }
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
