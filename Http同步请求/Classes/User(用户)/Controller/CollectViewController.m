//
//  CollectViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/5.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "CollectViewController.h"
#import "SoundWebDetailController.h"
#import "SoundModel.h"
#import "DBManager.h"
#import "NewsCell.h"

@interface CollectViewController ()
{
     NSArray     *_dataArr; // 数据库所有收藏应用的数组
    NSMutableDictionary *_deleteDic;
    
    UIBarButtonItem *_itemEdit;
    
}
@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _deleteDic = [[NSMutableDictionary alloc]init];
    //添加编辑按钮
    _itemEdit = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView:)];
    self.navigationItem.rightBarButtonItem = _itemEdit;

}

#pragma mark -- 点击编辑按钮执行方法
-(void)editTableView:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"编辑"]) {
        self.tableView.allowsMultipleSelection = YES;
        item.title = @"完成";
        [self.tableView  setEditing:!self.tableView.editing animated:YES];
    }else if([item.title isEqualToString:@"完成"]){
        item.title = @"编辑";
        [self.tableView  setEditing:!self.tableView.editing animated:YES];
        
    }else if([item.title isEqualToString:@"删除"]){
        //字典中所有value就是即将删除的数据，所有的key就是即将删除的indexpath
        for (SoundModel *model in _deleteDic.allValues) {
            NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:_dataArr];
            [sectionArray removeObject:model];
            _dataArr = sectionArray;
            [[DBManager shareManager] deleteDataWithAppID:[model userid]];
        }
        //删除对应的indexpath
        [self.tableView deleteRowsAtIndexPaths:_deleteDic.allKeys withRowAnimation:UITableViewRowAnimationAutomatic];
        //清楚即将删除的indexpath
        [_deleteDic removeAllObjects];
        item.title = @"完成";
    }
}

#pragma mark -- 返回tableVIew删除样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
#pragma marl -- cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NewsCell rowHeight];
}
#pragma mark -- 填充cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [NewsCell initWithTableView:tableView];
    cell.soundModel = _dataArr[indexPath.row];
    return cell;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //保存即将删除的indexpath
    if (tableView.editing) {
        _itemEdit.title = @"删除";
        //保存删除行的数据及对应的indexpath
        [_deleteDic setObject:_dataArr[indexPath.row] forKey:indexPath];
    }else{
        SoundWebDetailController *detailVC = [[SoundWebDetailController alloc] init];
        //detailVC.hasTabbar = NO;
        
        detailVC.userid = [_dataArr[indexPath.row] userid];
        detailVC.pic640 = [_dataArr[indexPath.row] pic_200];
        detailVC.url =  [_dataArr[indexPath.row] source];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
}
#pragma mark 反选方法
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%lu ",(unsigned long)_deleteDic.count);
    if (tableView.editing) {
        //        [_deleteArray removeObject:_dataArray[indexPath.row]];
        //移除
        [_deleteDic removeObjectForKey:indexPath];
    }
    if (!_deleteDic.count) {
        _itemEdit.title = @"完成";
    }
}

#pragma mark -- 点击了删除按钮(单选)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:_dataArr];
        [sectionArray removeObjectAtIndex:indexPath.row];
        _dataArr = sectionArray;
        NSArray *array = @[indexPath];
        [tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        [[DBManager shareManager] deleteDataWithAppID:[_dataArr[indexPath.row] userid]];
        // [tableView reloadData];
    }
}
#pragma mark -- 编辑删除按钮显示文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPat{
    return @"删除";
}

#pragma mark --  当页面将要出现的时候调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    // 查询所有收藏数据
    _dataArr = [[DBManager shareManager] selectAllData];
    
    // 刷新界面
    [self.tableView reloadData];
}

#pragma mark -- 页面消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
}
@end
