//
//  SelMainViewController.m
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelMainViewController.h"
#import "SelVideoViewController.h"
#import "PixabayService.h"
#import "PixabayVideoModel.h"
#import "CategoryCell.h"
#import <MJRefresh.h>
#import <GKPhotoBrowser.h>

static NSString *KCellID = @"CategoryCell";

@interface SelMainViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MJRefreshNormalHeader *header;
@property (nonatomic, strong) MJRefreshBackNormalFooter *footer;
@end

@implementation SelMainViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    self.view.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[CategoryCell class] forCellReuseIdentifier:KCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 180;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    if (@available(iOS 13.0, *)) {
        self.tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
    } else {
        // Fallback on earlier versions
    }
    self.page = 1;
    [self requestVideo];
    [self mj_pullRefresh];
    

}

- (void)playAction:(NSInteger)index titleStr:(NSString *)titleStr{
    SelVideoViewController *videoVC = [[SelVideoViewController alloc]init];
    PixabayVideoModel *model = self.dataArr[index];
    videoVC.urlStr = model.videos.large.url;
    videoVC.titleStr = model.tags;
    [self.navigationController pushViewController:videoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)mj_pullRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self.dataArr removeAllObjects];
        [self requestVideo];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self requestVideo];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"上一页" forState:MJRefreshStatePulling];
    [footer setTitle:@"下一页" forState:MJRefreshStatePulling];
    self.header = header;
    self.footer = footer;
    self.tableView.mj_header = self.header;
    self.tableView.mj_footer = self.footer;
}
/**
- (UITableView *)mainTableView {
    
    if(!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_mainTableView registerClass:[CategoryCell class] forCellReuseIdentifier:KCellID];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.delegate = self;
        
        _mainTableView.dataSource =self;
        
        _mainTableView.rowHeight = 180;
    }
    return _mainTableView;
}
 */
- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
//        _dataArr = [NSMutableArray arrayWithObjects:
//                    @"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319104618910544.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/17/mp4/190317150237409904.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4",
//                    @"http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4",
//
//                    nil];
    }
    return _dataArr;
}

- (void)requestVideo{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"latest" forKey:@"order"];
    [param setObject:@(self.page) forKey:@"page"];
//    if ([_tag isEqualToString:@"Latest"]) {
//        [param setObject:@"latest" forKey:@"order"];
//    }else{
//        [param setObject:_tag forKey:@"q"];
//    }
//    [param setObject:@(_page) forKey:@"page"];
    [PixabayService requestVideoParams:param completion:^(NSArray * _Nonnull Pixabaypapers, BOOL success) {
        [self.header endRefreshing];
        [self.footer endRefreshing];
    
        [self.dataArr addObjectsFromArray:[PixabayVideoModel mj_objectArrayWithKeyValuesArray:Pixabaypapers]];
        //在主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellID];
    
    PixabayVideoModel *model = self.dataArr[indexPath.row];
    cell.videoModel = model;

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self playAction:indexPath.row titleStr:[NSString stringWithFormat:@"Video-%ld",indexPath.row]];
    [self play:indexPath.row];
    
}

- (void)play:(NSInteger)index{
    
//        __strong __typeof(weakSelf) self = weakSelf;
        NSMutableArray *photos = [NSMutableArray new];
        [self.dataArr enumerateObjectsUsingBlock:^(PixabayVideoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            GKPhoto *photo = [[GKPhoto alloc] init];
//            photo.url = [NSURL URLWithString:obj.videos.large.url];
            
//            photo.sourceImageView = cell.photosView.subviews[idx];
//            if (obj.isVideo) {
                photo.videoUrl = [NSURL URLWithString:obj.videos.large.url];
//            }
            
            [photos addObject:photo];
        }];
        
        GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
        browser.showStyle = GKPhotoBrowserShowStyleZoom;        // 缩放显示
        browser.hideStyle = GKPhotoBrowserHideStyleZoomScale;   // 缩放隐藏
        browser.loadStyle = GKPhotoBrowserLoadStyleIndeterminateMask; // 不明确的加载方式带阴影
        browser.maxZoomScale = 20.0f;
        browser.doubleZoomScale = 2.0f;
        browser.isAdaptiveSafeArea = YES;
        browser.hidesCountLabel = YES;
//        browser.hidesPageControl = YES;
        browser.hidesSavedBtn = YES;
        browser.isFullWidthForLandScape = NO;
        browser.isSingleTapDisabled = YES;
//        browser.photoViewPadding = 0;
//        browser.animDuration = 10;
        // 自定义视频播放
//        [browser setupVideoPlayerProtocol:[GKZFPlayerManager new]];
        browser.showPlayImage = NO;
        browser.isVideoReplay = YES;
        browser.videoPlayImage = [UIImage imageNamed:@"ic_play3"];
//        browser.isDoubleTapDisabled = YES;
//        browser.isStatusBarShow = YES;
//        browser.bgColor = UIColor.whiteColor;
//        browser.statusBarStyle = UIStatusBarStyleDefault;
        
//        // 当你的APP支持屏幕旋转时此属性必须设置为YES
//        if (kIsiPad) { // ipad 默认支持屏幕旋转，这里设置为YES
//            browser.isFollowSystemRotation = YES;
//        }
//        [browser setupWebImageProtocol:[[GKYYWebImageManager alloc] init]];
        
//        browser.isFollowSystemRotation = YES;
        
//        browser.delegate = self;
        [browser showFromVC:self];
//        self.browser = browser;
}

@end
