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

static NSString *kCellID = @"cell";

@interface CategoriesViewController ()<PYSearchViewControllerDelegate>
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *modelArr;
@end

@implementation CategoriesViewController

- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        self.title = @"WallPaper";

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
    [self requestDate];
}

- (void)requestDate{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@""];
    [PixabayService requestWallpapersParams:params completion:^(NSArray * _Nonnull Pixabaypapers, BOOL success) {
        self.modelArr = [Pixabaypapers mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)searchBtn{
    // 1. Create an Array of popular search , , , , , , , , , , ,
    NSArray *hotSeaches = @[@"科技", @"星空", @"运动", @"风景", @"商务", @"天空", @"学习", @"森林", @"美女", @"城市", @"背景", @"美食"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        [searchViewController.navigationController pushViewController:[[WallpapersViewController alloc] initWithImageTag:searchText] animated:YES];
    }];
    // 3. Set style for popular search and search history
        searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present(Modal) or push search view controller
    // Present(Modal)
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    //    [self presentViewController:nav animated:YES completion:nil];
    // Push
    // Set mode of show search view controller, default is `PYSearchViewControllerShowModeModal`
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
    //    // Push search view controller
    [self.navigationController pushViewController:searchViewController animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [CategoriesManager shareManager].categories.count;
    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
//    ImageCategory *category = [CategoriesManager shareManager].categories[indexPath.row];
//    [cell setImageCategory:category];

    PixabayModel *model = self.modelArr[indexPath.row];
    [cell setImageModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    NSString *url = @"https://alpha.wallhaven.cc/search?q=snow&page=3";
    
//    ImageCategory *category = [CategoriesManager shareManager].categories[indexPath.row];
//    WallpapersViewController *wallpapers = [[WallpapersViewController alloc] initWithImageCategory:category];
    
    PixabayModel *model = self.modelArr[indexPath.row];
    NSString *tag = [[model.tags componentsSeparatedByString:@","] firstObject];
    WallpapersViewController *wallpapers = [[WallpapersViewController alloc] initWithImageTag:tag];
    [self.navigationController pushViewController:wallpapers animated:YES];

}

@end
