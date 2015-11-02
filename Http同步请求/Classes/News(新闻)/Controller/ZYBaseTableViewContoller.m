//
//  ZYBaseTableViewContoller.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/14.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//
#import "ZYBaseTableViewContoller.h"
#import "NewsModel.h"
#import "BaseDetailCell.h"
#import "HeadViewAD.h"
#import "WebDetailView.h"
#import "HeadADModel.h"
#import "NoImgCell.h"
#import "BigDetailCell.h"
#import "ZYNewsDBManager.h"
#import "MainCell.h"

#define DATAKEY [NSString stringWithFormat:@"%d",(int)self.tableView.x]
#define ADDATAKEY [NSString stringWithFormat:@"AD%d",(int)self.tableView.x]
@interface ZYBaseTableViewContoller ()<MJRefreshBaseViewDelegate>
{
    NSMutableDictionary *_informationDict;
    NSMutableArray      *_adModelArray;
    NSMutableArray      *_dataArray;
    NSTimer             *_timer;
    NSInteger           _loadFirst;//首次加载
    NSInteger           _loadWebFirst;
    MJRefreshHeaderView *_headView;
    MJRefreshFooterView *_footView;
    
}
@end

@implementation ZYBaseTableViewContoller


- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    _informationDict = [[NSMutableDictionary alloc] init];
    _scroView = [[UIScrollView alloc]init];
    _scroView.frame = CGRectMake(0, 0, KWIDTH, 200);
    _scroView.backgroundColor = [UIColor  whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, 0, KWIDTH, KHIGHT)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headView = [[MJRefreshHeaderView alloc] init];
    _footView = [[MJRefreshFooterView alloc] init];
    _headView.scrollView = self.tableView;
    _footView.scrollView = self.tableView;
    _headView.delegate = self;
    _footView.delegate = self;
    _loadFirst = 1;
    _loadWebFirst = 1;

}


#pragma mark tableview代理方法
#pragma mark tableView每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{// NSLog(@"%lu ",(unsigned long)_dataArray.count);
    if (_dataArray.count == 0) {
        return 1;
    }else
    return _dataArray.count;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        return KHIGHT;
    }
    NewsModel *model = [[NewsModel alloc] init];
    model = _dataArray[indexPath.row];
    
    //判断是否有大图
    if ([model.imgWidth floatValue] > [model.imgHeight floatValue] &&([model.imgWidth floatValue] > KWIDTH)) {
        return [BigDetailCell rowHeight];
    }else{
        return [BaseDetailCell rowHeight];
        
    }
}
#pragma mark 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count == 0) {
        MainCell *cell = [MainCell initWithTableView:tableView];
        return cell;
    }
    
    NewsModel *model = [[NewsModel alloc] init];
    model = _dataArray[indexPath.row];
    
    if ([_dataArray[indexPath.row] img].length == 0) {
        NoImgCell *cell = [NoImgCell initWithTableView:tableView];
        cell.model = _dataArray[indexPath.row];
        return cell;
    }
    //判断是否有大图
    if (([model.imgWidth floatValue] > [model.imgHeight floatValue]) && ([model.imgWidth floatValue] > KWIDTH)) {
        BigDetailCell *cell = [BigDetailCell initWithTableView:tableView];
        cell.model = _dataArray[indexPath.row];
        return cell;
    }
    
    BaseDetailCell *cell = [BaseDetailCell initWithTableView:tableView];
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}
#pragma mark 点击cell操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebDetailView *webVIew = [[WebDetailView alloc]init];
    NewsModel *model = _dataArray[indexPath.row];
    webVIew.url = model.url;
    webVIew.model = model;
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    [self.navigationControll pushViewController:webVIew animated: NO];
    [self.navigationControll.view.layer addAnimation:transition forKey:nil];
    
}
#pragma mark -- 解析网页数据
- (void)loadData:(NSString *)url isRemoveAll:(BOOL)isRemoveAll{
    //判断相同时间不再加载
    if (_loadWebFirst) {
         _loadWebFirst = 0;
        
        //页面第一次加载数据
        if (_loadFirst)
        {  _loadFirst = 0;
            //第一次加载时间戳赋值0
            _oldTimestamp = [ZYTool objectForkey:DATAKEY];
            NSLog(@"%@ ",_oldTimestamp);
            
            // 1.先从缓存里面加载
            NSArray *statusArray = [ZYNewsDBManager statuesWithType:DATAKEY];
            NSLog(@"%ld ",statusArray.count);
            if (statusArray.count) { // 有缓存
                NSArray *adArr = [ZYNewsDBManager statuesWithType:ADDATAKEY];
                
                _dataArray = [NSMutableArray arrayWithCapacity:0];
                _adModelArray = [NSMutableArray arrayWithArray:0];
                _dataArray = [NSMutableArray arrayWithArray:statusArray];
                _adModelArray = [NSMutableArray arrayWithArray:adArr];
                [self creatTopScrollView];
                [self.tableView reloadData];
                
            }else  { [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [self loadWebData:url isRemoveAll:isRemoveAll];
            }
            
    }else  [self loadWebData:url isRemoveAll:isRemoveAll];
        
    }else return;
    
}

- (void)loadWebData:(NSString *)url isRemoveAll:(BOOL)isRemoveAll{
   
    [ZYTool sendGetWithUrl:url parameters:nil success:^(id data) {
        [_timer invalidate];
        _timer = nil;
        if (isRemoveAll) {
            _dataArray = [NSMutableArray arrayWithCapacity:0];
        }
        
        NSDictionary *dict = ZYJsonParserWithData(data);
        NSDictionary *dataA = [dict objectForKey:@"data"];
        //校验feed数据异常
        NSString  *error = [dict objectForKey:@"message"];
        
        if ([error isEqualToString:@"feed流异常"]) {
            NSLog(@"加载错误:%@ ",error);
            [self loadData:url isRemoveAll:isRemoveAll];
            return ;
        };
        // 结束刷新
        [_headView endRefreshing];
        [_footView endRefreshing];
        
        _oldTimestamp = dataA[@"oldTimestamp"];
        [ZYTool setObject:_oldTimestamp forKey:DATAKEY];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (isRemoveAll) {
            //解析顶部广告数据
            [self analasysTopADData:dataA];
        }       
        
        //解析详情页数据
        [self nanalasysDetailData:dataA];
        
        //缓存
        //NSLog(@"%@ ",[NSString stringWithFormat:@"%f",self.tableView.x]);
        [ZYNewsDBManager  deleteDataWithType:DATAKEY];
        [ZYNewsDBManager  deleteDataWithType:ADDATAKEY];
        [ZYNewsDBManager addStatuses:_dataArray];
        [ZYNewsDBManager addADStatuses:_adModelArray];
        
        //保存页面数据
        [self saveModelArrayWithTableViewAdress];
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        NSLog(@"%@ ",error);
        // 结束刷新
        [_headView endRefreshing];
        [_footView endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
#pragma mark-- 解析顶部轮播广告数据
- (void)analasysTopADData:(NSDictionary *)dataA{
    _adModelArray = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *banner      = [dataA objectForKey:@"banner"];
    NSArray      *newsArray   = [banner objectForKey:@"items"];
    for(NSDictionary *newsDic in newsArray){
        HeadADModel *model = [[HeadADModel alloc ] init];
        [model setValuesForKeysWithDictionary:newsDic];
        if ([model.stypename isEqualToString:@"广告"]||[model.stypename isEqualToString:@"专题"]||[model.stypename isEqualToString:@"杂志"]) {
            continue;
        }
        model.stype = ADDATAKEY;
        [_adModelArray addObject:model];
    }
    [self creatTopScrollView];
   }
#pragma mark 创建轮播图
- (void)creatTopScrollView{
    if (_adModelArray.count == 0) {
        self.tableView.tableHeaderView = nil;
       
        return;
    }else{
        self.tableView.tableHeaderView = _scroView;
    }
    
    [HeadViewAD initWithScroView:self.scroView  andADModel:_adModelArray WithTarget:self WithAction:@selector(clickTopADView:)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];

}
#pragma mark-- 解析详情数据
- (void)nanalasysDetailData:(NSDictionary *)data{
    NSArray *feedlist = [data objectForKey:@"feedlist"];
    for (NSDictionary *dic in feedlist)
    {
        NSArray *newsArray = [dic objectForKey:@"items"];
        for(NSDictionary *newsDic in newsArray){
            
            NewsModel *model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:newsDic];
            model.stype = DATAKEY;
            if (model.title.length == 0 || [model.stypename isEqualToString:@"广告"]||[model.stypename isEqualToString:@"杂志"]||[model.stypename isEqualToString:@"专题"]) {//如果标题为空扔掉该数据
                continue;
            }
            
            [_dataArray addObject:model];
        }
    }
}
#pragma mark -- 储存每个页面数据
- (void)saveModelArrayWithTableViewAdress{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    NSArray *adArr = [NSArray arrayWithArray:_adModelArray];
    NSArray *dataArr = [NSArray arrayWithArray:_dataArray];
    [dataDict setValue:adArr forKey:@"ADModelArray"];
    [dataDict setValue:dataArr forKey:@"dataArray"];
    [_informationDict setValue:dataDict forKey:@"information"];
}

#pragma mark  定时自动换页
- (void)nextPage
{
    if (_adModelArray.count == 1) {
        return;
    }
    if (_scroView.contentOffset.x == _adModelArray.count * KWIDTH) {
        [_scroView setContentOffset:CGPointMake( 0, 0) animated:NO];
        
    }    
    if (_scroView.contentOffset.x < (_adModelArray.count-1) *KWIDTH) {
        [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x+KWIDTH, 0) animated:YES];
    }else{
        
        [ UIView animateWithDuration:100 animations:^{
            [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x + KWIDTH, 0) animated:YES];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                //[_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x+375, 0) animated:YES];
            } completion:^(BOOL finished) {
                
            }];
        }];
        
    }
    
}
#pragma mark  刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
       _loadWebFirst = 1;
    if (refreshView == _headView) {
        NSString *realUrl = [_url stringByAppendingString:[NSString stringWithFormat:@"&ot=%@&nt=0",@"0"]];
         NSLog(@"%@ ",_oldTimestamp);
        [self loadData:realUrl isRemoveAll:YES];
    }else{
        NSString *realUrl = [_url stringByAppendingString:[NSString stringWithFormat:@"&ot=%@&nt=0",_oldTimestamp]];
        NSLog(@"%@ ",_oldTimestamp);
        NSLog(@"%@ ",realUrl);
        [self loadData:realUrl isRemoveAll:NO];
    }
    
    
    NSLog(@"刷新成功:MJ ");
}

#pragma mark - 点击顶部广告页面
- (void)clickTopADView:(UIGestureRecognizer *)tap{
    WebDetailView *webVIew = [[WebDetailView alloc]init];
    HeadADModel *model = _adModelArray[tap.view.tag];
    
    webVIew.url = model.url;
    
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    //transition.duration = 1;
    
    
    [self.navigationControll.view.layer addAnimation:transition forKey:nil];
    [self.navigationControll pushViewController:webVIew animated:YES];
    
    
    
}
@end
