//
//  ComentModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/16.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AutherModel;
@interface ComentModel : NSObject
@property (nonatomic, strong) NSString * create_time;
@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) NSString * start_time;

@property (nonatomic, strong) NSString * end_time;

@property (nonatomic, strong) NSString * sound_id;

@property (nonatomic, strong) NSString * user_id;
@property (nonatomic, strong) AutherModel * autherModel;
@end
