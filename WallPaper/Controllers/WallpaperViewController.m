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
#import <MBProgressHUD+JDragon.h>

@interface WallpaperViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

@end

@implementation WallpaperViewController
{
    UIImageView *_imageView;
//    UIScrollView *_scrollView;
    WallPaper *_wallpaper;

}

- (instancetype)initWithWallpaper:(WallPaper *)wallpaper{

    if (self = [super init]) {
        self.title = @"Wallpaper";
        self.view.backgroundColor = [UIColor blackColor];
        _wallpaper = wallpaper;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save"] style:UIBarButtonItemStyleDone target:self action:@selector(saveImage)];
        [MBProgressHUD showActivityMessageInWindow:@"正在加载图片"];
        [_imageView sd_setImageWithURL:_wallpaper.fullSize completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [MBProgressHUD hideHUD];
        }];
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
#pragma mark - 保存图片到本地
- (void)saveImage{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"保存照片到本地相册？" message:@"保存成功后请前往照片查看" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alertVC addAction:save];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];

    
}

#pragma mark - 保存到相册回调
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {

        [MBProgressHUD showInfoMessage:@"保存成功"];
    }else
    {
        message = [error description];
        [MBProgressHUD showErrorMessage:@"保存失败"];

    }

}

@end
