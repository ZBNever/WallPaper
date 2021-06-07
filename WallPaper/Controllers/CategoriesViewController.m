//
//  CategoriesViewController.m
//  WallPaper
//
//  Created by Never on 2017/2/9.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoriesManager.h"
#import "ImageCategory.h"
#import "CategoryCell.h"
#import "WallPaperService.h"
#import "WallpapersViewController.h"
#import "PixabayService.h"
#import "MHNetwork.h"
#import "PixabayModel.h"
#import <PYSearch.h>
#import <MJRefresh/MJRefresh.h>

static NSString *kCellID = @"cell";

@interface CategoriesViewController ()<PYSearchViewControllerDelegate,HXCellTagsViewDelegate>
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) MJRefreshNormalHeader *header;

@property (nonatomic, strong) MJRefreshBackNormalFooter *footer;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL isWallHavenService;
@end

@implementation CategoriesViewController

- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
//        self.title = @"WallPaper";
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:@"Pixabay" forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = titleBtn;
        // 搜索
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
        self.navigationItem.rightBarButtonItem = refreshItem;
        // 菜单
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 22, 44);
        [backBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[CategoryCell class] forCellReuseIdentifier:kCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 180;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _page = 1;
    [self mj_pullRefresh];
    if (self.isWallHavenService) {
        //请求WallHaven数据
        [self requestWallHavenData];
    }else{
        //请求Pixabay数据
        [self requestPixabayData];
    }


}
- (void)chooseType:(UIButton *)titleBtn{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"WallPaper" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.isWallHavenService = YES;
        [titleBtn setTitle:@"WallPaper" forState:UIControlStateNormal];
        [titleBtn sizeToFit];
        [self requestPreviousPage];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Pixabay" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.isWallHavenService = NO;
        [titleBtn setTitle:@"Pixabay" forState:UIControlStateNormal];
        [titleBtn sizeToFit];
        [self requestPreviousPage];
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:^{
            
    }];
    
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
    self.tableView.mj_header = self.header;
    self.tableView.mj_footer = self.footer;
}

#pragma mark  **********  第一页数据  **********
- (void)requestPreviousPage{
//    if (_page>1) {
//        _page--;
//    }else{
//        _page = 1;
//        [self.modelArr removeAllObjects];
//    }
    
    _page = 1;
    [self.modelArr removeAllObjects];
    
    if (self.isWallHavenService) {
        //请求WallHaven数据
        [self requestWallHavenData];
    }else{
        //请求Pixabay数据
        [self requestPixabayData];
    }
    

}
#pragma mark  **********  下一页数据  **********
- (void)requestNextPage{
    _page++;
    if (self.isWallHavenService) {
        //请求WallHaven数据
        [self requestWallHavenData];
    }else{
        //请求Pixabay数据
        [self requestPixabayData];
    }
}
#pragma mark - **********  请求Pixabay数据  **********
- (void)requestPixabayData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_page) forKey:@"page"];
    [params setObject:@"" forKey:@"q"];
    [PixabayService requestWallpapersParams:params completion:^(NSArray * _Nonnull Pixabaypapers, BOOL success) {
        [self.header endRefreshing];
        [self.footer endRefreshing];
        [self.modelArr addObjectsFromArray:Pixabaypapers];
        //在主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}

- (void)requestWallHavenData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(_page) forKey:@"page"];
    [WallPaperService requestSearchWallPapers:params completion:^(NSArray *wallpapers, BOOL success) {
        //在主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.header endRefreshing];
            [self.footer endRefreshing];
            [self.modelArr addObjectsFromArray:wallpapers];
            [self.tableView reloadData];
        });
            
    }];
}

- (void)searchBtn{
    // 1. Create an Array of popular search , , , , , , , , , , ,
    NSArray *hotSeaches = @[@"科技", @"星空", @"运动", @"风景", @"商务", @"天空", @"学习", @"森林", @"美女", @"城市", @"背景", @"美食"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {

        [searchViewController.navigationController pushViewController:[[WallpapersViewController alloc] initWithImageTag:searchText] animated:YES];
    }];
    // 3. Set style for popular search and search history
        searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    
    // 4. Set delegate
    searchViewController.delegate = self;

    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
    // Push search view controller
    [self.navigationController pushViewController:searchViewController animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (self.isWallHavenService) {
        //请求WallHaven数据
        WallPaperListModel *wallPaperModel = self.modelArr[indexPath.row];
        cell.wallPaperListModel = wallPaperModel;
    }else{
        //请求Pixabay数据
        PixabayModel *pixabayModel = self.modelArr[indexPath.row];
        [cell setImageModel:pixabayModel];
    }
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isWallHavenService) {
        
    }else{
        PixabayModel *model = self.modelArr[indexPath.row];
        NSString *tag = [[model.tags componentsSeparatedByString:@","] firstObject];
        WallpapersViewController *wallpapers = [[WallpapersViewController alloc] initWithImageTag:tag];
        [self.navigationController pushViewController:wallpapers animated:YES];
    }


}

- (void)cellTagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender{
    
    NSString *tag = sender.titleLabel.text;
    WallpapersViewController *wallpapers = [[WallpapersViewController alloc] initWithImageTag:tag];
    [self.navigationController pushViewController:wallpapers animated:YES];
}


- (NSMutableArray *)modelArr{
    
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

@end
