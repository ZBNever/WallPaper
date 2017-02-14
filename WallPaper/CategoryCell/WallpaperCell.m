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

-(void)setWallpaper:(WallPaper *)wallpaper{

    [_image sd_setImageWithURL:wallpaper.thumbnail completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _image.alpha = 0;
        _image.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(.5, .5), drand48()-0.5);
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            
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
    _image.alpha = selected ? 0.5 : 1;
}
@end
