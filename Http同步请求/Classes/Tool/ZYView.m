////
////  ZYView.m
////  Http同步请求
////
////  Created by qianfeng on 14/10/11.
////  Copyright (c) 2014年 ZhangYing. All rights reserved.
////
//
//#import "ZYView.h"
//
//@implementation ZYView
//
//- (instancetype)initWithFrame:(CGRect)frame act:(NSInteger)act type:(NSInteger)type code:(NSInteger)code
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self createWithAct:act type:type code:code];
//    }
//    return self;
//}
//
//- (void)createWithAct:(NSInteger)act type:(NSInteger)type code:(NSInteger)code
//{
//    //先判断收藏还是下载
//    if (act == 1) {
//        //再判断时搜索里的数据还是菜单里的数据
//        if (type == 1) {
//            //判断数据库中是否存在
//            if (![[SearchManger shareInstance] isExits:code]) {
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_caipu_xiangqing_topbar_ico_fav"]];
//                imageView.frame = CGRectMake(10, 0, 24, 24);
//                imageView.tag = 50;
//                [self addSubview:imageView];
//                
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 44, 20)];
//                label.text = @"收藏";
//                label.textAlignment = NSTextAlignmentCenter;
//                label.font = [UIFont systemFontOfSize:11];
//                label.tag = 51;
//                [self addSubview:label];
//                
//                self.myState = 1;
//            }else{
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_caipu_xiangqing_topbar_ico_fav_active"]];
//                imageView.frame = CGRectMake(10, 0, 24, 24);
//                imageView.tag = 50;
//                [self addSubview:imageView];
//                
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 44, 20)];
//                label.text = @"已收藏";
//                label.textAlignment = NSTextAlignmentCenter;
//                label.font = [UIFont systemFontOfSize:11];
//                label.tag = 51;
//                [self addSubview:label];
//            }
//        }else{
//            if (![[MenuManager shareInstance] isExits:code]) {
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_caipu_xiangqing_topbar_ico_fav"]];
//                imageView.frame = CGRectMake(10, 0, 24, 24);
//                imageView.tag = 50;
//                [self addSubview:imageView];
//                
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 44, 20)];
//                label.text = @"收藏";
//                label.textAlignment = NSTextAlignmentCenter;
//                label.font = [UIFont systemFontOfSize:11];
//                label.tag = 51;
//                [self addSubview:label];
//                
//                self.myState = 1;
//            }else{
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_caipu_xiangqing_topbar_ico_fav_active"]];
//                imageView.frame = CGRectMake(10, 0, 24, 24);
//                imageView.tag = 50;
//                [self addSubview:imageView];
//                
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 44, 20)];
//                label.text = @"已收藏";
//                label.textAlignment = NSTextAlignmentCenter;
//                label.font = [UIFont systemFontOfSize:11];
//                label.tag = 51;
//                [self addSubview:label];
//            }
//            
//        }
//        
//    }else if(act == 2){
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_caipu_xiangqing_topbar_ico_offline"]];
//        imageView.frame = CGRectMake(10, 0, 24, 24);
//        imageView.tag = 52;
//        [self addSubview:imageView];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 44, 20)];
//        label.text = @"下载";
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:11];
//        label.tag = 53;
//        [self addSubview:label];
//    }else if(act == 3){
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"z_z_topbar_ico_share"]];
//        imageView.frame = CGRectMake(10, 0, 24, 24);
//        imageView.tag = 50;
//        [self addSubview:imageView];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 44, 20)];
//        label.text = @"分享";
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:11];
//        label.tag = 51;
//        [self addSubview:label];
//    }
//}
//
//@end
