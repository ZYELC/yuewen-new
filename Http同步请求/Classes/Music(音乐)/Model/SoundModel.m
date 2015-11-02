//
//  SoundModel.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/25.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "SoundModel.h"

@implementation SoundModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"])
        self.userid = value;
    if ([key isEqualToString:@"channel"]) {
        self.channelName = value[@"name"];
    }
}

@end
