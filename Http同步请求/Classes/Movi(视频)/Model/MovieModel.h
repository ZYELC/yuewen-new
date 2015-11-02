//
//  MovieModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/2.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject
/**
 *  初始化Model
 *
 *  @param dict 每个视频result 内部字典
 */
- (void)initWithDict:(NSDictionary *)dict;
/**
 *  唯一iD
 */
@property (nonatomic, strong) NSString * scid;
/**
 *  截图
 */
@property (nonatomic, strong) NSString * pic;
/**
 * 下载服务器
 */
@property (nonatomic, strong) NSString * streamBase;
/**
 *  vend
 */
@property (nonatomic, strong) NSString * vend;
/**
 *  视频信息
 */
@property (nonatomic, strong) NSString * ext;
/**
 *  视频基本图片链接，以及视频连接
 */
@property (nonatomic, strong) NSString * picBase;
/**
 *  视频图片格式
 */
@property (nonatomic, strong) NSString * pic_m;
/**
 *  视频图片格式
 */
@property (nonatomic, strong) NSString * pic_s;
/**
 *  视频播放时长
 */
@property (nonatomic, strong) NSString * lengthNice;
/**
 *  名称
 */
@property (nonatomic, strong) NSString * name;
/**
 *  宽度
 */
@property (nonatomic, strong) NSString * w;
/**
 *  高度
 */
@property (nonatomic, strong) NSString * h;
/**
 *  专题suid
 */
@property (nonatomic, strong) NSString * stpid;
/**
 *  图片
 */
@property (nonatomic, strong) NSString * img;
/**
 *  类型
 */
@property (nonatomic, strong) NSString * type;
/**
 *  合集地址
 */
@property (nonatomic, strong) NSString * in_url;
@end
