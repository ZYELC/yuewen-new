//
//  NewsModel.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "NewsModel.h"
#import "MJExtension.h"

@implementation NewsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"])
    {
        self.userID = value;
    }

}
- (void)newsModelWithDic:(NSDictionary *)dic
{
        self.title = [dic objectForKey:@"title"];
        self.url   = [dic objectForKey:@"url"];
        self.img   = [dic objectForKey:@"img"];
        self.desc  = [dic objectForKey:@"desc"];
}
MJCodingImplementation
@end
