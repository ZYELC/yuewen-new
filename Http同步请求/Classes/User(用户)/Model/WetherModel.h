//
//  WetherModel.h
//  Http同步请求
//
//  Created by qianfeng on 14/10/15.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WetherModel : NSObject
@property (nonatomic, strong) NSString * day;
@property (nonatomic, strong) NSString * day_air_temperature;
@property (nonatomic, strong) NSString * day_weather;
@property (nonatomic, strong) NSString * day_weather_pic;
@property (nonatomic, strong) NSString * day_wind_direction;
@property (nonatomic, strong) NSString * day_wind_power;
@property (nonatomic, strong) NSString * night_air_temperature;
@property (nonatomic, strong) NSString * night_weather;
@property (nonatomic, strong) NSString * night_weather_pic;
@property (nonatomic, strong) NSString * night_wind_direction;
@property (nonatomic, strong) NSString * night_wind_power;
@property (nonatomic, strong) NSString * sun_begin_end;
@property (nonatomic, strong) NSString * weekday;
@end
