//
//  WallpapersViewController.m
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "WallpapersViewController.h"

#import "ImageCategory.h"

#import "WallPaperService.h"

#import "WallpaperCell.h"

#import "WallPaper.h"

#import "WallpaperViewController.h"


static NSString * const reuseIdentifier = @"Cell";

@interface WallpapersViewController ()

@end

@implementation WallpapersViewController{
    
    ImageCategory *_category;
    NSArray *_wallpapers;
    MBProgressHUD *_HUD;
    int i;
}

- (instancetype)initWithImageCategory:(ImageCategory *)category{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    int portraitWith = MIN(screenSize.width, screenSize.height);
    int itemSize = floor((portraitWith-1)/2);
    layout.itemSize = CGSizeMake(itemSize, itemSize);
    if (self = [super initWithCollectionViewLayout:layout]) {
        _category = category;
        self.title = category.name;

    }


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(requestData)];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    [self.collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:reuseIdentifier];
    i = 1;
    _HUD = [Tools MBProgressHUD:@"正在加载"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(requestData) object:nil];
    [queue addOperation:op];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_HUD hideAnimated:YES];
}
-(void)requestData{
    
    NSURL *url;
    
    if ([_category.name isEqualToString:@"Latest"]) {
        
        url = [NSURL URLWithString:[NSString stringWithFormat:WallLatesURL,i]];
        
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:WallPaperSearchURL,_category.name]];
    }
    [WallPaperService requestWallpapersFromURL:url completion:^(NSArray *wallpapers, BOOL success) {
        [_HUD hideAnimated:YES];
        if (success && wallpapers.count != 0) {
            i++;
            _wallpapers = wallpapers;
            
            [self.collectionView reloadData];
            
        }else{
            
            _HUD = [Tools MBProgressHUDOnlyText:@"加载失败"];
            
            [_HUD hideAnimated:YES afterDelay:2.0f];
        }
    }];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _wallpapers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    WallPaper *wallpaper = _wallpapers[indexPath.item];
    [cell setWallpaper:wallpaper];
    return cell;
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WallPaper *wallpaper = _wallpapers[indexPath.item];
    
    WallpaperViewController *wallpaperVC = [[WallpaperViewController alloc] initWithWallpaper:wallpaper];
    
    [self.navigationController pushViewController:wallpaperVC animated:YES];
}


@end
