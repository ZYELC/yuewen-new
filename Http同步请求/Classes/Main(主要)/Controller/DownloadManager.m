//
//  DownloadManager.m
//  EasyCookingTest
//
//  Created by fengweiru on 15/6/18.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager

+(DownloadManager *)shareInstance
{
    static DownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownloadManager alloc] init];
    });
    return manager;
}

//-(instancetype)init
//{
//    if (self = [super init]) {
//        _urlDict = [NSMutableDictionary dictionary];
//    }
//    return self;
//}
//
//-(void)addDownloaderWithUrlString:(NSString *)urlString delegate:(id<MyDownloaderDelegate>)delegate type:(NSInteger)type
//{
//    MyDownloader *downloader = [[MyDownloader alloc] init];
//    downloader.delegate = delegate;
//    downloader.type = type;
//    [downloader downloadWithUrlString:urlString];
//    
//    [_urlDict setValue:downloader forKey:urlString];
//}
//
//-(void)removeDownloaderWithArray:(NSArray *)array
//{
//    for (NSString *urlString in array) {
//        MyDownloader *downloader = _urlDict[urlString];
//        [downloader cancelDownloader];
//        [_urlDict removeObjectForKey:urlString];
//    }
//}

@end
