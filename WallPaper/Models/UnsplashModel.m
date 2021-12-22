//
//  UnsplashModel.m
//  WallPaper
//
//  Created by Never on 2021/6/11.
//  Copyright © 2021 Never. All rights reserved.
//

#import "UnsplashModel.h"

@implementation UnsplashUserModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"Id":@"id"
    };
}
@end

@implementation UnsplashImageUrlModel

@end


@implementation UnsplashModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"Id":@"id",
        @"des_cription":@"description"
    };
}
@end
