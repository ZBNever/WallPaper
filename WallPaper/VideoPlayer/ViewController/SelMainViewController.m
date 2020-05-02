//
//  SelMainViewController.m
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/26.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelMainViewController.h"
#import "SelVideoViewController.h"

@interface SelMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation SelMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    [self.view addSubview:self.mainTableView];
}

- (void)playAction:(NSInteger)index titleStr:(NSString *)titleStr{
    SelVideoViewController *videoVC = [[SelVideoViewController alloc]init];
    videoVC.urlStr = self.dataArr[index];
    videoVC.titleStr = titleStr;
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
        _dataArr = [NSMutableArray arrayWithObjects:
                    @"http://139.199.74.115:8080/app/video/Performance%20Testing/Fire-resistance.mp4",
                    @"http://139.199.74.115:8080/app/video/Performance%20Testing/Rugged%20Durability%20Test%20Rolled%20by%20Car%20-%20UK%20customer.mp4",
                    @"http://139.199.74.115:8080/app/video/Performance%20Testing/WISDOM%20Cordless%20Lamp%20-%20Chilean%20customer%20TUBOLED.mp4",
                    @"http://139.199.74.115:8080/app/video//WISDOM%20Company%20Introduction/WISDOM-Video-Company-Introduction-EN-2017.mp4",
                    @"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319104618910544.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/17/mp4/190317150237409904.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4",
                    @"http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4",
                    
                    nil];
    }
    return _dataArr;
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"Video-%ld",indexPath.row];//self.dataArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self playAction:indexPath.row titleStr:[NSString stringWithFormat:@"Video-%ld",indexPath.row]];
}

@end
