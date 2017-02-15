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
#import <MBProgressHUD.h>

@interface WallpaperViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,MBProgressHUDDelegate>

@end

@implementation WallpaperViewController
{
    UIImageView *_imageView;
    WallPaper *_wallpaper;
    BOOL _isFull;
    MBProgressHUD *_HUD;
}


- (instancetype)initWithWallpaper:(WallPaper *)wallpaper{

    if (self = [super init]) {
        self.title = @"Wallpaper";
        self.view.backgroundColor = [UIColor blackColor];
        [self requestImge:wallpaper];
        
    }
    return self;
}

- (void)requestImge:(WallPaper *)wallpaper{

    [_imageView sd_setImageWithURL:wallpaper.fullSize  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [_HUD hideAnimated:YES];
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"没找到高清图" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        
       
    }];
    
}

-(void)loadView{
    
    //图片视图
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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save"] style:UIBarButtonItemStyleDone target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    _HUD = [Tools MBProgressHUD:@"正在加载"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_HUD hideAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 图片点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.numberOfTapsRequired == 2) {
        _imageView.contentMode = _isFull ? UIViewContentModeScaleAspectFill :UIViewContentModeScaleAspectFit;
        _isFull = !_isFull;
    }else{
        
    }
    
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

       _HUD = [Tools MBProgressHUDCustomView:@"保存成功"];
        
    }else
    {
        message = [error description];
       _HUD = [Tools MBProgressHUDCustomView:@"保存失败"];

    }

    [_HUD hideAnimated:YES afterDelay:2.0];
}

@end
