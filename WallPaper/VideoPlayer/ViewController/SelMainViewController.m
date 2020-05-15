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

@interface SelMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation SelMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    [self.view addSubview:self.mainTableView];
    [self requestVideo];
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
- (UITableView *)mainTableView {
    
    if(!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _mainTableView.delegate =self;
        
        _mainTableView.dataSource =self;
        
    }
    return _mainTableView;
}
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
    [param setObject:@(1) forKey:@"page"];
//    if ([_tag isEqualToString:@"Latest"]) {
//        [param setObject:@"latest" forKey:@"order"];
//    }else{
//        [param setObject:_tag forKey:@"q"];
//    }
//    [param setObject:@(_page) forKey:@"page"];
    [PixabayService requestVideoParams:param completion:^(NSArray * _Nonnull Pixabaypapers, BOOL success) {
        self.dataArr = [PixabayVideoModel mj_objectArrayWithKeyValuesArray:Pixabaypapers];
        //在主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadData];
        });
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify =@"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        
    }
    
    PixabayVideoModel *model = self.dataArr[indexPath.row];
    
    cell.textLabel.text = model.tags;//self.dataArr[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.userImageURL]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self playAction:indexPath.row titleStr:[NSString stringWithFormat:@"Video-%ld",indexPath.row]];
}

@end
