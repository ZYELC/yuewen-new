//
//  ButtonCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/21.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ButtonCell.h"
#import "NewsModel.h"

@interface ButtonCell ()
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@end
@implementation ButtonCell
+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"id4";
    ButtonCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ButtonCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
+ (CGFloat)rowHeight{
    return 30;
}
- (void)setModel:(NewsModel *)model{
    NSString *string = [NSString stringWithFormat:@"更多%@内容→",model.stypename];
   // NSLog(@"%@ ",string);
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string ];
    [attribute setAttributes:@{
                               NSForegroundColorAttributeName : [UIColor blackColor],
                               NSFontAttributeName : ZYFont(17)                                                                                                         } range:NSMakeRange(2, 2)];
    _moreLabel.attributedText = attribute;
   // _moreBtn.titleLabel.text = string;
   // [_moreLabel setAttribute:attribute forState:UIControlStateNormal];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
