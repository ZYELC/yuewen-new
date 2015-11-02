//
//  ZYTool.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ZYTool.h"
#import "AFNetworking.h"

@implementation ZYTool
+ (void)setObject:(id)obj forKey:(NSString *)key
{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBool:(BOOL)b forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] setBool:b forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForkey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (UIImage *)resizeImage:(UIImage *)image
{
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    
    return [image stretchableImageWithLeftCapWidth:w / 2 topCapHeight:h / 2];
}

+ (void)sendGetWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error);
    }];
}
#pragma mark  获取缓存大小
+ (NSString *)getCacheSize
{
    // 获取图片缓存大小 单位:B
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    
    NSString *sizeStr;
    
    if (size < 1024) {
        sizeStr = [NSString stringWithFormat:@"%lu B", (unsigned long)size];
    } else if (size >= 1024 && size < 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2f KB", size / 1024.0];
    } else if (size >= 1024 * 1024 && size < 1024 * 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2f MB", size / (1024 * 1024.0)];
    } else {
        sizeStr = [NSString stringWithFormat:@"%.2f GB", size / (1024 * 1024 * 1024.0)];
    }
    
    return sizeStr;
}
/**
 *  根据文字算出文字所占区域大小
 *
 *  @param text    文字内容
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *
 *  @return 实际尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont*)font MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

#pragma  mark - 获取当天的日期：年月日
+ (NSDictionary *)getTodayDate
{
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%d", [components year]];
    NSString *month = [NSString stringWithFormat:@"%02d", [components month]];
    NSString *day = [NSString stringWithFormat:@"%02d", [components day]];
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    
    return todayDic;
    
}




@end
