//
//  ZYNewsDBManager.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/13.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsModel;
@interface ZYNewsDBManager : NSObject


/**
 *  缓存一条新闻
 *
 *  @param status 需要缓存的新闻数据
 */
+ (void)addStatus:(NewsModel *)status;

/**
 *  缓存N条新闻
 *
 *  @param statusArray 需要缓存的新闻数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得新闻数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithType:(NSString *)type;
/**
 *  储存主页一条新闻
 *
 *  @param status 主页分组数组
 */
+ (void)addMainStatus:(NSArray *)status;
/**
 *  保存主页N条新闻
 *
 *  @param statusArray 模型数组
 */
+ (void)addMainStatuses:(NSArray *)statusArray;
/**
 *  返回保存的
 *
 *  @param type <#type description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray *)mainStatuesWithType:(NSString *)type;
/**
 *  删除之前存的数据
 *
 *  @param type 新闻类别标识
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteDataWithType:(NSString *)type;
/**
 *  添加广告数据
 *
 *  @param status 滚动栏新闻数组
 */
+ (void)addADStatuses:(NSArray *)statusArray;
@end
