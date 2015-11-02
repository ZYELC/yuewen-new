//
//  MoviViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/2.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "MoviViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MovieModel.h"

@interface MoviViewController ()
{
    MPMoviePlayerController *_moviePlayer;
}
@end

@implementation MoviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //检测是否有音乐播放 有的话停止
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    if (app.musicArr.count > 0) {
        [app.musicArr[0] stop];
        
        [app.musicArr removeAllObjects];
        
    }

    [self sound];
    [self creatBackButton];
}
- (void)creatBackButton{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 50 )];
    imageView.backgroundColor = [UIColor colorWithRed:50 / 255 green:60 / 255  blue:30 / 255  alpha:1 ];
    imageView.userInteractionEnabled = YES;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50 );
    [btn setImage:ZYOriginalImage(@"abc_ic_ab_back_mtrl_am_alpha") forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [imageView addSubview:btn];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, KWIDTH - 100, 50)];
    title.text = @"视频详情";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:title];
    [self.view addSubview:imageView];

}
-(void)btnClick:(UIButton *)sender
{
    
    [_moviePlayer stop ];
    [self dismissMoviePlayerViewControllerAnimated];
    [self.navigationController popViewControllerAnimated:YES];
    }
- (void)sound{
    NSString *url = @"http://wsqncdn.miaopai.com/stream/qnmzTQ2R3iKC3onH0S~Fkg__.mp4";
    if (_moviePlayer == nil) {
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_model.streamBase]];
    }else {
        [_moviePlayer setContentURL:[NSURL URLWithString:url]];
    }
    [_moviePlayer prepareToPlay];
    [self.view addSubview:_moviePlayer.view];//设置写在添加之后   // 这里是addSubView
    [_moviePlayer.view setFrame:CGRectMake(0, 71, KWIDTH, KHIGHT-72)];
    _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    _moviePlayer.shouldAutoplay = YES;
    _moviePlayer.repeatMode = MPMovieRepeatModeNone;
   // [_moviePlayer setFullscreen:YES animated:YES];
    //_moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
   // [_moviePlayer play ];
    if ([_moviePlayer isPreparedToPlay]) {
        //[_moviePlayer play ];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer]; //播放完后的通知
    
    [_moviePlayer stop];
}

    


-(void)movieFinishedCallback:(NSNotification*)notify{
    // 视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
    MPMoviePlayerController* theMovie = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:theMovie];
    [self dismissMoviePlayerViewControllerAnimated];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
@end
