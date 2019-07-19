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

#import <MJRefresh.h>

static NSString * const reuseIdentifier = @"Cell";

@interface WallpapersViewController ()
@property (nonatomic, strong) MJRefreshNormalHeader *header;
@property (nonatomic, strong) MJRefreshBackNormalFooter *footer;
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

    return self;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    self.navigationItem.rightBarButtonItem = refreshItem;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(reloadData)];
//   self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.backBarButtonItem.title = @"返回";
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[WallpaperCell class] forCellWithReuseIdentifier:reuseIdentifier];
    index = 1;
    _HUD = [Tools MBProgressHUD:@"正在加载"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(requestData) object:nil];
    [queue addOperation:op];
    [self mj_pullRefresh];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_HUD removeFromSuperview];

}
#pragma mark - **********  添加MJ_Refresh  **********
- (void)mj_pullRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestPreviousPage];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestNextPage];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"上一页" forState:MJRefreshStatePulling];
    [footer setTitle:@"下一页" forState:MJRefreshStatePulling];
    self.header = header;
    self.footer = footer;
    self.collectionView.mj_header = self.header;
    self.collectionView.mj_footer = self.footer;
}
#pragma mark  **********  重新加载  **********
- (void)reloadData{
    _page = 1;
    [self requestData];
}
#pragma mark  **********  上一页数据  **********
- (void)requestPreviousPage{
    if (_page>1) {
        _page--;
    }else{
        _page = 1;
    }
    [self requestData];
}
#pragma mark  **********  下一页数据  **********
- (void)requestNextPage{
    _page++;
    [self requestData];
}

#pragma mark  **********  请求数据  **********
-(void)requestData{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if ([_category.name isEqualToString:@"Latest"]) {
        [param setObject:@"latest" forKey:@"order"];
    }else{
        [param setObject:_category.name forKey:@"q"];
    }
    [param setObject:@(_page) forKey:@"page"];
    [PixabayService requestWallpapersFromURL:API_HOST params:param completion:^(NSArray *Pixabaypapers, BOOL success) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self->_HUD hideAnimated:YES];
        if (success && Pixabaypapers.count != 0) {
            self->index++;
            self->_wallpapers = Pixabaypapers;
            
            [self.collectionView reloadData];
            
        }else{
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            self->_HUD = [Tools MBProgressHUDOnlyText:@"加载失败"];
            
            [self->_HUD hideAnimated:YES afterDelay:2.0f];
        }
    }];


}

#pragma mark - <UICollectionViewDataSource>

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
