//
//  ZYTool.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *error);

@interface ZYTool : NSObject

// 存值
/**
 *  存储数据到沙河
 *
 *  @param obj 要存储的数据
 *  @param key key
 */
+ (void)setObject:(id)obj forKey:(NSString *)key;
/**
 *  存储数据到沙河
 *
 *  @param b   BOOL变量
 *  @param key key
 */
+ (void)setBool:(BOOL)b forKey:(NSString *)key;

/**
 *  从沙河取出数据
 *
 *  @param key key
 *
 *  @return id类型数据
 */
+ (id)objectForkey:(NSString *)key;
/**
 *  从沙河取出BOOL数据
 *
 *  @param key key
 *
 *  @return BOOL类型数据
 */
+ (BOOL)boolForKey:(NSString *)key;

// 设置图片拉伸点
+ (UIImage *)resizeImage:(UIImage *)image;

// 封装网络请求
+ (void)sendGetWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock;

/**
 *  获取缓存大小
 */
+ (NSString *)getCacheSize;
//计算文字size 返回labelsize
/**
 *  获取size大小
 *
 *  @param text    文字
 *  @param font    字体
 *  @param maxSize 最大size
 *
 *  @return label CGsize
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont*)font MaxSize:(CGSize)maxSize;

/**
 *  获取今天的日期：年月日
 *
 *  @return 日期字典 根据key取值
 */
+(NSDictionary *)getTodayDate;

@end
