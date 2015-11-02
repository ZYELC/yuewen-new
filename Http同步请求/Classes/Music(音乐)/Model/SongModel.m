//
//  SongModel.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/16.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "SongModel.h"

@implementation SongModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.userID = value;
    }
}
@end
