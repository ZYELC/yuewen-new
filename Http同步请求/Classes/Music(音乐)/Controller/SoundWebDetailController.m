//
//  SoundWebDetailController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/26.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "SoundWebDetailController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AudioPlayer.h"
#import "AudioStreamer.h"
#import "AudioButton.h"
#import "AFNetworking.h"
#import "UMSocial.h"
#import "DBManager.h"
#import "MCFireworksButton.h"

#import "ZYOpinionViewController.h"
#import "SongModel.h"
#import "AutherModel.h"
#import "ComentModel.h"
#import "ZYComentView.h"
#import "SoundModel.h"

@interface SoundWebDetailController ()<UMSocialUIDelegate,UIScrollViewDelegate>
{
    MPMoviePlayerController *_moviePlayer;
    UIImageView *_imagView;
    UIImageView  *_gifImgView;
    
    AudioPlayer *_playerStreamer;
    AudioStreamer *_streamer;
    
    NSString *_avatar;
    BOOL  _isLike;
    BOOL  _isBarrage;
    NSLock   *_lock;
    
    SongModel *_songModel;
    AutherModel *_autherModel;
    
    NSMutableArray *_comentArr;
    
    ZYComentView   *_comenTableView;
    
    UILabel * _infoLabel;
    
    NSTimer *_timer;
    
    NSMutableArray *_comentImageArr;
    
}

@property (weak, nonatomic) IBOutlet UILabel *songTime;
@property (weak, nonatomic) IBOutlet UIButton *comentImageBtn;
@property (weak, nonatomic) IBOutlet MCFireworksButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *loveBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *sayOut;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *authName;
@property (weak, nonatomic) IBOutlet UIButton *hearImageVIew;
@property (weak, nonatomic) IBOutlet UIView *reportVIew;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *comentImgArr;

@end

@implementation SoundWebDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = NO;
    self.title = @"乐闻";
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.collectBtn.particleImage = ZYImage(@"Sparkle");
    self.collectBtn.particleScale = 0.05;
    self.collectBtn.particleScaleRange = 0.02;
    
    _scrollView.delegate = self;
    _comentImageBtn.selected = YES;
    
    _comentImageArr = [NSMutableArray arrayWithCapacity:0];
        //创建UI界面
    [self creatComent];
    [self creatUI];
    [self loadData:nil];
    
    
    //开启弹幕
   // [self beginComentImgeAnimation];
    
}

- (void)creatUI{
    
    //初始化播放器
    //_playerStreamer = [[AudioPlayer alloc] init];
    AudioButton *audioButton = [[AudioButton alloc ] initWithFrame:CGRectMake(10, 250, 50, 50)];
    audioButton.imageEdgeInsets = UIEdgeInsetsMake(250, 10, 10, 340);
    [audioButton setImageEdgeInsets:UIEdgeInsetsMake(250, 10, 10, 340)];
    [audioButton addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    NSURL *urlRealStr = [NSURL URLWithString:_url];
    _playerStreamer.url = urlRealStr;
    
    
    //创建图片背景：背景来源 原歌曲图片
    [_bigImageView  setImageWithURL:[NSURL URLWithString:_pic640] placeholderImage:ZYImage(@"new_user_bird")];
    [_bigImageView addSubview:audioButton];
    
    [_scrollView insertSubview:_bigImageView atIndex:0];
  //  [_scrollView insertSubview:_reportVIew aboveSubview:_bigImageView];
    
    
    
    //创建评论
    _comenTableView = [[ZYComentView alloc] init];
    _comenTableView.tableView.frame = CGRectMake(0, _btnView.maxY + 20, KWIDTH, 400);
    _scrollView.contentSize = CGSizeMake(KWIDTH, _comenTableView.tableView.maxY);
    [_scrollView addSubview:_comenTableView.tableView];

    
    //把你的文章或者音乐的标识，作为@"identifier"
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:_url];
    _isLike = socialData.isLike;
    
    if (_isLike) {
        [_loveBtn setSelected:YES];
    }
    BOOL isExists = [[DBManager shareManager] selectOneDataWithAppID:_userid];
    if (isExists) {
        _collectBtn.selected = YES;
    }

}
#pragma mark -- 创建歌词显示页面
- (void)creatLrcUI{
    //创建 歌词显示页面
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY( _btnView.frame) + 5, KWIDTH, 100)];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.numberOfLines = 0;
    _infoLabel.text = _songModel.info;
    _infoLabel.backgroundColor = [UIColor whiteColor];
    _infoLabel.font = ZYFONT(10);
    [_infoLabel drawTextInRect:CGRectMake(10, 5, KWIDTH - 20, MAXFLOAT)];
    [_infoLabel addObserver:self forKeyPath:@"frame" options:0 context:nil];
    _infoLabel.textColor = [UIColor lightGrayColor ];
    
    //计算歌词的总长度
    CGFloat labelHeight = [ZYTool labelAutoCalculateRectWith:_info Font:ZYFont(14) MaxSize:CGSizeMake(_infoLabel.width, MAXFLOAT)].height;
    _infoLabel.height = labelHeight;
    [_scrollView addSubview:_infoLabel];
    
    
    //作者头像
    [_hearImageVIew.imageView setImageWithURL:[NSURL URLWithString:_autherModel.avatar_50] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
         [_hearImageVIew setImage:image forState: UIControlStateNormal];
        _hearImageVIew.layer.cornerRadius = 22.5;
        _hearImageVIew.clipsToBounds = YES;
    }];
    
    //作者名字
    _authName.text = _autherModel.name;
    
    //关注数
    _followLabel.text = _autherModel.followed_count;
    
    [_sayOut setTitle:_songModel.comment_count forState:UIControlStateNormal];
    
    [_collectBtn setTitle:_songModel.like_count forState:UIControlStateNormal];
    
    [_loveBtn setTitle:_songModel.download_count forState:UIControlStateNormal];
    
    [_shareBtn setTitle:_songModel.share_count forState:UIControlStateNormal];
    
    int min = [_songModel.length intValue] / 60;
    int mis = [_songModel.length intValue] % 60;
    _songTime.text = [NSString stringWithFormat:@"%d分%d秒",min,mis];
    
}
#pragma mark 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    _comenTableView.tableView.y = _infoLabel.maxY;
    _scrollView.contentSize = CGSizeMake(KWIDTH, _comenTableView.tableView.maxY);
}
#pragma mark 创建评论view
- (void)creatComent{
    
    NSString *url = [NSString stringWithFormat:@"http://echosystem.kibey.com/bullet/get?android_v=77&app_channel=kibey&limit=0&page=0&rand=0&sound_id=%@&t=1443433748644&time_part_no=1&type=1&v=9",_model.userid];
    
    [ZYTool sendGetWithUrl:url parameters:nil success:^(id data) {
        NSDictionary *backData = ZYJsonParserWithData(data);
        NSDictionary *result = backData[@"result"];
        _comentArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in result[@"data"]) {
            ComentModel *model = [[ComentModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            AutherModel *auModel = [[AutherModel alloc] init];
            [auModel setValuesForKeysWithDictionary:dict[@"user"]];
            model.autherModel = auModel;
            [_comentArr addObject:model];
        }
        _comenTableView.comentArr = _comentArr;
        [_comenTableView.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@ ",error);
    }];
}

#pragma mark -- 解析网页数据
- (void)loadData:(NSString *)url
{
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *Str = @"http://echosystem.kibey.com/sound/info?android_v=77&app_channel=kibey&sound_id=%@&t=1443433746726&v=9";
    NSString *urlStr = [NSString stringWithFormat:Str,_userid];
    
    NSLog(@"声音资源网址：%@ ",urlStr);
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *dict = responseObject;
         NSDictionary *result = dict[@"result"];
         NSDictionary *user = result[@"user"];
         _songModel = [[SongModel alloc] init];
         [_songModel setValuesForKeysWithDictionary:result];
         _autherModel = [[AutherModel alloc] init];
         [_autherModel setValuesForKeysWithDictionary:user];
         
         _info = result[@"info"];
         _avatar = user[@"avatar_50"];
         [self creatLrcUI];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}//http://app-echo.com/sound/info?sound_id=785609
#pragma mark -- 点击播放按钮事件
- (void)playAudio:(AudioButton *)button
{
    
    if (_playerStreamer == nil) {
        _playerStreamer = [[AudioPlayer alloc] init];
    }
    if ([_playerStreamer.button isEqual:button]) {
        [_playerStreamer play];
    } else {
        [_playerStreamer stop];
        _playerStreamer.button = button;
        _playerStreamer.url = [NSURL URLWithString:_url];
        [_playerStreamer play];
        
       
        //创建通知栏
        //  [self creatNotification];
        
        //储存播放对象
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        if (app.musicArr.count > 0) {
            [app.musicArr[0] stop];
            [app.musicArr removeAllObjects];
        }
        _streamer =  _playerStreamer.streamer;
        [app.musicArr addObject:_streamer];
    }
}
#pragma mark 开启弹幕
- (void)beginComentImgeAnimation{
    NSLog(@"开启弹幕%@ ",[NSDate date]);
    int key = arc4random()%(int)_comentArr.count;
//    UIView *view =  _comentImgArr[key];
    UIView *view = [self creatComentImage:_comentArr[key]];
    [_comentImageArr addObject:view];
    
    [_bigImageView   addSubview:view];
    if (view.layer.animationKeys.count) {
        return;
    }
    
    [view.layer removeAllAnimations];
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    
    // keyPath：可动画属性的字符串
    animation.keyPath = @"position";
    
    // 动画结束值
    int viewHeight = arc4random()%(int)(_bigImageView.height - 20);
    NSLog(@"%d ",viewHeight);
    view.y = viewHeight;
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(KWIDTH + view.width / 2 , viewHeight + 10, 0, 0)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(- KWIDTH / 2 , viewHeight + 10, 0, 0)];
    
    animation.fillMode = kCAFillModeBackwards;
    animation.delegate = self;
    // 动画时长
    animation.duration =  5;
    
    // 速度控制函数
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [view.layer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",key]];
    

}
#pragma mark 创建弹幕条
- (UIView *)creatComentImage:(ComentModel *)model{
    UIView *comentView = [[UIView alloc] initWithFrame:CGRectMake(KWIDTH, 0, 0, 25)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, comentView.height, comentView.height)];
    [imageView setImageWithURL:[NSURL URLWithString:model.autherModel.avatar_50]];
    imageView.layer.cornerRadius = 10;
    imageView.clipsToBounds = YES;
    [comentView addSubview:imageView];
    
  

    //获取弹幕条宽度
    CGFloat labelHeinght = [ZYTool labelAutoCalculateRectWith:model.content Font:ZYFont(12) MaxSize:CGSizeMake(MAXFLOAT, comentView.height)].width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.width, 0, labelHeinght, imageView.height)];
    label.text = model.content;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    [comentView addSubview:label];
    
    return comentView;
}
#pragma mark 弹幕条停止减速
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
   
    UIView *view = _comentImageArr[0];
    [view removeFromSuperview];
     [_comentImageArr removeObjectAtIndex:0];
//    Animation out = AnimationUtils.loadAnimation(MainActivity.this,R.anim.push_up_out);
//    Animation in = AnimationUtils.loadAnimation(MainActivity.this,R.anim.push_right_in); //对飞出的动画设置监听事件，当动画结束时，文字改变
    //重新开始跑马灯效果
    //    [self nextPage];
}

#pragma mark 创建通知栏推送
- (void)creatNotification{
    //本地消息推送
    //ios8的消息推送需要多添加一段代码
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        //消息类型
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        //消息设置类
        UIUserNotificationSettings *seiiings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        //应用程序注册消息
        [[UIApplication sharedApplication] registerUserNotificationSettings:seiiings];
    }
    //本地消息类
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10.0f];
    //消息开始时间
    localNoti.fireDate = date;
    //消息重复时间-- 一天
    //localNoti.repeatInterval = kCFCalendarUnitDay;
    
    //消息的内容
    localNoti.alertBody = @"正在播放音乐";
    
    //消息的声音
    //localNoti.soundName = @"pie.wav";
    
    //消息的角标
    //localNoti.applicationIconBadgeNumber = 10000;
    
    //应用程序定制本地消息
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
}
#pragma mark 点击分享按钮
- (IBAction)shareBtn:(UIButton *)sender {
    [sender setSelected:YES];
    [_shareBtn setHighlighted:YES];
    //音乐分享网页界面
    NSString *urlStr = [NSString stringWithFormat:@"http://app-echo.com/sound/info?sound_id=%@",_userid];

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5610aa0167e58e7bc1003e02"
                                      shareText:urlStr
                                     shareImage:_bigImageView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
                                       delegate:self];
}
#pragma mark - UMSocialUIDelegate
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark 点击了下载图片按钮
- (IBAction)downLoadImageBtnClick:(UIButton *)sender {
    
    [MBProgressHUD showSuccess:@"正在下载"];
    UIImageView *imageView = [[UIImageView alloc] init];
    [_lock lock];
    [imageView setImageWithURL:[NSURL URLWithString:_pic640] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        /**
         *  保存到相册
         *  1.要保存的图片
         *  2.回调对象
         *  3.回调方法
         */
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    [_lock unlock];
    [sender setSelected:YES];
}
#pragma mark 图片保存的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [MBProgressHUD showError:@"下载失败"];
    } else {
        [MBProgressHUD showSuccess:@"下载成功"];
    }
}
#pragma mark 点击了弹幕按钮
- (IBAction)barrageBtnClick:(UIButton *)sender {
    
    [sender setSelected:!sender.selected];
    if (!sender.selected) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(beginComentImgeAnimation) userInfo:nil repeats:YES];
        
    }else{
        [_timer invalidate];
    }
}
#pragma mark 点击了收藏按钮
- (IBAction)collectBtnClick:(UIButton *)sender {
    if (sender.selected) {
        [MBProgressHUD showSuccess:@"已取消"];
       [self.collectBtn popInsideWithDuration:0.4];
        sender.selected = NO;
        // 取消收藏: 删除数据
        [[DBManager shareManager] deleteDataWithAppID:_userid];
    }else{
        [self.collectBtn popOutsideWithDuration:0.5];
         [self.collectBtn animate];
        [MBProgressHUD showSuccess:@"收藏成功"];
        sender.selected = YES;
        // 收藏: 插入数据
        [[DBManager shareManager] insertDataWithDetailModel:_model];
        }

}
#pragma mark 点击了评论按钮
- (IBAction)commentBtnClick:(UIButton *)sender {
 
    [_scrollView setContentOffset:CGPointMake(0, _comenTableView.tableView.y - 80) animated:YES];
}
#pragma mark 点击了喜欢按钮
- (IBAction)LoveBtnClick:(UIButton *)sender {
    _isLike = !_isLike;
    [sender setSelected:_isLike];
    //把你的文章或者音乐的标识，作为@"identifier"
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:_url];
    UMSocialDataService *socialDataService = [[UMSocialDataService alloc] initWithUMSocialData:socialData];
     
            [socialDataService postAddLikeOrCancelWithCompletion:^(UMSocialResponseEntity *response){
            //获取请求结果
            NSLog(@"resposne is %@",response);
        }];
    
}

#pragma mark 点击了取消按钮
- (IBAction)cancelBtnClick:(id)sender {
    _reportVIew.hidden = YES;
}

#pragma mark 点击了举报按钮
- (IBAction)reportBtnClick:(id)sender {
    ZYOpinionViewController *reportVC = [[ZYOpinionViewController alloc] init];
    [self.navigationController pushViewController:reportVC animated:YES];
}
#pragma mark 点击了时间按钮
- (IBAction)timeBtnClick:(id)sender {
    _songTime.hidden = !_songTime.hidden;
}

#pragma mark 点击了更多按钮
- (IBAction)moreBtnClick:(id)sender {
    _reportVIew.hidden = !_reportVIew.hidden;
//    [_reportVIew bringSubviewToFront:_imagView];
}

#pragma marl 点击退出按钮
-(void)btnClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --程序返回主页面时显示隐藏navigationBar
- (void)viewWillDisappear:(BOOL)animated{
    [_timer invalidate];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)dealloc{
    [_infoLabel removeObserver:self forKeyPath:@"frame"];
}
#pragma mark -- 当时图将要显示的时候 显示tabbar 和顶部状态栏
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}


@end
