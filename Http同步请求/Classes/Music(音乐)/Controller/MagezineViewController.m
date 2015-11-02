
//
//  MagezineViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MagezineViewController.h"
#import "AFNetworking.h"
#import "BaseDetailCell.h"
#import "HeadViewAD.h"
#import "HeadADModel.h"
#import "SoundModel.h"
#import "BigDetailCell.h"
#import "SoundWebDetailController.h"
#import "SoundSqureCell.h"
#import "ImageChangeScrollView.h"
#import "MusicHeardView.h"
/**
 *  底部工具栏高度
 */
#define BotoomBarH 50.0f
/**
 *  顶部工具栏高度
 */
#define topBarH    70.0f
/**
 *  cell间距
 */
#define Margin     10.0f
/**
 *  顶部轮播栏高度
 */
#define TopScrollH  200.0f

@interface MagezineViewController ()<MJRefreshBaseViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
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
    NSMutableArray      *_imageArr;
    NSMutableArray      *_titleArr;
    
    UIScrollView        *_scorollView;
}
@end

@implementation MagezineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _informationDict = [[NSMutableDictionary alloc] init];
    
    //加载轮播数据
    [self loadScrollViewData:@"http://echosystem.kibey.com/index/banner?android_v=77&app_channel=kibey&position=0&t=1443432658084&v=9"];
    
    [self creatUI];
    self.url = SDmain;
    //加载主数据
    [self loadData:SDmain removeAll:0];
    _pageNumber = 1;
}
- (void)creatUI{
    self.scroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHIGHT - topBarH - BotoomBarH)];
    self.scroView.contentSize = CGSizeMake(KWIDTH, _collectionView.contentSize.height);
    [self.view addSubview:self.scroView];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //初始化collectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake( 0, 0, KWIDTH, KHIGHT - topBarH - BotoomBarH)collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"SoundSqureCell" bundle:nil] forCellWithReuseIdentifier:@"soundCell"];
    
    //注册头部视图
    [_collectionView registerClass:[MusicHeardView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[MusicHeardView identifier]];
    [self.scroView addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //初始化刷新视图
    _headView = [[MJRefreshHeaderView alloc] init];
    _footView = [[MJRefreshFooterView alloc] init];
    _headView.scrollView = _collectionView;
    _footView.scrollView = _collectionView;
    _headView.delegate = self;
    _footView.delegate = self;

   // [_collectionView addObserver:self forKeyPath:@"contentSize" options:0 context:nil];
}
#pragma mark - KVO监听colletionView的高度的改变而改变scrollView的frame
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.scroView.contentSize = CGSizeMake(KWIDTH, _collectionView.contentSize.height);
    _collectionView.height = _collectionView.contentSize.height;
}
#pragma mark -创建广告栏
- (void)creatScorllView{

    
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
    return UIEdgeInsetsMake(Margin, Margin, Margin, Margin);
}

#pragma mark 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{   //返回自定义CollectionCell的大小（宽度减去间距 除以二， 加上titleLabel的高度54）
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
    cell.soundModel = _dataArray[indexPath.row];
    
    return cell;
}

#pragma mark 点击cell操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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

#pragma mark - 解析广告轮播栏数据
- (void)loadScrollViewData:(NSString *)url {
    
    _imageArr = [NSMutableArray arrayWithCapacity:0];
    _titleArr = [NSMutableArray arrayWithCapacity:0];
    _adModelArray = [NSMutableArray arrayWithCapacity:0];
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *result = dict[@"result"];
        for (NSDictionary *dict in result) {
            [_imageArr addObject:dict[@"pic"]];
            [_titleArr addObject:dict[@"sound"][@"name"]];
            SoundModel *model = [[SoundModel alloc] init];
            [model setValuesForKeysWithDictionary:dict[@"sound"]];
            model.pic_640 = dict[@"pic"];
            [_adModelArray addObject:model];
        }
        [_imageArr removeObjectAtIndex:0];
        [_titleArr removeObjectAtIndex:0];
        [_adModelArray removeObjectAtIndex:0];
        [_collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZYLog(@"%@",error);
    }];
}

#pragma mark -- 解析网页数据
- (void)loadData:(NSString *)url removeAll:(BOOL)isRemove{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];    
    NSString *urlStr = [NSString stringWithFormat:url,_pageNumber];
    if (!_loadFirst) {
        [MBProgressHUD showMessage:@"加载中..." toView:self.view];
        _loadFirst = 1;//判断第一次加载
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
        // [self analasysTopADData:application];
        
        //解析详情页数据
        [self nanalasysDetailData:application];
        //保存页面数据
        [self saveModelArrayWithTableViewAdress];
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        // 结束刷新
        [_headView endRefreshing];
        [_footView endRefreshing];
        NSLog(@"%@ ",error);
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
    
    for (NSDictionary *dic in application){
            SoundModel *model = [[SoundModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
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


#pragma mark 自动换页
- (void)nextPage
{
    if (_scroView.contentOffset.x < (_adModelArray.count - 1) * KWIDTH) {
        [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x + KWIDTH, 0) animated:YES];
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
#pragma mark --顶部视图创建
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MusicHeardView *myView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[MusicHeardView identifier] forIndexPath:indexPath];
    //如果myVIew为空，collectionView会根据注册的类自动创建myView
    //如果是头部视图
    if (kind == UICollectionElementKindSectionHeader) {
        //创建图片轮播器
        [myView initWithImage:_imageArr andTitle:_titleArr andFrame:CGRectMake(0, 0, KWIDTH, TopScrollH)andTarget:self andAction:@selector(topImageClick:)];
//        [self nextPage];

    }else{//尾部视图
        
    }    
    return myView;
}
#pragma mark - 点击顶部广告页面
- (void)topImageClick:(UIGestureRecognizer *)tap{
    SoundWebDetailController *soundVIew = [[SoundWebDetailController alloc]init];
    SoundModel *model = _adModelArray[tap.view.tag];
    
    soundVIew.model = model;
    soundVIew.url = model.source;
    soundVIew.pic640 = model.pic_640;
    soundVIew.info = model.info;
    soundVIew.userid = model.userid;
    
    //添加转场动画
    [self.navigationControll.view setTransitionAnimationType:PSBTransitionAnimationTypeMoveIn toward:PSBTransitionAnimationTowardFromRight duration:0.3];
    [self.navigationControll pushViewController:soundVIew animated:YES];
    
}

#pragma mark 头部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KWIDTH, TopScrollH);
}

@end
