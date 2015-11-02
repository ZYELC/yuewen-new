//
//  ZYCommentTableViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/10.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYCommentTableViewController.h"
#import "AFNetworking.h"
#import "CommentModel.h"
#import "ZYCommentCell.h"
#import "CommentFrameModel.h"

@interface ZYCommentTableViewController ()
{
    NSMutableArray *_dataArray;
}
@end

@implementation ZYCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self loadData:_commenID];
    
}
- (void)loadData:(NSString *)url{
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    NSString *realUrl = [NSString stringWithFormat:@"http://interfacev5.vivame.cn/x1-interface-v5/json/commentlist.json?platform=android&installversion=5.6.0.1&channelno=MZSDA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=a3f8c2b8-6ff9-4965-a7c9-d8bd3865e63d&type=1&id=%@&pageindex=0&pagesize=40", url];
  //  NSLog(@"%@ ",realUrl);
    [ZYTool sendGetWithUrl:realUrl parameters:nil success:^(id data) {
        NSDictionary *dict = ZYJsonParserWithData(data);
        NSArray *dataArr = dict[@"data"];
        for (NSDictionary *dic in dataArr) {
            CommentModel *model = [[CommentModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:[CommentFrameModel commentFrameModelWithModel:model]];
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}
//http://interfacev5.vivame.cn/x1-interface-v5/json/commentlist.json?platform=android&installversion=5.6.6.3&channelno=MZSDA2320480100&mid=8c4bbef0e18cb39648129919639311e7&uid=9007775&sid=13fab674-07a9-4476-8eb8-59edf54674cb&type=1&id=7149575674715714612&commentType=1
#pragma mark - Table view data source


#pragma mark 组数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
#pragma mark 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYCommentCell *cell = [ZYCommentCell initWithTableView:tableView];
    cell.frameModel = _dataArray[indexPath.row];
    return cell;
}
#pragma mark 返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentFrameModel *model = _dataArray[indexPath.row];
    
    return model.rowHeight;
}
#pragma mark -- 当时图将要显示的时候 显示tabbar 和顶部状态栏
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark -- 当时图将要隐藏的时候 显示tabbar 和顶部状态栏
- (void)viewWillDisappear:(BOOL)animated{
    
   // self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

@end
