//
//  DBManager.m
//  1512LimitFree
//
//  Created by qianfeng on 14/3/16.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

#import "SoundModel.h"

@interface DBManager ()
{
    FMDatabase *_fmdb; // 数据库对象
    NSLock     *_lock; // 锁
}
@end

static DBManager *_db;
@implementation DBManager

// 单例模式
+ (instancetype)shareManager {
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _db = [[DBManager alloc] init];
    });
    
    return _db;
}

- (instancetype)init {
    if (self = [super init]) {
        // 初始化锁
        _lock = [[NSLock alloc] init];
        
        // 创建数据库
        NSString *dbPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/app.db"];
        NSLog(@"沙盒路径:%@", dbPath);
        _fmdb = [FMDatabase databaseWithPath:dbPath];
        
        // 打开数据库
        BOOL isOpen = [_fmdb open];
        
        if (isOpen) {
            // 创建表: 创建了app表，里面有三个字段,第一个:应用ID；第二个:应用名称;第三个:应用图标路径; 第四个app链接.
            NSString *sql = @"create table if not exists app (appID varchar(100), appName varchar(100), appIcon varchar(1024), appUrl varchar(100))";
            
            // 执行sql语句
            BOOL isSuccess = [_fmdb executeUpdate:sql];
            if (isSuccess) {
                ZYLog(@"建表成功");
            } else {
                ZYLog(@"建表失败");
            }
            
            
        } else {
            ZYLog(@"数据库打开失败");
        }
        
    }
    
    return self;
}

- (BOOL)insertDataWithDetailModel:(SoundModel *)model
{
    // 加锁 : 为了防止多条线程同时去访问插入数据的代码导致数据紊乱.所以加锁保证在插入数据的时间内只有一条线程访问.
    [_lock lock];
    
    // 1. sql语句
    // ?是sql语句里面的占位符
    NSString *sql = @"insert into app values(?, ?, ?, ?)";
    
    // 2. 执行sql语句
    BOOL isSuccess =[_fmdb executeUpdate:sql, model.userid, model.name, model.pic_200, model.source];
    
    // 3. 是否成功
    NSLog(isSuccess ? @"插入成功" : @"插入失败");
    
    // 解锁
    [_lock unlock];
    
    return isSuccess;
}

- (BOOL)deleteDataWithAppID:(NSString *)appID {
    [_lock lock];
    
    NSString *sql = @"delete from app where appID = ?";
    
    BOOL isSuccess = [_fmdb executeUpdate:sql, appID];
    
    NSLog(isSuccess ? @"删除成功" : @"删除失败");
    
    [_lock unlock];
    
    return isSuccess;
}

- (BOOL)selectOneDataWithAppID:(NSString *)appID {
    
    NSString *sql = @"select * from app where appID = ?";
    
    // 查询方法:返回一个 查询结果集
    FMResultSet *set = [_fmdb executeQuery:sql, appID];
    
    // 结果 集有值，next返回Yes,否则返回No。
    return [set next];
}

- (NSArray *)selectAllData {
    NSString *sql = @"select * from app";
    
    FMResultSet *set = [_fmdb executeQuery:sql];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    // 遍历结果集
    while ([set next]) {
        SoundModel *model = [[SoundModel alloc] init];
        // 将结果里面的字段值转换为模型的属性
        model.userid = [set stringForColumn:@"appID"];
        
        model.name = [set stringForColumn:@"appName"];
        
        model.pic_200 = [set stringForColumn:@"appIcon"];
        
        model.source = [set stringForColumn:@"appUrl"];
        
        [arr addObject:model];
    }
    
    return arr;
}


@end
