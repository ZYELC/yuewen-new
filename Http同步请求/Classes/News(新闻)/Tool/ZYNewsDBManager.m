//
//  ZYNewsDBManager.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/13.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYNewsDBManager.h"
#import "NewsModel.h"
#import "HeadADModel.h"
#import "FMDB.h"

@implementation ZYNewsDBManager
static FMDatabaseQueue *_queue;
#warning 改了这
+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    NSLog(@"%@ ",path);
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, type text, idstr text, dict blob);"];
    }];
}
#pragma mark 添加一组新闻
+ (void)addStatuses:(NSArray *)statusArray
{
    for (NewsModel *dict in statusArray) {
        [self addStatus:dict];
    }
}
#pragma mark 添加一条新闻
+ (void)addStatus:(NewsModel *)status
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *type = [NSString stringWithFormat:@"%@",status.stype];
      // NSLog(@"%@ ",type);
        NSString *idstr = [NSString stringWithFormat:@"%@",status.userID];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (type, idstr, dict) values(?, ? , ?)", type, idstr, data];
    }];
}
#pragma mark 添加滚动栏新闻组
+ (void)addADStatuses:(NSArray *)statusArray{
    for (HeadADModel *dict in statusArray) {
        [self addADStatus:dict];
    }

}
+ (void)addADStatus:(HeadADModel *)status{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        
        NSString *type = [NSString stringWithFormat:@"%@",status.stype];
        NSString *idstr = [NSString stringWithFormat:@"%@",status.url];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (type, idstr, dict) values(?, ? , ?)", type, idstr, data];
    }];

}
#pragma mark 添加主页一组新闻
+ (void)addMainStatuses:(NSArray *)statusArray{
    for (NSArray *dict in statusArray) {
        [self addMainStatus:dict];
    }
}
#pragma mark 添加主页一条新闻
+ (void)addMainStatus:(NSArray *)status{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *type = [NSString stringWithFormat:@"%@",[status[0] stype]];
        
        NSString *idstr = [NSString stringWithFormat:@"%@",[status[0] userID]];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (type, idstr, dict) values(?, ? , ?)", type, idstr, data];
    }];

}
#pragma mark 查询并返回N条新闻
+ (NSArray *)statuesWithType:(NSString *)type
{
    // 1.定义数组
    __block NSMutableArray *statusArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusArray = [NSMutableArray array];
        
        NSString *sql = [NSString stringWithFormat:@"select * from t_status where type = ?"];
        
        FMResultSet *set = [db executeQuery:sql, type];
        
        // 遍历结果集
        while ([set next]) {
            NSData *data = [set dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:dict];
        }
    }];
    
    // 3.返回数据
    return statusArray;
}
#pragma mark 根据类型删除新闻数据
+ (BOOL)deleteDataWithType:(NSString *)type {
  //  NSLog(@"%@ ",type);
    __block BOOL isSuccess;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        if ([type isEqualToString:@"all"]) {
            NSString *sql = [NSString stringWithFormat:@"delete  from t_status "];
            [db executeUpdate:sql];
        }else{
        NSString *sql = [NSString stringWithFormat:@"delete  from t_status where type = ?"];
#warning 这玩意怎么删除啊 😭
         isSuccess = [db executeUpdate:sql, type];
        }
            }];
    
   // NSLog(isSuccess ? @"删除成功" : @"删除失败");
    
    return isSuccess;
}

@end
