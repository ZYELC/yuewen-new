//
//  ZYSettingViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/9.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYSettingViewController.h"
#import "ZYNewsDBManager.h"

@interface ZYSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    
    UIImageView *_imagView;
}
@end

@implementation ZYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
}
#pragma mark 创建设置主界面
- (void)creatUI{
     _imagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHIGHT - 70)];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, KWIDTH, KHIGHT - 70)] ;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundView = _imagView;
    _imagView.image = [UIImage imageNamed:@"background_about.png"];
    [self.view addSubview:_imagView];
    
    [self.view addSubview:_tableView];
    [self prearData];
}
#pragma mark  准备数据
- (void)prearData{
    _dataArray = @[@"清除数据库",@"清除沙河数据",@"清除缓存"];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
#pragma marl -- cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark -- 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    if ([_dataArray[indexPath.row] isEqualToString:@"清除缓存"]){
        cell.detailTextLabel.text = [ZYTool getCacheSize];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_dataArray[indexPath.row] isEqualToString:@"清除缓存"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否清除缓存?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if ([_dataArray[indexPath.row] isEqualToString:@"清除沙河数据"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否删除沙河数据?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }else if ([_dataArray[indexPath.row] isEqualToString:@"清除数据库"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否清除数据库?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
   }

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex && [alertView.title  isEqual: @"是否清除缓存?"]) { // 点击了确定按钮
        [[SDImageCache sharedImageCache] clearDisk];
        ZYLog(@"清除成功:%@", [ZYTool getCacheSize]);
    }else if (1 == buttonIndex && [alertView.title  isEqual: @"是否删除沙河数据?"]){
         [[NSUserDefaults standardUserDefaults] removeObjectForKey:nil];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        ZYLog(@"清除沙河成功");
    }else if (1 == buttonIndex && [alertView.title  isEqual: @"是否清除数据库?"]){
        [ZYNewsDBManager deleteDataWithType:@"all"];
         ZYLog(@"清除数据库成功");
    }
    
    [_tableView reloadData];
}

#pragma mark --  当页面将要出现的时候调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    // 查询所有收藏数据
   // _dataArr = [[DBManager shareManager] selectAllData];
    
    // 刷新界面
  //  [self.tableView reloadData];
}

#pragma mark -- 页面消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
}


@end
