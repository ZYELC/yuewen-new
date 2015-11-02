//
//  NewsCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "NewsModel.h"
#import "SoundModel.h"

@implementation NewsCell

+ (instancetype)initWithTableView:(UITableView *)tableView{
    
    static NSString *ID2 = @"id2";
    NewsCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(NewsModel *)model{
    
    [_noImgLabel removeFromSuperview];
    
    if (model.img.length == 0) {
        
        [_imgView setImageWithURL:[NSURL URLWithString:model.img]];
        _detailLable.text = @"";
        _noImgLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 335, 60)];
        _noImgLabel.text = model.title;
        _noImgLabel.numberOfLines = 0;
        _noImgLabel.textColor = [UIColor blackColor];
        _noImgLabel.font = ZYFont(16);
        [self.contentView addSubview:_noImgLabel];

    }else{        
        [_imgView setImageWithURL:[NSURL URLWithString:model.img]];
        _detailLable.text = model.title;
    }
    
}
#pragma mark 填充音乐cell
- (void)setSoundModel:(SoundModel *)soundModel{
    [_imgView setImageWithURL:[NSURL URLWithString:soundModel.pic_200]];
    _detailLable.text = soundModel.name;
    
}
+ (CGFloat)rowHeight{
    return 87;
}


@end
