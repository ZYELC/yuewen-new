//
//  WebDetailView.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

@interface WebDetailView : UIViewController

@property (nonatomic, strong) NSString * url;

@property (nonatomic, strong) NSString * userID;

@property (nonatomic, strong) NewsModel * model;
@end

//212 201 217