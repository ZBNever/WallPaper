//
//  Tools.h
//  WallPaper
//
//  Created by Never on 2017/2/15.
//  Copyright © 2017年 Never. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>

@interface Tools : NSObject

+ (MBProgressHUD *)MBProgressHUD:(NSString *)text;

+ (MBProgressHUD *)MBProgressHUDOnlyText:(NSString *)text;

+ (MBProgressHUD *)MBProgressHUDCustomView:(NSString *)text;

@end
