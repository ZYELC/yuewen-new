//
//  SoundSqureCell.h
//  Http同步请求
//
//  Created by qianfeng on 14/3/30.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SoundModel,MovieModel;
@interface SoundSqureCell : UICollectionViewCell
+ (instancetype)initWithColletionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) SoundModel * soundModel;
@property (nonatomic, strong) MovieModel * movieModel;
@end
