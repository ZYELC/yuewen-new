//
//  HeadADModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadADModel : NSObject
@property (nonatomic, strong) NSString * stypename;
@property (nonatomic, copy) NSString * img;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * stype;
+ (instancetype)headADModelWithDic:(NSDictionary *)dic;
@end
