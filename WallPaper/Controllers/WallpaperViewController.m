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

@interface WallpaperViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation WallpaperViewController
{
    UIImageView *_imageView;
    WallPaper *_wallpaper;
    BOOL _isFull;
//    MBProgressHUD *_HUD;
}


- (instancetype)initWithWallpaper:(WallPaper *)wallpaper{

    if (self = [super init]) {
        self.title = @"Wallpaper";
        self.view.backgroundColor = [UIColor blackColor];
        _wallpaper = wallpaper;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save"] style:UIBarButtonItemStyleDone target:self action:@selector(saveImage)];
        [MBProgressHUD showActivityMessageInView:@"正在加载图片"];

        [_imageView sd_setImageWithURL:_wallpaper.fullSize completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [MBProgressHUD hideHUD];
            
        }];
    }
    return self;
}

-(void)loadView{
   
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    _isFull = YES;
    _imageView.userInteractionEnabled = YES;
    //单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    singleTap.delegate = self;
    
    [_imageView addGestureRecognizer:singleTap];
    
    //双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [_imageView addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    self.view = _imageView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.numberOfTapsRequired == 2) {
        _imageView.contentMode = _isFull ? UIViewContentModeScaleAspectFill :UIViewContentModeScaleAspectFit;
        _isFull = !_isFull;
    }else{
        NSLog(@"00000");
    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUD];
}
#pragma mark - 保存图片到本地
- (void)saveImage{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"保存照片到本地相册？" message:@"保存成功后请前往照片查看" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alertVC addAction:save];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
//系统保存方法
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image] applicationActivities:nil];
//    [self presentViewController:activityVC animated:YES completion:nil];
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
