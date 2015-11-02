//
//  CommentModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/10.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/**
 *  网名
 */
@property (nonatomic, strong) NSString * nickname;
/**
 *  评论内容
 */
@property (nonatomic, strong) NSString * content;
/**
 *  评论时间
 */
@property (nonatomic, strong) NSString * createdAt;
@end
