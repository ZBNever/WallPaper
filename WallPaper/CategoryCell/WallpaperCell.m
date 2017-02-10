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

    [_image sd_setImageWithURL:wallpaper.thumbnail];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _image.frame = self.contentView.bounds;
    
}
@end
