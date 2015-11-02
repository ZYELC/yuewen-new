
//
//  FindViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "FindViewController.h"
#import "AFNetworking.h"
#import "BaseDetailCell.h"
#import "HeadViewAD.h"
#import "HeadADModel.h"
#import "BigDetailCell.h"
#import "SoundSqureCell.h"
#import "MoviViewController.h"
#import "MovieModel.h"
#import "TopicViewController.h"
#import "ZYMovieWebView.h"

//顶部状态栏高度
#define KTopViewH 50
@interface FindViewController ()<MJRefreshBaseViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    UICollectionView    *_collectionView;
    
    NSMutableDictionary *_informationDict;
    NSMutableArray      *_adModelArray;
    NSMutableArray      *_dataArray;
    NSTimer             *_timer;
    NSInteger           _pageNumber;
    NSInteger           _loadFirst;//判断首次加载
    MJRefreshHeaderView *_headView;
    MJRefreshFooterView *_footView;
}
@end

@implementation FindViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    
    [self creatUI];
    [self creatNavigation];
}
- (void)creatNavigation{
    NSArray *titleArray = @[@"热门"];
    [self creatUITopView:titleArray withTarget:self withAction:@selector(navigationBtnClick:)];
    self.topCateBtn.userInteractionEnabled = NO;
    self.topCateBtn.alpha = 1;
    [self.topCateBtn setBackgroundColor:ZYColor(23, 23, 23)];
    [self.topCateBtn setImage:nil forState:UIControlStateNormal];
}
# pragma mark 创建主界面
- (void)creatUI{
    _informationDict = [[NSMutableDictionary alloc] init];
    
    _scroView = [[UIScrollView alloc]init];
    _scroView.frame = CGRectMake(0, 0, KWIDTH, 200);
    _scroView.backgroundColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, KTopViewH + 20, KWIDTH, KHIGHT - 70 - 17) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"SoundSqureCell" bundle:nil] forCellWithReuseIdentifier:@"soundCell"];
    [self.view addSubview:_collectionView];
    
    // _tableView.tableHeaderView = _scroView;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _headView = [[MJRefreshHeaderView alloc] init];
    _footView = [[MJRefreshFooterView alloc] init];
    _headView.scrollView = _collectionView;
    _footView.scrollView = _collectionView;
    _headView.delegate = self;
    _footView.delegate = self;
    
    self.url = MoviHot;
    [self loadData:MoviHot removeAll:0];
    _pageNumber = 1;

}
#pragma mark tableview代理方法

#pragma mark 每组行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"%lu ",(unsigned long)_dataArray.count);
    return _dataArray.count;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KWIDTH - 30) / 2, (KWIDTH - 30) / 2 + 54);
}

#pragma mark 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 填充cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SoundSqureCell *cell = [SoundSqureCell initWithColletionView:collectionView andIndexPath:indexPath];
    cell.movieModel = _dataArray[indexPath.row];
    return cell;
}

#pragma mark 点击cell操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *model = [[MovieModel alloc] init];
    model = _dataArray[indexPath.row];
    if ([model.type isEqualToString:@"topic"]) {
        TopicViewController *topicVC = [[TopicViewController alloc] init];
        topicVC.model = model;
        [self.navigationController pushViewController:topicVC animated:NO];
    }else if([model.type isEqualToString:@"in_url"]){
        ZYMovieWebView *topicVC = [[ZYMovieWebView alloc] init];
        topicVC.url = model.in_url;
        [self.navigationController pushViewController:topicVC animated:NO];        
    }else{
        MoviViewController *moviVC = [[MoviViewController alloc]init];
        moviVC.model = model;
        [self.navigationController pushViewController:moviVC animated:NO];
    }
    
    
    CATransition *transition = [CATransition animation];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
}

#pragma mark -- 解析网页数据
- (void)loadData:(NSString *)url removeAll:(BOOL)isRemove{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = [NSString stringWithFormat:url,_pageNumber];
    if (!_loadFirst) {
        [MBProgressHUD showMessage:@"加载中..." toView:_collectionView];
        _loadFirst = 1;
    }
    NSLog(@"%@ ",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         [MBProgressHUD hideHUDForView:_collectionView animated:YES];
         // 结束刷新
         [_headView endRefreshing];
         [_footView endRefreshing];
         [_timer invalidate];
         _timer = nil;
         if (!isRemove) {
             _dataArray = [NSMutableArray arrayWithCapacity:0];
         }
         NSDictionary *dict = responseObject;
         NSDictionary *result = dict[@"result"];
         // [self analasysTopADData:application];
         
         //解析详情页数据
         [self nanalasysDetailData:result];
         //保存页面数据
         [self saveModelArrayWithTableViewAdress];
         [_collectionView reloadData];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         // 结束刷新
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
    [HeadViewAD initWithScroView:self.scroView  andADModel:_adModelArray WithTarget:self WithAction:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

#pragma mark-- 解析详情数据
- (void)nanalasysDetailData:(NSDictionary *)application{
    
    for (NSDictionary *dic in application)
    {
        MovieModel *model = [[MovieModel alloc] init];
        [model initWithDict:dic];
        [_dataArray addObject:model];
    }
    [_dataArray removeObjectAtIndex:0];
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
    
    NSLog(@"刷新成功:MJ ");
}

#pragma mark 顶部状态栏按钮点击事件
- (void)navigationBtnClick:(UIButton *)send{
    
}


@end
