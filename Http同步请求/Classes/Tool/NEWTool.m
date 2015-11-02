//
//  NEWTool.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/19.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "NEWTool.h"
#import "HeadADModel.h"
#import "NewsModel.h"
#import "AFNetworking.h"
#import "ZYNewsDBManager.h"
@interface NEWTool()
{
    NSMutableDictionary *_informationDict;
    NSMutableArray      *_adModelArray;
    NSMutableArray      *_dataArray;
    NSMutableArray      *_listArray;
    NSTimer             *_timer;
}
@end

@implementation NEWTool


#pragma mark -- 解析首页数据
- (void )loadFirstViewData:(NSString *)url tableView:(UITableView *)tableview isRemoveAll:(BOOL)isRemoveAll informationDict:(NSMutableDictionary *)informationDict isFirstLoad:(BOOL)isFirstLoad succes:(SuccessBlock)successblock{
    _informationDict = [[NSMutableDictionary alloc]init];
    _adModelArray = [NSMutableArray arrayWithCapacity:0];
    _dataArray  = [NSMutableArray arrayWithCapacity:0];
    _listArray = [NSMutableArray arrayWithCapacity:0];
    
    _informationDict = informationDict;
    
#warning 改了这
    // 1.先从缓存里面加载
    NSArray *statusArray =  [ZYNewsDBManager statuesWithType:@"-1"];
    if (statusArray.count && !isFirstLoad) { // 有缓存
        // 传递了block
        if (successblock) {
            _dataArray = [NSMutableArray arrayWithArray:statusArray];
            NSArray *adArr = [ZYNewsDBManager statuesWithType:@"-1AD"];
            _adModelArray = [NSMutableArray arrayWithArray:adArr];
            [self saveModelArrayWithTableViewAdress:tableview];
            successblock(_informationDict);
        }

    }else{
    
        [[AFHTTPRequestOperationManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObjiect)
         {
              [_timer invalidate];
              _timer = nil;
             NSDictionary *dict = responseObjiect;
             NSDictionary *application = [dict objectForKey:@"data"];
             //校验feed数据异常
             NSString  *error = [dict objectForKey:@"message"];
             if ([error isEqualToString:@"feed流异常"] || (dict == nil) ) {
                 [self loadFirstViewData:url  tableView:tableview isRemoveAll:isRemoveAll informationDict:informationDict isFirstLoad:isFirstLoad succes:^(id data) {
                     _informationDict = data;
                     [tableview reloadData];
                 }];
                 NSLog(@"%@ ",error);
                 return;
             }
            
            [self analasysTopADData:application];
             
             //解析详情页数据
             [self nanalasysDetailData:application];
             //保存页面数据
             [self saveModelArrayWithTableViewAdress:tableview];
             successblock(_informationDict);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@ ",error);
             [self loadFirstViewData:url  tableView:tableview isRemoveAll:isRemoveAll informationDict:informationDict isFirstLoad:isFirstLoad succes:^(id data) {
                 _informationDict = data;
                 [tableview reloadData];
             }];

         }];
    
    }
}

#pragma mark-- 解析顶部轮播广告数据
- (void)analasysTopADData:(NSDictionary *)application{
    NSDictionary *banner      = [application objectForKey:@"banner"];
    NSArray      *newsArray   = [banner objectForKey:@"items"];
    for(NSDictionary *newsDic in newsArray){
        HeadADModel *model = [[HeadADModel alloc ] init];
        [model setValuesForKeysWithDictionary:newsDic];
        if ([model.stypename isEqualToString:@"广告"]||[model.stypename isEqualToString:@"专题"]) {
            continue;
        }
        model.stype = @"-1AD";
        [_adModelArray addObject:model];
    }
}

#pragma mark-- 解析详情数据
- (void)nanalasysDetailData:(NSDictionary *)application{
    NSArray *feedlist = [application objectForKey:@"feedlist"];
    for (NSDictionary *dic in feedlist)
    {
        
        
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *newsArray = [dic objectForKey:@"items"];
        for(NSDictionary *newsDic in newsArray){
            NewsModel *model = [[NewsModel alloc] init];
            
            [model setValuesForKeysWithDictionary:newsDic];
            model.stypename = dic[@"name"];
            model.stype = application[@"type"];
            [arr addObject:model];
        }
       
        [_dataArray addObject:arr];
    }
}
#pragma mark -- 储存每个页面数据
- (void)saveModelArrayWithTableViewAdress:(UITableView *)tableView{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    NSArray *adArr = [NSArray arrayWithArray:_adModelArray];
    NSArray *dataArr = [NSArray arrayWithArray:_dataArray];
    [dataDict setValue:adArr forKey:@"ADModelArray"];
    [dataDict setValue:dataArr forKey:@"dataArray"];
    [_informationDict setValue:dataDict forKey:[NSString stringWithFormat:@"%p",tableView]];
    //NSLog(@"%@ ",[NSString stringWithFormat:@"%p",tableView]);
}

@end
