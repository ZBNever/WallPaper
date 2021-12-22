//
//  UnsplashService.m
//  WallPaper
//
//  Created by Never on 2021/6/11.
//  Copyright © 2021 Never. All rights reserved.
//

#import "UnsplashService.h"
#import "MHNetwork.h"
#import <MJExtension.h>
#import "UnsplashModel.h"

@implementation UnsplashService
+(void)requestUnsplashImageParams:(NSMutableDictionary *)params completion:(UnsplashServiceCompletion)completion{
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
//    [params setObject:API_Key forKey:@"key"];
    [params setObject:@"zh" forKey:@"lang"];
//    [params setObject:@"popular" forKey:@"order_by"];
//    [params setObject:@"vertical" forKey:@"orientation"];
    [params setObject:@"20" forKey:@"per_page"];
    //  (Valid values: latest, oldest, popular; default: latest)
    [params setObject:@"popular" forKey:@"order_by"];
    
    [MHNetworkManager getRequstWithURL:UnsplasgSearchPhoto params:params successBlock:^(id returnData, int code, NSString *msg) {
//        NSLog(@"returnData:%@",returnData);
        NSMutableArray *ModelArr = [UnsplashModel mj_objectArrayWithKeyValuesArray:returnData];
        completion(ModelArr,YES);
    } failureBlock:^(NSError *error) {
//        NSLog(@"%@",error);
        completion(nil,NO);
    } showHUD:YES];
    
}
@end
