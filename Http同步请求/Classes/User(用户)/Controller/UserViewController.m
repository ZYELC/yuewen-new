//
//  UserViewController.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/22.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "UserViewController.h"
#import "CollectViewController.h"
#import "ZYSettingViewController.h"
#import "ZYHelpViewController.h"
#import "ZYOpinionViewController.h"
#import "WetherModel.h"

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *WetherPic;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempretureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDeraction;
@property (weak, nonatomic) IBOutlet UILabel *windPower;
@property (weak, nonatomic) IBOutlet UIImageView *weathBackroungPic;
@property (weak, nonatomic) IBOutlet UILabel *tempretureNight;
@property (weak, nonatomic) IBOutlet UILabel *weatherNight;
@property (weak, nonatomic) IBOutlet UILabel *windDeractionNight;
@property (weak, nonatomic) IBOutlet UILabel *windPowerNight;

@end

@implementation UserViewController
- (void)awakeFromNib{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
#pragma mark -- 点击了收藏按钮
- (IBAction)CollectBtnClick:(UIButton *)sender {
    CollectViewController *collectVC = [[CollectViewController alloc] init];
    [self.navigationController pushViewController:collectVC animated:YES];
}
#pragma mark 设置按钮点击
- (IBAction)settingBtnClick:(id)sender {
    ZYSettingViewController *settingVC = [[ZYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark 建议按钮点击
- (IBAction)opinionBtnClick:(id)sender {
    ZYOpinionViewController *opinionVC = [[ZYOpinionViewController alloc] init];
    [self.navigationController pushViewController:opinionVC animated:YES];
}
#pragma mark 帮助按钮点击
- (IBAction)helpBtnClick:(id)sender {
    ZYHelpViewController *settingVC = [[ZYHelpViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark 版本按钮点击
- (IBAction)vesionBtnClick:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前版本" message:@"1.0" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma mark 天气按钮点击
- (IBAction)picBtnClick:(id)sender {
    [MBProgressHUD showSuccess:@"正在加载天气数据..."];
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/weather_showapi/address";
    NSString *httpArg = @"area=%E5%8C%97%E4%BA%AC&areaid=101010100&needMoreDay=0&needIndex=0";
    [self request: httpUrl withHttpArg: httpArg];
    
   }
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"cce94e5cdbb264a36d957e58daf62781" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   
                                   NSDictionary *requestData = ZYJsonParserWithData(data);
                                   NSDictionary *requestBody = requestData[@"showapi_res_body"];
                                   WetherModel *model = [[WetherModel alloc] init];
                                   [model setValuesForKeysWithDictionary:requestBody[@"f1"]];
                                   
                                   _dateLabel.text = model.day;
                                   _tempretureLabel.text = [NSString stringWithFormat:@"%@℃",model.day_air_temperature] ;
                                   _weatherLabel.text = model.day_weather;
                                   [_WetherPic setImageWithURL:[NSURL URLWithString:model.day_weather_pic]];
                                   _windDeraction.text = model.day_wind_direction;
                                   _windPower.text = model.day_wind_power;
                                   
                                   _tempretureNight.text = [NSString stringWithFormat:@"%@℃",model.night_air_temperature];
                                   _weatherNight.text = model.night_weather;
                                   _windDeractionNight.text = model.night_wind_direction;
                                   _windPowerNight.text = model.night_wind_power;
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}


@end
