
//
//  NewsModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/**
 *  标题
 */
@property (nonatomic, strong) NSString * title;
/**
 *  图片地址
 */
@property (nonatomic, strong) NSString * img;
/**
 *  内容
 */
@property (nonatomic, strong) NSString * desc;
/**
 *  链接地址
 */
@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSString * stypename;
/**
 *  热度
 */
@property (nonatomic, strong) NSString * hot;
/**
 *  新闻地址
 */
@property (nonatomic, strong) NSString * source;
/**
 *  时间
 */
@property (nonatomic, strong) NSNumber * time;
/**
 *  大图图片宽度
 */
@property (nonatomic, strong) NSNumber * imgWidth;
/**
 *  大图图片高度
 */
@property (nonatomic, strong) NSNumber * imgHeight;
/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat  cellHeight;
/**
 *  新闻id
 */
@property (nonatomic, strong) NSString * userID;
/**
 *  自定义model定义
 *
 *  @param dic dic
 */
- (void)newsModelWithDic:(NSDictionary *)dic;
/**
 *  类型
 */
@property (nonatomic, strong) NSString * stype;
@end
