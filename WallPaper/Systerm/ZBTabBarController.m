//
//  ZBTabBarController.m
//  WallPaper
//
//  Created by Never on 2020/4/28.
//  Copyright © 2020 Never. All rights reserved.
//

#import "ZBTabBarController.h"
#import "ZBNavigationController.h"
#import "CategoriesViewController.h"
#import "ZBVideoViewController.h"
#import "SelMainViewController.h"
#import "PDFViewController.h"
//#import "HSClassViewController.h"
//#import "HSCartViewController.h"
//#import "HSMineViewController.h"
@interface ZBTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZBTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    [self addTabarItems];
    self.delegate = self;
    self.tabBar.barStyle = UIBarStyleBlack;
    self.tabBar.translucent = NO;
}

- (void)addChildViewControllers
{
    ZBNavigationController *one = [[ZBNavigationController alloc] initWithRootViewController:[[CategoriesViewController alloc] init]];
    
    ZBNavigationController *two = [[ZBNavigationController alloc] initWithRootViewController:[[SelMainViewController alloc] init]];

    ZBNavigationController *three = [[ZBNavigationController alloc] initWithRootViewController:[[PDFViewController alloc] init]];
//
//    ZBNavigationController *four = [[ZBNavigationController alloc] initWithRootViewController:[[HSMineViewController alloc] init]];

    self.viewControllers = @[one, two, three];
    
}

- (void)addTabarItems
{
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"图片",
                                                 @"TabBarItemImage" : @"shop-0",
                                                 @"TabBarItemSelectedImage" : @"shop-1",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"视频",
                                                 @"TabBarItemImage" : @"shapes-0",
                                                 @"TabBarItemSelectedImage" : @"shapes-1",
                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"PDF",
                                                 @"TabBarItemImage" : @"cart-0",
                                                 @"TabBarItemSelectedImage" : @"cart-1",
                                                 };
//    NSDictionary *fourthTabBarItemsAttributes = @{
//                                                  @"TabBarItemTitle" : @"我的",
//                                                  @"TabBarItemImage" : @"user-0",
//                                                  @"TabBarItemSelectedImage" : @"user-1"
//                                                  };

    NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
//                                       fourthTabBarItemsAttributes
                                       ];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    
//    self.tabBar.tintColor = [UIColor colorWithHexString:@"#E8C6A3"];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
@end
