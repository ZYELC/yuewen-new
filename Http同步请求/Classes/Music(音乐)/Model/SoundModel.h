
//  SoundModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/25.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundModel : UIView
@property (nonatomic, strong) NSString * update_time;
@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) NSString * download_count;
@property (nonatomic, strong) NSString * share_count;
@property (nonatomic, strong) NSString * channelName;
@property (nonatomic, strong) NSString * like_count;
@property (nonatomic, strong) NSString * pic_640;
@property (nonatomic, strong) NSString * pic_500;
@property (nonatomic, strong) NSString * pic_200;
@property (nonatomic, strong) NSString * pic_100;

@property (nonatomic, strong) NSString * info;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * name;
@end
