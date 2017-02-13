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
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [WallPaperService requestWallpapersFromURL:_category.data completion:^(NSArray *wallpapers, BOOL success) {
        if (success) {
            _wallpapers = wallpapers;
            [self.collectionView reloadData];
        }else{
        
            NSLog(@"找不到缩略图");
        }
    }];
    // Register cell classes
    [self.collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    NSURL *fullUrl = wallpaper.fullSize;
    NSLog(@"fullUrl:%@",fullUrl);
    WallpaperViewController *wallpaperVC = [[WallpaperViewController alloc] initWithWallpaper:wallpaper];
    
    [self.navigationController pushViewController:wallpaperVC animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
