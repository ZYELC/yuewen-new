//
//  SoundSqureCell.m
//  Http同步请求
//
//  Created by qianfeng on 14/3/30.
//  Copyright © 2014年 zhangying. All rights reserved.
//

#import "SoundSqureCell.h"
#import "SoundModel.h"
#import "MovieModel.h"
@interface SoundSqureCell()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *musicChannel;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UIImageView *musicPhoto;
@end

@implementation SoundSqureCell
+ (instancetype)initWithColletionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID2 = @"soundCell";
    
    SoundSqureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID2 forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SoundSqureCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
- (void)setSoundModel:(SoundModel *)soundModel{
    //歌曲pic
    [_musicPhoto setImageWithURL:[NSURL URLWithString:soundModel.pic_200]];
//    NSLog(@"%@",NSStringFromCGSize(_musicPhoto.size));
    //频道名字
    _musicChannel.text = soundModel.channelName;
    
    //音乐名称
    _musicName.text = soundModel.name;
}

//视频页面赋值
- (void)setMovieModel:(MovieModel *)movieModel{
    if (movieModel.picBase.length == 0) {
        [_musicPhoto setImageWithURL:[NSURL URLWithString:movieModel.img]];
    }else{    
    //拼接视频图片地址
    NSString *moviUrl = [NSString stringWithFormat:@"%@%@",movieModel.picBase,movieModel.pic_m];
    [_musicPhoto setImageWithURL:[NSURL URLWithString:moviUrl]];
    }
    _musicName.text = movieModel.name;
    _musicChannel.text = movieModel.lengthNice;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
