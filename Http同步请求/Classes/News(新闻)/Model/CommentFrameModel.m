//
//  CommentFrameModel.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/12.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "CommentFrameModel.h"
#import "CommentModel.h"

#define kMargin 10.0f
#define kIconWH 50.0f
#define kLabelW 200.0f
#define kLabelH 15.0f
@interface CommentFrameModel()
@end

@implementation CommentFrameModel

+ (instancetype)commentFrameModelWithModel:(CommentModel *)model
{
    CommentFrameModel *comentModel = [[CommentFrameModel alloc]init ];
    comentModel.model = model;
    
    return comentModel;
}

- (void)setModel:(CommentModel *)model{
    _model = model;
        CGFloat nameWidth = [ZYTool labelAutoCalculateRectWith:model.nickname Font:ZYFont(12) MaxSize:CGSizeMake(KWIDTH * 0.7, kLabelH)].width;
    
    _nameLabelFrame = CGRectMake(kMargin, kMargin / 2, nameWidth, kLabelH);
    _timeLabelFrame = CGRectMake( nameWidth + 2 * kMargin, kMargin / 2, kLabelW, kLabelH);
    CGFloat commentHeight = [ZYTool labelAutoCalculateRectWith:model.content Font:ZYFont(15) MaxSize:CGSizeMake(KWIDTH - 2 * kMargin, MAXFLOAT)].height;
    _commentLabelFrame = CGRectMake(kMargin, _nameLabelFrame.size.height + 2 * kMargin, KWIDTH - 2 * kMargin, commentHeight);
    
    _rowHeight = _nameLabelFrame.size.height + _timeLabelFrame.size.height + _commentLabelFrame.size.height + 4 * kMargin;
}


@end
