//
//  SoundWebDetailController.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/26.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SoundModel;
@interface SoundWebDetailController : UIViewController

@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * pic640;
@property (nonatomic, strong) NSString * info;
@property (nonatomic, strong) NSString * userid;

@property (nonatomic, strong) SoundModel * model;
@end
