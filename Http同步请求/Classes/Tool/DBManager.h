//
//  DBManager.h
//  1512LimitFree
//
//  Created by qianfeng on 14/3/16.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SoundModel;

@interface DBManager : NSObject

// 单例模式
+ (instancetype)shareManager;

// 删除数据
- (BOOL)deleteDataWithAppID:(NSString *)appID;

// 插入数据
- (BOOL)insertDataWithDetailModel:(SoundModel *)model;

// 根据appID查询单条数据
- (BOOL)selectOneDataWithAppID:(NSString *)appID;

// 查询所有数据
- (NSArray *)selectAllData;


@end
