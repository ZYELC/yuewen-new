//
//  ViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/9.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "InforViewController.h"
#import "WebDetailView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NewsCell.h"
#import "HeadViewAD.h"
#import "NewsModel.h"
#import "HeadADModel.h"
#import "InformationTVC.h"
#import "CateView.h"

//顶部状态栏高度
#define KTopViewH 50
/**
 *  顶部按钮宽度
 */
#define KTopViewBtnW 65

@interface InforViewController ()<UIScrollViewDelegate,MainFtTableViewControllerDelegate>
{
    
    /**
     *  资讯界面
     */
    UIScrollView *_scroViewInformation;
    UIImageView *_imageView;
    
   // NSMutableArray *_dataArray;
    NSMutableArray *_ADModelArray;
    //资讯字典
    NSMutableDictionary *_informationDict;
    /**
     *  首选
     */
    MainFtTableViewController *_tableView;
    /**
     *  时事
     */
    CurrentTableViewController *_tableViewCurrent;
    /**
     *  娱乐
     */
    AmuseTableViewController *_tableViewAmuse;
    /**
     *  精读
     */
    IreadTableViewController *_tableViewIRead;
    /**
     *  美女
     */
    GirlTableViewController *_tableViewGirl;
    /**
     *  历史
     */
    HistoryTableViewController *_tableViewHistory;
    /**
     *  生活
     */
    lifeTableViewController *_tableViewlife;
    /**
     *  军事
     */
    ArmyTableViewController *_tableViewArmy;
    /**
     *  数码
     */
    DigitalTableViewController *_tableViewDigital;
    /**
     *  汽车
     */
    CarTableViewController *_tableViewCar;
    /**
     *  星座
     */
    StarTableViewController *_tableViewStar;
    /**
     *  热读
     */
    HotReadTableViewController *_tableViewHot;
    /**
     *  时尚
     */
    FashionTableViewController *_tableViewFashion;
    
    NSMutableArray *_tableViewArr;
    
    NSArray *_urlArray;
    
    NSTimer      *_timer;
    
    BOOL  _btnPress;
    
    
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView   *scroView;
@end

@implementation InforViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    _ADModelArray = [NSMutableArray array];
    _informationDict = [NSMutableDictionary dictionary];
    _tableViewArr = [NSMutableArray arrayWithCapacity:0];
    _urlArray = @[NEWFIRSTDSelect,NEWCurrent,NEWAmuse,NEWIRead,NEWGilr,NEWHistory,NEWLife,NEWArmy,NEWDigital,NEWCar,NEWStar,NEWHotRead,NEWFashion];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatFirstUI];
    [self creatUIScroView];
    [self creatUITopView2];

}
- (void)creatUITopView2
{
    NSArray *titleArray = @[@"首选",@"时事",@"娱乐",@"精读",@"美女",@"历史",@"生活",@"军事",@"数码",@"汽车",@"星座",@"热读",@"时尚"];
    
    [self creatUITopView:titleArray withTarget:self withAction:@selector(btnClick:)];
    self.topBtnScroView.contentSize = CGSizeMake( KTopViewBtnW * titleArray.count, KTopViewH);

    [self.topCateBtn addTarget:self action:@selector(btnCateClick) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  资讯界面视图
 */
- (void)creatUIScroView
{
    _scroViewInformation = [[UIScrollView alloc]initWithFrame:CGRectMake( 0, KTopViewH + 20, KWIDTH, KHIGHT - 120)];
    _scroViewInformation.backgroundColor = [UIColor blackColor];
    _scroViewInformation.pagingEnabled = YES;
    _scroViewInformation.delegate = self;
    _scroViewInformation.alwaysBounceVertical = NO;
    _scroViewInformation.bounces=NO;
    
    /**
      首选
     */
    //_tableView = [[MainFtTableViewController alloc] init];
    [_scroViewInformation addSubview:_tableView.tableView];
    
    [_tableViewArr addObject:_tableView];
    /**
     *  时事
     */
    _tableViewCurrent = [[CurrentTableViewController alloc] init];
    _tableViewCurrent.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewCurrent];
    
    _tableViewAmuse = [[AmuseTableViewController alloc] init];
    _tableViewAmuse.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewAmuse];
    
    _tableViewIRead = [[IreadTableViewController alloc] init];
    _tableViewIRead.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewIRead];
    
    _tableViewGirl = [[GirlTableViewController alloc] init];
    _tableViewGirl.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewGirl];
    
    _tableViewHistory = [[HistoryTableViewController alloc] init];
    _tableViewHistory.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewHistory];
    
    _tableViewlife = [[lifeTableViewController alloc] init];
    _tableViewlife.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewlife];
    
    _tableViewArmy = [[ArmyTableViewController alloc] init];
    _tableViewArmy.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewArmy];
    
    _tableViewDigital = [[DigitalTableViewController alloc] init];
    _tableViewDigital.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewDigital];
    
    _tableViewCar = [[CarTableViewController alloc] init];
    _tableViewCar.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewCar];
    
    _tableViewStar = [[StarTableViewController alloc] init];
    _tableViewStar.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewStar];
    
    _tableViewHot = [[HotReadTableViewController alloc] init];
    _tableViewHot.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewHot];
    
    _tableViewFashion = [[FashionTableViewController alloc] init];
    _tableViewFashion.navigationControll = self.navigationController;
    [_tableViewArr addObject:_tableViewFashion];
    
    for (int i = 0; i < _tableViewArr.count; i ++) {
        [_tableViewArr[i] tableView].frame = CGRectMake( (i)*KWIDTH, 0, KWIDTH, KHIGHT - 120);
        //[_tableViewArr[i] tableView].separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_scroViewInformation addSubview: [_tableViewArr[i] tableView]];
        
    }
    _scroViewInformation.contentSize = CGSizeMake( _tableViewArr.count * KWIDTH, 0);
    [self.view addSubview:_scroViewInformation];
}
#pragma mark

- (void)creatFirstUI
{
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[MainFtTableViewController alloc] init];
    _tableView.delegate = self;
    _tableView.navigationControll = self.navigationController;
    [_tableView loadData:NEWFIRSTDSelect isRemoveAll:YES];
    
}
#pragma mark scrollView代理方法-结束滚动
//结束滚动，一定要有滚动的减速过程，才会执行此协议方法，如果设置pageEnable为yes，一定会调此方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
    if ( ! [[NSString stringWithFormat:@"%@",[scrollView class]] isEqualToString:@"UITableView"]) {
        CGFloat scroOffset = scrollView.contentOffset.x;
        NSInteger num = ((NSInteger)scroOffset / KWIDTH);
        [self setTopBtnColor:num];
        
        [_tableViewArr[num] loadData:_urlArray[num] isRemoveAll:YES];
        
    }
}
#pragma mark -- 处理顶部按钮点击事件
-(void)btnClick:(UIButton *)sender
{
    [_tableViewArr[sender.tag] loadData:_urlArray[sender.tag] isRemoveAll:YES];
    _scroViewInformation.contentOffset = CGPointMake(sender.tag * KWIDTH, 0);
    [self setTopBtnColor:sender.tag];
    
}


#pragma mark --顶部分类按钮点击方法
- (void)btnCateClick{
    if (!_btnPress) {
      
        [CateView initCateView:self.view withTarget:self action:@selector(cateBtnClick:)];
        UIView *cateView =  [self.view viewWithTag:100];
        cateView.centerY = - KHIGHT / 2;
        [UIView animateWithDuration:0.5 animations:^{
            
            cateView.centerY = KHIGHT / 2 + 70;
        } completion:^(BOOL finished) {
            
        }];
        _btnPress = YES;
    }else{
        
        UIView *cateView =  [self.view viewWithTag:100];
        [UIView animateWithDuration:0.5 animations:^{
            cateView.centerY = - KWIDTH;
        } completion:^(BOOL finished) {
             [cateView removeFromSuperview];
        }];
         
       
        
        _btnPress = NO;
        
    }
}
#pragma mark 分类按钮点击事件
- (void)cateBtnClick:(UIButton *)sender
{
    [_tableViewArr[sender.tag] loadData:_urlArray[sender.tag] isRemoveAll:YES];
    _scroViewInformation.contentOffset = CGPointMake(sender.tag * KWIDTH, 0);
    [self setTopBtnColor:sender.tag];
    
    UIView *cateView =  [self.view viewWithTag:100];
    [cateView removeFromSuperview];
    _btnPress = NO;
}

#pragma mark -- 实现MainFtVC的代理
- (void)mainFtTableViewControllerCateBtnClick:(NSString *)stypeName{
     NSArray *titleArray = @[@"首选",@"时事",@"娱乐",@"精读",@"美女",@"历史",@"生活",@"军事",@"数码",@"汽车",@"星座",@"热读",@"时尚"];
    int i = 0;
    for (NSString *name in titleArray) {
        
        if ([stypeName isEqualToString:name]) {
            [_tableViewArr[i] loadData:_urlArray[i] isRemoveAll:YES];
            _scroViewInformation.contentOffset = CGPointMake(i * KWIDTH, 0);
            [self setTopBtnColor:i];
            return;

        }
        i ++;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
@end
