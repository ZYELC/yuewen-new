//
//  SongModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/16.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * download_count;
@property (nonatomic, strong) NSString * view_count;
@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * length;
@property (nonatomic, strong) NSString * comment_count;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * channel_id;
@property (nonatomic, strong) NSString * like_count;
@property (nonatomic, strong) NSString * info;
@property (nonatomic, strong) NSString * share_count;
@property (nonatomic, strong) NSString * pic_100;
@property (nonatomic, strong) NSString * pic_200;
@property (nonatomic, strong) NSString * pic_500;
@property (nonatomic, strong) NSString * pic_640;
@property (nonatomic, strong) NSString * pic_750;
@property (nonatomic, strong) NSString * pic_1080;
@end
