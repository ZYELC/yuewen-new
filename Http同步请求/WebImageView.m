//
//  WebImageView.m
//  0910WebImageView
//
//  Created by qianfeng on 14/3/10.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//http://f.hiphotos.baidu.com/baike/c0%3Dbaike180%2C5%2C5%2C180%2C60/sign=ed531e43bca1cd1111bb7a72d87ba399/0e2442a7d933c895c4cc6208d71373f082020016.jpg
#import "WebImageView.h"
@interface WebImageView ()
{}
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) UIActivityIndicatorView *aiv;
@end

@implementation WebImageView
- (NSMutableData *)data
{
    if (!_data) {
        _data = [NSMutableData data ];
    }
    return _data;
}


#pragma mark 封装网络图片视图
- (void)setImageWithUrl1:(NSURL *)url
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30];
        
        dispatch_async(dispatch_queue_create("downloadPic", DISPATCH_QUEUE_SERIAL), ^{
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:NULL];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [UIImage imageWithData:data];
            });
        });
        
    }];
   
}
@end
