//
//  MovieModel.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/2.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel
- (void)initWithDict:(NSDictionary *)dict{
    
    
     self.type = dict[@"type"];
    
    if ([self.type isEqualToString:@"in_url"]) {
        self.in_url = dict[@"in_url"][@"url"];
        
    }
    if (dict[@"channel"]) {
        NSDictionary *channel = dict[@"channel"];
        
        self.scid = channel[@"scid"];
        self.picBase = channel[@"pic"][@"base"];
        self.pic_m = channel[@"pic"][@"m"];
        self.pic_s = channel[@"pic"][@"c"];
        self.streamBase = channel[@"stream"][@"base"];
        self.vend = channel[@"stream"][@"vend"];
        self.lengthNice = channel[@"ext"][@"lengthNice"];
        self.name  = channel[@"ext"][@"t"];
        self.w = channel[@"ext"][@"w"];
        self.h = channel[@"ext"][@"h"];
    }else{
       
       // NSLog(@"%@ ",dict[@"topic"]);
       
        self.stpid = dict[@"topic"][@"stpid"];
        self.img = dict[@"img"];
        self.name = dict[@"title"];
    }
}
@end
