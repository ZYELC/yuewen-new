//
//  BaseSoundViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/28.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "BaseSoundViewController.h"
#import "MagezineViewController.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "BaseDetailCell.h"
#import "HeadViewAD.h"
#import "WebDetailView.h"
#import "HeadADModel.h"
#import "NoImgCell.h"
#import "SoundModel.h"
#import "BigDetailCell.h"
#import "SoundWebDetailController.h"
#import "MusicWebController.h"

@interface BaseSoundViewController ()<MJRefreshBaseViewDelegate,UITableViewDelegate,UITableViewDataSource>

{
    
    UITableView         *_tableView;
    NSMutableDictionary *_informationDict;
    NSMutableArray      *_adModelArray;
    NSMutableArray      *_dataArray;
    NSTimer             *_timer;
    NSInteger           _pageNumber;
    MJRefreshHeaderView *_headView;
    MJRefreshFooterView *_footView;
    
}
@end

@implementation BaseSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _informationDict = [[NSMutableDictionary alloc] init];
    
    _scroView = [[UIScrollView alloc]init];
    _scroView.frame = CGRectMake(0, 0, 375, 200);
    _scroView.backgroundColor = [UIColor blackColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, 0, KWIDTH, KHIGHT - 70 - 47)];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // _tableView.tableHeaderView = _scroView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    self.url = SDDayHot;
    [self loadData:SDDayHot removeAll:0];
    _pageNumber = 1;
}

#pragma mark tableview代理方法
#pragma mark tableView每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{// NSLog(@"%lu ",(unsigned long)_dataArray.count);
    return _dataArray.count;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BigDetailCell rowHeight] == 0 ? 44 :[BigDetailCell rowHeight];
}
#pragma mark 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BigDetailCell *cell = [BigDetailCell initWithTableView:tableView];
    cell.soundModel = _dataArray[indexPath.row];
    return cell;
}

#pragma mark 点击cell操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SoundWebDetailController *soundVIew = [[SoundWebDetailController alloc]init];
    SoundModel *model = _dataArray[indexPath.row];
    
    soundVIew.model = model;
    soundVIew.url = model.source;
    soundVIew.pic640 = model.pic_640;
    soundVIew.info = model.info;
    soundVIew.userid = model.userid;
    
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    [self.navigationControll pushViewController:soundVIew animated: NO];
    [self.navigationControll.view.layer addAnimation:transition forKey:nil];
}

#pragma mark -- 解析网页数据
- (void)loadData:(NSString *)url removeAll:(BOOL)isRemove{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *Str = @"http://echosystem.kibey.com/sound/hot?android_v=77&app_channel=kibey&page=%ld&t=1443432658350&v=9";
    NSString *urlStr = [NSString stringWithFormat:url,_pageNumber];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         // 结束刷新
         [MBProgressHUD hideHUDForView:self.view];
         [_timer invalidate];
         _timer = nil;
         if (!isRemove) {
             _dataArray = [NSMutableArray arrayWithCapacity:0];
         }
         //  NSLog(@"%@ ",responseObject);
         NSDictionary *dict = responseObject;
         NSDictionary *result = dict[@"result"];
         NSDictionary *application = [result objectForKey:@"data"];
         
         //解析详情页数据
         [self nanalasysDetailData:application];
         
         [_tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD hideHUDForView:self.view];
         NSLog(@"%@ ",error);
     }];
}

- (void)loadData1:(NSString *)url removeAll:(BOOL)isRemove{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSDate *date = [NSDate date];
    NSMutableString *dateStr = [NSMutableString stringWithFormat:@"%f",date.timeIntervalSince1970] ;
    NSRange range= [dateStr rangeOfString:@"."];
    //将范围内的字符串删除
    [dateStr deleteCharactersInRange:range];
    //从第一个字符串开始，取3个字符返回
    NSString *timeTnterval=[dateStr substringToIndex:13];
   // NSLog(@"%@ ",timeTnterval);
    NSString *param=[NSString stringWithFormat:@"android_v=77&app_channel=kibey&period=weekly&t=%@&v=9&",timeTnterval];

    [manager POST:@"http://echosystem.kibey.com/hot/sounds" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 结束刷新
        [MBProgressHUD hideHUDForView:self.view];
        [_headView endRefreshing];
        [_footView endRefreshing];
        [_timer invalidate];
        _timer = nil;
        if (!isRemove) {
            _dataArray = [NSMutableArray arrayWithCapacity:0];
        }
        //NSLog(@"%@ ",responseObject);
        NSDictionary *dict = responseObject;
        NSDictionary *result = dict[@"result"];
        NSDictionary *application = [result objectForKey:@"data"];
       // [self analasysTopADData:application];

        //解析详情页数据
        [self nanalasysDetailData:application];
        
        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [_headView endRefreshing];
        [_footView endRefreshing];
    }];
}
#pragma mark-- 解析顶部轮播广告数据
- (void)analasysTopADData:(NSDictionary *)application{
    _adModelArray = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *banner      = [application objectForKey:@"banner"];
    NSArray      *newsArray   = [banner objectForKey:@"items"];
    for(NSDictionary *newsDic in newsArray){
        HeadADModel *model = [HeadADModel headADModelWithDic:newsDic];
        [_adModelArray addObject:model];
    }
    
    //创建轮播栏
    [HeadViewAD initWithScroView:self.scroView  andADModel:_adModelArray WithTarget:self WithAction:nil];
    
    //启动定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

#pragma mark-- 解析详情数据
- (void)nanalasysDetailData:(NSDictionary *)application{
    
    for (NSDictionary *dic in application)
    {
        SoundModel *model = [[SoundModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        //查找，在s1中查找子字符串，返回子字符串在s1中的位置和长度，是个结构体
        NSRange range = [model.name rangeOfString:@"舔"];
        //表示没有找到子字符串
        if(range.location == NSNotFound){
           [_dataArray addObject:model];
        }else{
           continue;
        }

        
    }
}

#pragma mark 自动换页
- (void)nextPage
{
    if (_scroView.contentOffset.x < (_adModelArray.count-1) *375) {
        [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x+375, 0) animated:YES];
    }else{
        [_scroView setContentOffset:CGPointMake( 0, 0) animated:NO];
    }
}
#pragma mark-- 刷新加载更多
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if (refreshView == _headView) { // 下拉刷新
        
        _pageNumber = 1;
        [self loadData:_url removeAll:0];
    } else { // 上拉加载更多
        _pageNumber ++;
        [self loadData:_url removeAll:1];
    }
    
    NSLog(@"刷新成功：MJ ");
}


@end
