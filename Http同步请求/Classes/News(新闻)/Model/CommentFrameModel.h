//
//  CommentFrameModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/12.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommentModel;
@interface CommentFrameModel : NSObject
@property (nonatomic, strong) CommentModel * model;
/**
 *  网名frame
 */
@property (nonatomic, assign) CGRect nameLabelFrame;
/**
 *  时间frame
 */
@property (nonatomic, assign) CGRect timeLabelFrame;
/**
 *  评论内容frame
 */
@property (nonatomic, assign) CGRect commentLabelFrame;
/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat  rowHeight;

+ (instancetype)commentFrameModelWithModel:(CommentModel *)model;
@end
