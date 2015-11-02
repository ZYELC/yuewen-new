//
//  MainFtTableViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/17.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MainFtTableViewController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "HeadViewAD.h"
#import "WebDetailView.h"
#import "BigCell.h"
#import "ButtonCell.h"
#import "HotCell.h"
#import "HeadADModel.h"
#import "NoImgCell.h"
#import "ZYNewsDBManager.h"

#define TBViewP [NSString stringWithFormat:@"%p",self.tableView]
@interface MainFtTableViewController ()<MJRefreshBaseViewDelegate>
{
    NSMutableDictionary *_informationDict;
    NSArray             *_adModelArray;
    NSArray             *_dataArray;
    NSTimer             *_timer;
    NSInteger           _loadFirst;
    NSInteger           _loadDBFirst;
    MJRefreshHeaderView *_headView;
    
    UIView              *_topView;
    
    BOOL                _moreBtnClick;
    
    NSInteger           _currentSection;
}
@end

@implementation MainFtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    _informationDict = [[NSMutableDictionary alloc] init];
    
    _topView = [[UIView alloc] init];
    _scroView = [[UIScrollView alloc]init];
    _scroView.frame = CGRectMake(0, 0, 375, 200);
    _scroView.delegate = self;
    _scroView.backgroundColor = [UIColor whiteColor];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, 0, KWIDTH, KHIGHT - 140) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentMode = UIViewContentModeCenter;
    
    
    
    _headView = [[MJRefreshHeaderView alloc] init];
    _headView.scrollView = self.tableView;
    _headView.delegate = self;

}
#pragma mark tableview代理方法
#pragma mark -- 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
#pragma mark tableView每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    if (_moreBtnClick) {
        if (section == _currentSection) {
            NSInteger  count = (int)[_dataArray[section] count] + 1;
            //        NSLog(@"%lu ",[_dataArray[section] count] + 1);
            //        NSLog(@"%ld ",(long)section);
            
            return  count;
        }else
            return 3;
       
            }
   return 3;
   
    
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       return  [HotCell rowHeight];
    }
    else {
        NSInteger count = [_dataArray[indexPath.section] count];
        NewsModel *model = [[NewsModel alloc] init];
        if (count == indexPath.row) {//当是最后一个button时取前一个model
            model = _dataArray[indexPath.section][indexPath.row - 1];
             return [ButtonCell rowHeight];
        }else{
            model = _dataArray[indexPath.section][indexPath.row];
        }
        if (indexPath.row == 0) {//第一个cell大图
                if (model.img.length > 0) {//判断第一个cell是否有图片
                    return [BigCell rowHeight];}
                else{
                    return [NewsCell rowHeight];}
        }else{
            return [NewsCell rowHeight]; }
    }
    return 0;
}
#pragma mark 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger count = [_dataArray[indexPath.section] count];
    NewsModel *model = [[NewsModel alloc] init];
//    if (count == indexPath.row) {//当是最后一个button时取前一个model
//        model = _dataArray[indexPath.section][indexPath.row - 1];
//    }else{
//        model = _dataArray[indexPath.section][indexPath.row];
//    }
    
    if (2 == indexPath.row) {//当是最后一个button时取前一个model
        model = _dataArray[indexPath.section][indexPath.row - 1];
    }else{
        model = _dataArray[indexPath.section][indexPath.row];
    }
    UITableViewCell *cell = nil;
    
    if (_moreBtnClick) {
        if (indexPath.section == 0) {//hot  cell
            cell = [HotCell initWithTableView:tableView];
            ((HotCell *)cell).model = model;
            
        }else{
            if (indexPath.row == 0) {
                //判断第一个cell是否含有图片地址
                if (model.img.length > 0) {
                    cell = [BigCell initWithTableView:tableView];
                    ((BigCell *)cell).model = model;
                }else{
                    cell = [NewsCell initWithTableView:tableView];
                    ((NewsCell *)cell).model = model;
                }
                //判断是否为最后一个cell
            }else if(count == indexPath.row ){
                cell = [ButtonCell initWithTableView:tableView];
                ((ButtonCell *)cell).model = model;
            }else{//加载基本cell
                cell = [NewsCell initWithTableView:tableView];
                ((NewsCell *)cell).model = model;
            }
        }

    }else{
    
    
    if (indexPath.section == 0) {//hot  cell
        cell = [HotCell initWithTableView:tableView];
        ((HotCell *)cell).model = model;
        
    }else{
        if (indexPath.row == 0) {
            //判断第一个cell是否含有图片地址
            if (model.img.length > 0) {
                cell = [BigCell initWithTableView:tableView];
                ((BigCell *)cell).model = model;
            }else{
                cell = [NewsCell initWithTableView:tableView];
                ((NewsCell *)cell).model = model;
            }
            //判断是否为最后一个cell
        }else if(2 == indexPath.row ){
            cell = [ButtonCell initWithTableView:tableView];
            ((ButtonCell *)cell).model = model;
        }else{//加载基本cell
            cell = [NewsCell initWithTableView:tableView];
            ((NewsCell *)cell).model = model;
        }
        }
    }
    return cell;
}
#pragma mark -- 填充组标题(只有文字)
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    NewsModel *model = [[NewsModel alloc] init];
    model = _dataArray[section][0];
    NSString *str=[NSString stringWithFormat:@">>%@",model.stypename];
    return str;
}
#pragma mark -- 填充组标题（UIView）
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 60)];
    view.backgroundColor = [UIColor cyanColor];
    return nil;
}
#pragma mark -- 每组头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark -- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        _currentSection = indexPath.section;
        _moreBtnClick = 1;
        NSIndexSet *indes = [NSIndexSet indexSetWithIndex:indexPath.section];
        [self.tableView reloadSections:indes withRowAnimation:UITableViewRowAnimationBottom];
        _moreBtnClick = 0;
        return;
        
    }

    NewsModel *model = [[NewsModel alloc] init];
    if (indexPath.row == [_dataArray[indexPath.section] count]) {
        model = _dataArray[indexPath.section][indexPath.row - 1];
        [_delegate mainFtTableViewControllerCateBtnClick:model.stypename];
        return;
    }
    
    if (indexPath.row == 2) {
        _moreBtnClick = 1;
        NSIndexSet *indes = [NSIndexSet indexSetWithIndex:indexPath.section];
        [self.tableView reloadSections:indes withRowAnimation:UITableViewRowAnimationAutomatic];
        _moreBtnClick = 0;
        
    }
    model = _dataArray[indexPath.section][indexPath.row];
    WebDetailView *webVIew = [[WebDetailView alloc]init];
    webVIew.url = model.url;
    webVIew.model = model;
    //添加转场动画
    [self.navigationControll.view setTransitionAnimationType:PSBTransitionAnimationTypeMoveIn toward:PSBTransitionAnimationTowardFromRight duration:0.3];
    [self.navigationControll pushViewController:webVIew animated:YES];

    
}
#pragma mark -- 解析网页数据
- (void)loadData:(NSString *)url isRemoveAll:(BOOL)isRemoveAll{
    NEWTool *tool = [[NEWTool alloc] init];
    if (!_loadFirst) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _loadFirst = 1;
   
       [tool loadFirstViewData:url tableView:self.tableView isRemoveAll:(BOOL)isRemoveAll informationDict:_informationDict isFirstLoad:_loadDBFirst succes:^(id data) {
           _loadDBFirst = 1;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
       
       // 结束刷新
       [_headView endRefreshing];
        _informationDict = data;        
        NSDictionary *dataDict = [_informationDict objectForKey:TBViewP];
        _adModelArray = dataDict[@"ADModelArray"];
        _dataArray = dataDict[@"dataArray"];
#warning 每次从数据库加载后还要删除再加载一遍 够了。。
           
        //缓存
        [ZYNewsDBManager  deleteDataWithType:@"-1"];
        [ZYNewsDBManager  deleteDataWithType:@"-1AD"];
        [ZYNewsDBManager addMainStatuses:_dataArray];
        [ZYNewsDBManager addADStatuses:_adModelArray];
        
#warning 高逼格轮播图  还没做好😄
//        [HeadViewAD initWithScroView:_adModelArray view:_topView WithTarget:nil WithAction:nil];
          // _topView.frame = CGRectMake(0, 0, _adModelArray.count * KWIDTH, 200);
           self.tableView.tableHeaderView = _scroView;
         //  NSLog(@"%@ ",NSStringFromCGRect(_topView.frame ));
           
        [HeadViewAD initWithScroView:self.scroView  andADModel:_adModelArray WithTarget:self WithAction:@selector(clickTopADView:)];
//           [self nextPage];
         _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [self.tableView reloadData];
    }];
    }else{
        return;
    }
}
#pragma mark -- 自动换页
- (void)nextPage
{
#warning 这咋办 刷新 怎么删除原来正在进行的动画！！！！
//    [_topView.layer removeAllAnimations];
//    /** 基础动画
//     CAPropertyAnimation 是一个抽象类,不可以有具体实例.
//     CABasicAnimation 实现了 CAPropertyAnimation
//     */
//    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
//    
//    // keyPath：可动画属性的字符串
//    animation.keyPath = @"position";
//    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(KWIDTH / 2, 101, 0, 0)];
//        // 动画结束值
//    animation.toValue = [NSValue valueWithCGRect:CGRectMake(- (int)_adModelArray.count * KWIDTH + KWIDTH/2, 100, 0, 0)];
//   // NSLog(@"%@ ",animation.toValue);
//    // 动画填充模式
//    // kCAFillModeBackwards,动画一加入就进入动画的初始状态,动画结束后,位置还原
//    // kCAFillModeForwards,动画一加入并不会进入动画的初始状态,动画结束后,保持最新
//    // kCAFillModeBoth 动画一加入就进入动画的初始状态, 动画结束后,保持最新
//    animation.fillMode = kCAFillModeBackwards;
//    
//    animation.delegate = self;
//    // 动画时长
//    animation.duration = _adModelArray.count * 5;
//    
//    //animation.repeatCount = 10;
//    
//    // 速度控制函数
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    [_topView.layer addAnimation:animation forKey:nil];
    
    // 设置动画延时
//    animation.beginTime = CACurrentMediaTime() + 5;

    if (_adModelArray.count == 1) {
    return;
    }
    if (_scroView.contentOffset.x == _adModelArray.count * KWIDTH) {
        [_scroView setContentOffset:CGPointMake( 0, 0) animated:NO];
    }
    
    if (_scroView.contentOffset.x < (_adModelArray.count-1) * KWIDTH) {
//        [_scroView.layer addAnimation:animation forKey:nil];
        [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x + KWIDTH, 0) animated:YES];
        
    }else{       
        [ UIView animateWithDuration:0.1 animations:^{
             [_scroView setContentOffset:CGPointMake(_scroView.contentOffset.x + KWIDTH, 0) animated:YES];
        } ];
    }
//    NSLog(@"%f %f ",_scroView.contentOffset.x,_scroView.contentOffset.y);
}
#pragma mark - 点击顶部广告页面
- (void)clickTopADView:(UIGestureRecognizer *)tap{
    WebDetailView *webVIew = [[WebDetailView alloc]init];
    HeadADModel *model = _adModelArray[tap.view.tag];
    webVIew.url = model.url;
    
    //添加转场动画
    [self.navigationControll.view setTransitionAnimationType:PSBTransitionAnimationTypeMoveIn toward:PSBTransitionAnimationTowardFromRight duration:0.3];
    [self.navigationControll pushViewController:webVIew animated:YES];
    
}
#pragma mark --开始移动scrollView是代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == _scroView) {
        //停止定时器
        [_timer invalidate];
    }
}
#pragma mark -- 移动scrollView完毕代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _scroView) {
         _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
   
}
#pragma mark  刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    _loadFirst = 0;
    [self loadData:NEWFIRSTDSelect isRemoveAll:YES];
    
    NSLog(@"时事刷新成功:MJ ");
}
#pragma mark 停止减速
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
#warning 刷新后重复调用减速代理 奥多ki
        //重新开始跑马灯效果
    [self nextPage];
}
@end
