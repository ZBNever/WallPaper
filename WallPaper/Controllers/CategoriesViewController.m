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

static NSString *kCellID = @"cell";

@interface CategoriesViewController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *modelArr;
@end

@implementation CategoriesViewController

- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        self.title = @"WallPaper";

    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[CategoryCell class] forCellReuseIdentifier:kCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 180;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CategoriesManager shareManager].categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    ImageCategory *category = [CategoriesManager shareManager].categories[indexPath.row];
    
    [cell setImageCategory:category];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    NSString *url = @"https://alpha.wallhaven.cc/search?q=snow&page=3";
    
    ImageCategory *category = [CategoriesManager shareManager].categories[indexPath.row];
    WallpapersViewController *wallpapers = [[WallpapersViewController alloc] initWithImageCategory:category];
    [self.navigationController pushViewController:wallpapers animated:YES];

}

@end
