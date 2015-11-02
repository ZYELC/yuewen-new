//
//  HeadADModel.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/10.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "HeadADModel.h"
#import "MJExtension.h"

@implementation HeadADModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
+ (instancetype)headADModelWithDic:(NSDictionary *)dic
{
    
        HeadADModel *model = [[HeadADModel alloc]init];
        model.title = [dic objectForKey:@"title"];
        model.img   = [dic objectForKey:@"img"];
    return model;
}

MJCodingImplementation
@end
