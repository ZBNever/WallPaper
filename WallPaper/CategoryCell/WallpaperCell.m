//
//  WallpaperCell.m
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "WallpaperCell.h"
#import "WallPaper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PixabayModel.h"

@implementation WallpaperCell{
    UIImageView *_image;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _image = [[UIImageView alloc] init];
        _image.contentMode = UIViewContentModeScaleAspectFill;
        _image.clipsToBounds = YES;
        [self.contentView addSubview:_image];
    }
    return self;
}


- (void)setPixabayModel:(PixabayModel *)model{
    [_image sd_setImageWithURL:model.webformatURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self->_image.alpha = 0;
        //旋转
        //      _image.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(.5, .5), drand48()-0.5);
        //缩放
        self->_image.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            
            self->_image.transform = CGAffineTransformIdentity;
            self->_image.alpha = 1;
            
        } completion:nil];
        
    }];
}

-(void)setWallpaper:(WallPaper *)wallpaper{

    [_image sd_setImageWithURL:wallpaper.thumbnail completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _image.alpha = 0;
        //旋转
//      _image.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(.5, .5), drand48()-0.5);
        //缩放
        _image.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            
            _image.transform = CGAffineTransformIdentity;
            _image.alpha = 1;
            
        } completion:nil];
        
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _image.frame = self.contentView.bounds;
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
//    _image.alpha = selected ? 0.5 : 1;
}
@end
