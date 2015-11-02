//
//  ZYCommentCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/10.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CommentModel,CommentFrameModel;
@interface ZYCommentCell : UITableViewCell
@property (nonatomic, strong) CommentModel * model;
@property (nonatomic, strong) CommentFrameModel * frameModel;
/**
 *  初始化cell
 *
 *  @param tableView 当前tableview
 *
 *  @return 自定义cell
 */
+ (instancetype)initWithTableView:(UITableView *)tableView;
/**
 *  返回cell高度
 *
 *  @return cell高度
 */
+ (CGFloat)rowHeight;
@end
