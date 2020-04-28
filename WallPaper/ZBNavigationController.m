//
//  ZBNavigationController.m
//  WallPaper
//
//  Created by Never on 2020/4/28.
//  Copyright © 2020 Never. All rights reserved.
//

#import "ZBNavigationController.h"

@interface ZBNavigationController ()

@end

@implementation ZBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

// 重写自定义的UINavigationController中的push方法 处理tabbar的显示隐藏
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
     if (self.childViewControllers.count==1) {
         viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
     }
     [super pushViewController:viewController animated:animated];
}
@end
