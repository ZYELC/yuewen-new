//
//  ChanelViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/5.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ChanelViewController.h"
#import "AFNetworking.h"
#import "BaseDetailCell.h"
#import "HeadViewAD.h"
#import "HeadADModel.h"
#import "SoundModel.h"
#import "BigDetailCell.h"
#import "SoundWebDetailController.h"
#import "SoundSqureCell.h"

@interface ChanelViewController ()<MJRefreshBaseViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
    UICollectionView    *_collectionView;
    UITableView         *_tableView;
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

@implementation ChanelViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _informationDict = [[NSMutableDictionary alloc] init];
    
    _scroView = [[UIScrollView alloc]init];
    _scroView.frame = CGRectMake(0, 0, 375, 200);
    _scroView.backgroundColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, 0, KWIDTH, KHIGHT - 70 - 47) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"id"];
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
    
    self.url = SDChannel;
    [self loadData:SDChannel removeAll:0];
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
    return CGSizeMake((KWIDTH - 30) / 2, (KWIDTH - 30) / 2 - 60);
}

#pragma mark 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 填充cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"id";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    SoundModel *model = _dataArray[indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.backgroundView.frame ];
    
    [imageView setImageWithURL:[NSURL URLWithString:model.pic_200] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    }];
    
    //添加标题背景颜色以及背景view
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake( 0, (KWIDTH - 30) / 2 - 60 - 30, (KWIDTH - 30) / 2, 30)];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.5;
    [imageView addSubview:baseView];
    
    //添加标题
    UILabel *label = [[UILabel alloc]initWithFrame:baseView.frame];
    label.text =model.name;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    [imageView addSubview:label];
    cell.backgroundView = imageView;
    
    return cell;
}

#pragma mark 点击cell操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SoundWebDetailController *soundVIew = [[SoundWebDetailController alloc]init];
    SoundModel *model = _dataArray[indexPath.row];
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
    NSString *urlStr = [NSString stringWithFormat:url,_pageNumber];
    
    //判断首次加载
    if (!_loadFirst) {
        [MBProgressHUD showMessage:@"加载中..." toView:self.view];
        _loadFirst = 1;
    }
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
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
         NSDictionary *application = [result objectForKey:@"data"];
         
         //解析详情页数据
         [self nanalasysDetailData:application];
         [_collectionView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
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
    
    //添加轮播栏
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
        NSDictionary *sound = [dic[@"sound"] firstObject];
        model.source = sound[@"source"];
        model.pic_640 = sound[@"pic_640"];
        [_dataArray addObject:model];
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
    NSLog(@"加载成功:MJ ");
}

@end
