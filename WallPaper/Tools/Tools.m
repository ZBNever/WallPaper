//
//  Tools.m
//  WallPaper
//
//  Created by Never on 2017/2/15.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (MBProgressHUD *)MBProgressHUD:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.mode = MBProgressHUDModeIndeterminate;
//    HUD.delegate = self;
    //NO允许点击其他地方，YES不允许点击其他地方
    HUD.userInteractionEnabled = NO;
    HUD.label.text = text;
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (MBProgressHUD *)MBProgressHUDOnlyText:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.mode = MBProgressHUDModeText;
    //NO允许点击其他地方，YES不允许点击其他地方
    HUD.userInteractionEnabled = NO;
    HUD.label.text = text;
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
}

+ (MBProgressHUD *)MBProgressHUDCustomView:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    HUD.mode = MBProgressHUDModeCustomView;
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minion"]];
    HUD.customView = customView;
    //NO允许点击其他地方，YES不允许点击其他地方
    HUD.userInteractionEnabled = NO;
    HUD.label.text = text;
    [window addSubview:HUD];
    [HUD showAnimated:YES];
    return HUD;
    
}

@end
