//
//  DownloadManager.h
//  EasyCookingTest
//
//  Created by fengweiru on 15/6/18.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MyDownloader.h"

@interface DownloadManager : NSObject
{
    NSMutableDictionary *_urlDict;
}

//+(DownloadManager *)shareInstance;
//
//-(void)addDownloaderWithUrlString:(NSString *)urlString delegate:(id<MyDownloaderDelegate>)delegate type:(NSInteger)type;
//
//-(void)removeDownloaderWithArray:(NSArray *)array;

@end
