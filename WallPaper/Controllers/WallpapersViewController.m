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
//第三方图片浏览器
#import "PhotoBroswerVC.h"

#import "PixabayService.h"

#import "PixabayModel.h"

#import "MHNetwork.h"

static NSString * const reuseIdentifier = @"Cell";

@interface WallpapersViewController ()

@end

@implementation WallpapersViewController{
    
    ImageCategory *_category;
    NSArray *_wallpapers;
    MBProgressHUD *_HUD;
    int index;
    int _page;
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
    _page = 1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(requestNext)];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:reuseIdentifier];
    index = 1;
    _HUD = [Tools MBProgressHUD:@"正在加载"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(requestData) object:nil];
    [queue addOperation:op];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_HUD removeFromSuperview];

}

- (void)requestNext{
    _page++;
    [self requestData];
}

/** 请求数据 */
-(void)requestData{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if ([_category.name isEqualToString:@"Latest"]) {
        [param setObject:@"latest" forKey:@"order"];
    }else{
        [param setObject:_category.name forKey:@"q"];
    }
    [param setObject:@(_page) forKey:@"page"];
    [PixabayService requestWallpapersFromURL:API_HOST params:param completion:^(NSArray *Pixabaypapers, BOOL success) {
        [self->_HUD hideAnimated:YES];
        if (success && Pixabaypapers.count != 0) {
            self->index++;
            self->_wallpapers = Pixabaypapers;
            
            [self.collectionView reloadData];
            
        }else{
            
            self->_HUD = [Tools MBProgressHUDOnlyText:@"加载失败"];
            
            [self->_HUD hideAnimated:YES afterDelay:2.0f];
        }
    }];


}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _wallpapers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallpaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PixabayModel *model = _wallpapers[indexPath.item];
    [cell setPixabayModel:model];
    return cell;
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:indexPath.item photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:_wallpapers.count];
        
        for (NSUInteger i = 0; i < self->_wallpapers.count; i++) {
            PixabayModel *model = self->_wallpapers[i];
//            WallPaper *wallpaper = _wallpapers[i];
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            //此处的展示视图为XIB，已经隐藏
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = [NSString stringWithFormat:@"%@", model.largeImageURL];
            
            pbModel.image_thumbnail_U = [NSString stringWithFormat:@"%@", model.webformatURL];
            //从图片地址中截取唯一标识id,作为保存id,不会有重复
//            NSArray *strArr = [pbModel.image_HD_U componentsSeparatedByString:@"-"];
//            NSString *idStr = [strArr[1] componentsSeparatedByString:@"."][0];
            /** mid，保存图片缓存唯一标识，必须传 */
            pbModel.mid = [model.Id integerValue];
            
            WallpaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            //源frame
            UIImageView *imageV =(UIImageView *)cell;
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
    
    
}


@end
