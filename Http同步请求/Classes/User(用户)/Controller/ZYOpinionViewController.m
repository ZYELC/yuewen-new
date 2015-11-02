//
//  ZYOpinionViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/10/13.
//  Copyright (c) 2014年 ZhangYing. All rights reserved.
//

#import "ZYOpinionViewController.h"

@interface ZYOpinionViewController ()<UITextFieldDelegate>
{
    UITextField *_textFiled;
    
    UIButton    *_sendBtn;
    
    UIImageView *_imagView;
}
@end

@implementation ZYOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"建议";
    
    _imagView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imagView.image = ZYImage(@"background_about");
    [self.view addSubview:_imagView];
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, KWIDTH - 60, 100)];
    _textFiled.delegate = self;
    _textFiled.borderStyle = UITextBorderStyleRoundedRect;
    _textFiled.placeholder = @"请输入您的建议";
    
    //添加监听文字输入改变
    [ [NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:_textFiled];
    [self.view addSubview:_textFiled];
    
    //发送按钮
    _sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _sendBtn.frame = CGRectMake(130, CGRectGetMaxY(_textFiled.frame) + 50, 100, 50);
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sendBtn setBackgroundImage:ZYImage(@"plugin_camera_send_pressed") forState:UIControlStateSelected];
    [_sendBtn setBackgroundImage:ZYImage(@"plugin_camera_preview_unselected") forState:UIControlStateNormal];
    _sendBtn.alpha = 0.5;
    _sendBtn.enabled = NO;
    [self.view addSubview:_sendBtn];
}
#pragma mark  --发送按钮点击
-(void)btnClick:(UIButton *)sender
{
    [MBProgressHUD showSuccess:@"建议已发送"];
    [_textFiled resignFirstResponder];
    _textFiled.text = nil ;
    _sendBtn.enabled = NO;
}
#pragma mark 文字改变执行方法
-(void)textChange
{
   
    _sendBtn.enabled = _textFiled.text.length > 0;
   
    if (_sendBtn.enabled) {
         _sendBtn.alpha = 0.9;
        [_sendBtn setSelected:YES];
    }else{
        _sendBtn.alpha = 0.5;
    }
}
#pragma mark 触摸屏幕键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textFiled endEditing:YES];
}
#pragma mark --  当页面将要出现的时候调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- 页面消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
}
@end
