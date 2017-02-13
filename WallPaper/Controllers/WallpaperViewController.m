//
//  WallpaperViewController.m
//  WallPaper
//
//  Created by Never on 2017/2/12.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "WallpaperViewController.h"
#import "WallPaper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WallpaperViewController ()

@end

@implementation WallpaperViewController
{
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    WallPaper *_wallpaper;
}

- (instancetype)initWithWallpaper:(WallPaper *)wallpaper{

    if (self = [super init]) {
        self.title = @"Wallpaper";
        self.view.backgroundColor = [UIColor blackColor];
        _wallpaper = wallpaper;
        
        [_imageView sd_setImageWithURL:_wallpaper.fullSize];
    }
    return self;
}

-(void)loadView{

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    self.view = _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end
