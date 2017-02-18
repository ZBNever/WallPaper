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
    UIActivityIndicatorView *_activity;
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

    [_imageView sd_setImageWithURL:wallpaper.fullSize placeholderImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:wallpaper.thumbnail]] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        float progress = (float)receivedSize/expectedSize;
        NSLog(@"下载进度：%f",progress);
        dispatch_sync(dispatch_get_main_queue() , ^{
            //必须返回主线程才能刷新UI
            _HUD.progress = progress;
        });
    
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        [_HUD hideAnimated:YES];
//        [_activity stopAnimating];
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
    //缓冲进度
//    _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(375/2.0-20, 667/2.0-20, 40, 40)];
//    
//    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
//
//    _activity.color = [UIColor darkGrayColor];
//    [self.view addSubview:_activity];
//    [_activity startAnimating];
    
    _HUD = [Tools MBProgressHUDProgress:@"Loading"];
    _HUD.progress = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save"] style:UIBarButtonItemStyleDone target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_HUD removeFromSuperview];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

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
