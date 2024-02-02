//
//  SelVideoViewController.m
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SelVideoViewController.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "AppDelegate.h"
#import <Masonry.h>

@interface SelVideoViewController ()

@property (nonatomic, strong) SelVideoPlayer *player;

@end

@implementation SelVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor blackColor];
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = YES;
    configuration.repeatPlay = NO;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;
    configuration.sourceUrl = [NSURL URLWithString:self.urlStr];
    configuration.videoGravity = SelVideoGravityResizeAspect;
    
    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 100, width, (width*9/16.f)+60) configuration:configuration];
    [self.view addSubview:_player];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_player _deallocPlayer];
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

@end
