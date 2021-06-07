//
//  WallPaperService.m
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "WallPaperService.h"
#import "WallPaper.h"
#import <AFNetworking.h>
#import "MHNetwork.h"
#import <MJExtension.h>

@implementation WallPaperService

+(void)requestWallpapersFromURL:(NSString *)url completion:(WallpapersCompletion)completion{
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    if (params == nil) {
//        params = [NSMutableDictionary dictionary];
//    }
//    [params setObject:API_Key forKey:@"key"];
//    [params setObject:@"zh" forKey:@"lang"];
//    [params setObject:@"photo" forKey:@"image_type"];
//    [params setObject:@"vertical" forKey:@"orientation"];
    
    [MHNetworkManager getRequstWithURL:url params:nil successBlock:^(id returnData, int code, NSString *msg) {
//        NSLog(@"returnData:%@",returnData);
        NSMutableArray *ModelArr = [WallPaperListModel mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        completion(ModelArr,YES);
    } failureBlock:^(NSError *error) {
//        NSLog(@"%@",error);
    } showHUD:YES];
}

+(void)requestSearchWallPapers:(NSMutableDictionary *)params completion:(WallpapersCompletion)completion{
    
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    [params setObject:WallHavenAPIkey forKey:@"apikey"];
//    [params setObject:@"100" forKey:@"categories"];
//    [params setObject:@"" forKey:@"q"];
    [params setObject:@"toplist" forKey:@"sorting"];//排序 默认date_added , relevance, random, views, favorites, toplist
    
    [MHNetworkManager getRequstWithURL:WallPaperSearchURL params:params successBlock:^(id returnData, int code, NSString *msg) {
//        NSLog(@"returnData:%@",returnData);
        NSMutableArray *ModelArr = [WallPaperListModel mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        completion(ModelArr,YES);
    } failureBlock:^(NSError *error) {
//        NSLog(@"%@",error);
    } showHUD:YES];
}


@end
