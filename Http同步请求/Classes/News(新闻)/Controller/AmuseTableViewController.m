//
//  AmuseTableViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/24.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "AmuseTableViewController.h"
#import "NewsModel.h"
#import "BaseDetailCell.h"
#import "HeadViewAD.h"
#import "WebDetailView.h"
#import "HeadADModel.h"
#import "NoImgCell.h"

@interface AmuseTableViewController ()
{
//    NSMutableDictionary *_informationDict;
//    NSMutableArray      *_adModelArray;
//    NSMutableArray      *_dataArray;
//    NSTimer             *_timer;
//    NSInteger           _loadFirst;
//    MJRefreshHeaderView *_headView;
//    MJRefreshFooterView *_footView;    
}
@end

@implementation AmuseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = NEWAmuse;
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    _informationDict = [[NSMutableDictionary alloc] init];
//    
//    _scroView = [[UIScrollView alloc]init];
//    _scroView.frame = CGRectMake(0, 0, 375, 200);
//    _scroView.backgroundColor = [UIColor blackColor];
//    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, 0, KWIDTH, KHIGHT)];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.tableHeaderView = _scroView;
//    
//    _headView = [[MJRefreshHeaderView alloc] init];
//    _footView = [[MJRefreshFooterView alloc] init];
//    _headView.scrollView = self.tableView;
//    _footView.scrollView = self.tableView;
//    _headView.delegate = self;
//    _footView.delegate = self;
    
}

//#pragma mark tableview代理方法
//#pragma mark tableView每组行数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{ NSLog(@"娱乐页面加载成功资源个数为：%lu ",(unsigned long)_dataArray.count);
//    return _dataArray.count;
//}
//#pragma mark cell高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [BaseDetailCell rowHeight];
//}
//#pragma mark 填充cell
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_dataArray[indexPath.row] img].length == 0) {
//        NoImgCell *cell = [NoImgCell initWithTableView:tableView];
//        cell.model = _dataArray[indexPath.row];
//        return cell;
//    }
//    
//    BaseDetailCell *cell = [BaseDetailCell initWithTableView:tableView];
//    cell.model = _dataArray[indexPath.row];
//    
//    return cell;
//}
///**
// *  点击cell操作
// */
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    WebDetailView *webVIew = [[WebDetailView alloc]init];
//    NewsModel *model = _dataArray[indexPath.row];
//    webVIew.url = model.url;CATransition *transition = [CATransition animation];
//    transition.type = @"cube";
//    transition.subtype = kCATransitionFromRight;
//    [self.navigationControll pushViewController:webVIew animated: NO];
//    [self.navigationControll.view.layer addAnimation:transition forKey:nil];
//
//}
//#pragma mark -- 解析网页数据
//- (void)loadData:(NSString *)url isRemoveAll:(BOOL)isRemoveAll{
//    if (!_loadFirst) {
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        _loadFirst = 1;
//    }
//    [ZYTool sendGetWithUrl:url parameters:nil success:^(id data) {
//        _dataArray = [NSMutableArray arrayWithCapacity:0];
//        NSDictionary *dict = ZYJsonParserWithData(data);
//        NSDictionary *application = [dict objectForKey:@"data"];
//        //校验feed数据异常
//        NSString  *error = [dict objectForKey:@"message"];
//        if ([error isEqualToString:@"feed流异常"]) {
//            NSLog(@"网址解析错误：%@ ",error);
//            [self loadData:url isRemoveAll:isRemoveAll];
//            return ;
//        };
//        // 结束刷新
//        [_headView endRefreshing];
//        [_footView endRefreshing];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//        
//        [self analasysTopADData:application];
//        
//        //解析详情页数据
//        [self nanalasysDetailData:application];
//        //保存页面数据
//        [self saveModelArrayWithTableViewAdress];
//        [self.tableView reloadData];
//    } fail:^(NSError *error) {
//    }];
//}
//#pragma mark-- 解析顶部轮播广告数据
//- (void)analasysTopADData:(NSDictionary *)application{
//    _adModelArray = [NSMutableArray arrayWithCapacity:0];
//    NSDictionary *banner      = [application objectForKey:@"banner"];
//    NSArray      *newsArray   = [banner objectForKey:@"items"];
//    for(NSDictionary *newsDic in newsArray){
//        HeadADModel *model = [[HeadADModel alloc ] init];
//        [model setValuesForKeysWithDictionary:newsDic];
//        if ([model.stypename isEqualToString:@"广告"]) {
//            continue;
//        }
//        [_adModelArray addObject:model];
//    }
//    if (_adModelArray.count == 0) {
//        
//        return;
//    }else{
//        self.tableView.tableHeaderView = _scroView;
//    }
//
//    [HeadViewAD initWithScroView:self.scroView  andADModel:_adModelArray WithTarget:self WithAction:@selector(clickTopADView:)];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//}
//
//#pragma mark-- 解析详情数据
//- (void)nanalasysDetailData:(NSDictionary *)application{
//    NSArray *feedlist = [application objectForKey:@"feedlist"];
//    for (NSDictionary *dic in feedlist)
//    {
//        NSArray *newsArray = [dic objectForKey:@"items"];
//        for(NSDictionary *newsDic in newsArray){
//            NewsModel *model = [[NewsModel alloc] init];
//            [model setValuesForKeysWithDictionary:newsDic];
//            [_dataArray addObject:model];
//        }
//    }
//}
//#pragma mark -- 储存每个页面数据
//- (void)saveModelArrayWithTableViewAdress{
//    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
//    NSArray *adArr = [NSArray arrayWithArray:_adModelArray];
//    NSArray *dataArr = [NSArray arrayWithArray:_dataArray];
//    [dataDict setValue:adArr forKey:@"ADModelArray"];
//    [dataDict setValue:dataArr forKey:@"dataArray"];
//    [_informationDict setValue:dataDict forKey:@"information"];
//}
//
//
///**
// *  自动换页
// */
//- (void)nextPage
//{
//    if (_scroView.contentOffset.x < (_adModelArray.count-1) *375) {
//        [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x+375, 0) animated:YES];
//    }else{
//        [_scroView setContentOffset:CGPointMake( 0, 0) animated:NO];
//    }
//}
//
//- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
//    NSLog(@"刷新成功：MJ ");
//}
//
//
//#pragma mark - 点击顶部广告页面
//- (void)clickTopADView:(UIGestureRecognizer *)tap{
//    WebDetailView *webVIew = [[WebDetailView alloc]init];
//    HeadADModel *model = _adModelArray[tap.view.tag];
//    
//    webVIew.url = model.url;
//    
//    CATransition *transition = [CATransition animation];
//    transition.type = @"cube";
//    transition.subtype = kCATransitionFromRight;
//    //transition.duration = 1;
//    
//    
//    [self.navigationControll.view.layer addAnimation:transition forKey:nil];
//    [self.navigationControll pushViewController:webVIew animated:YES];
//    
//    
//    
//}
//#pragma mark 填充cell

@end
