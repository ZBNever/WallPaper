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
#import <YYKit.h>

@interface WallpaperViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,MBProgressHUDDelegate,UIScrollViewDelegate>

@end

@implementation WallpaperViewController
{
    UIScrollView *_scrollView;
    YYAnimatedImageView *_imageView;
    WallPaper *_wallpaper;
    BOOL _isFull;
    MBProgressHUD *_HUD;
    UIActivityIndicatorView *_activity;
    
}


- (instancetype)initWithWallpaper:(WallPaper *)wallpaper{

    if (self = [super init]) {
        self.title = @"Wallpaper";
        self.view.backgroundColor = [UIColor blackColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHight)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.minimumZoomScale = 1;
        scrollView.maximumZoomScale = 2.5;
//        [scrollView setZoomScale:2.5 animated:YES];
//        [scrollView zoomToRect:CGRectMake(0, 0, KScreenWidth, KScreenHight) animated:YES];
//        scrollView.contentSize = CGSizeMake(KScreenWidth*3, KScreenHight);
        scrollView.delegate = self;
        _scrollView = scrollView;
        [self.view addSubview: _scrollView];
        _imageView = [YYAnimatedImageView new];
        _imageView.frame = _scrollView.bounds;
//        _imageView.center = scrollView.center;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //    _imageView.clipsToBounds = NO;
        //    CGFloat width = _imageView.image.size.width;
        //    CGFloat heigth = _imageView.image.size.height;
        //
        //    scrollView.contentSize = CGSizeMake(width, heigth);
        _isFull = YES;
        
        [_scrollView addSubview: _imageView];
        
        //    _HUD = [Tools MBProgressHUDProgress:@"Loading"];
        //    _HUD.progress = 0;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save"] style:UIBarButtonItemStyleDone target:self action:@selector(saveImage)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
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
        
        [self requestImge:wallpaper];
    }
    return self;
}

- (void)requestImge:(WallPaper *)wallpaper{

     __weak UIViewController *weakSelf = self;
   [_imageView setImageWithURL:wallpaper.fullSize placeholder:[UIImage imageWithData:[NSData dataWithContentsOfURL:wallpaper.thumbnail]] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation|YYWebImageOptionShowNetworkActivity progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
       weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
   }];
    
//    [_imageView sd_setImageWithURL:wallpaper.fullSize placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:wallpaper.thumbnail]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        
//        float progress = (float)receivedSize/expectedSize;
//        NSLog(@"下载进度：%f",progress);
//        dispatch_sync(dispatch_get_main_queue() , ^{
//            //必须返回主线程才能刷新UI
//            _HUD.progress = progress;
//        });
//    
//    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
//        [_HUD hideAnimated:YES];
//
//        if (error) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"没找到高清图" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//            [alertView show];
//        }else{
//            self.navigationItem.rightBarButtonItem.enabled = YES;
//        }
//    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //关闭优化机制
    self.automaticallyAdjustsScrollViewInsets = NO;

    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_HUD removeFromSuperview];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{

    if (scale < 1.0) {
        view.center = CGPointMake(KScreenWidth/2.0, KScreenHight/2.0);
    }else{
    
        view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    
    
//    _imageView.center = CGPointMake(KScreenWidth/2.0, KScreenHight/2.0);
}

#pragma mark - 图片点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (tap.numberOfTapsRequired == 2) {

        _imageView.contentMode = _isFull ? UIViewContentModeScaleAspectFill :UIViewContentModeScaleAspectFit;

        _isFull = !_isFull;
    }else{
        if (![self.navigationController.navigationBar isHidden]) {
            self.navigationController.navigationBar.hidden = YES;
        }else{
            self.navigationController.navigationBar.hidden = NO;
        }
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
