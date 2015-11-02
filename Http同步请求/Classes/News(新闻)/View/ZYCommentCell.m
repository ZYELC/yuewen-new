//
//  ZYCommentCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/10.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYCommentCell.h"
#import "CommentModel.h"
#import "CommentFrameModel.h"

#define kMargin 10.0f
#define kIconWH 50.0f
#define kLabelW 200.0f
#define kLabelH 15.0f
@interface ZYCommentCell ()
{
    
    UILabel         *_nameLabel;
    UILabel         *_timeLabel;
    UILabel         *_commentLabel;
}
@end
@implementation ZYCommentCell
+ (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *ID = @"id";
    ZYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZYCommentCell alloc] init];
        [cell addsubViews];
    }
    
    return cell;

}
#pragma mark -- 添加自定义视图
- (void)addsubViews{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"网友10235";
    _nameLabel.font = ZYFont(12);
    [self.contentView addSubview:_nameLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"10:15";
    _timeLabel.font = ZYFont(10);
    [self.contentView addSubview:_timeLabel];
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.text = @"这个新闻真是好";
    _commentLabel.numberOfLines = 0;
    _commentLabel.font = ZYFont(15);
    [self.contentView addSubview:_commentLabel];
    
}
#pragma mark -- 内容赋值
- (void)setModel:(CommentModel *)model{
//    CGFloat nameWidth = [ZYTool labelAutoCalculateRectWith:model.nickname Font:ZYFont(12) MaxSize:CGSizeMake(KWIDTH * 0.7, kLabelH)].width;
//    _nameLabel.width = nameWidth;
    _nameLabel.text = model.nickname;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.createdAt];
    
    _commentLabel.text = model.content;
}
- (void)setFrameModel:(CommentFrameModel *)frameModel{
    _frameModel = frameModel;
    
    _nameLabel.frame = frameModel.nameLabelFrame;
    _timeLabel.frame = frameModel.timeLabelFrame;
    _commentLabel.frame = frameModel.commentLabelFrame;
    
    _nameLabel.text = frameModel.model.nickname;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",frameModel.model.createdAt];
    
    _commentLabel.text = frameModel.model.content;
    
    
}
#pragma mark -- 返回cell高度

@end
