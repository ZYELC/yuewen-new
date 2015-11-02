//
//  NEWTool.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/19.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)(id data) ;
typedef void(^FailBlock)(NSError *error);
@interface NEWTool : NSObject
- (void )loadFirstViewData:(NSString *)url tableView:(UITableView *)tableview isRemoveAll:(BOOL)isRemoveAll informationDict:(NSMutableDictionary *)informationDict isFirstLoad:(BOOL)isFirstLoad succes:(SuccessBlock)successblock;
@end
