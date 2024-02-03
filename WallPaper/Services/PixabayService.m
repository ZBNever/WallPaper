//
//  PixabayService.m
//  WallPaper
//
//  Created by Never on 2019/7/18.
//  Copyright © 2019 Never. All rights reserved.
//

#import "PixabayService.h"
#import "MHNetwork.h"
#import <MJExtension.h>
#import "PixabayModel.h"

@implementation PixabayService

+(void)requestPixabayImageParams:(NSMutableDictionary *)params completion:(PixabayCompletion)completion{
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    [params setObject:API_Key forKey:@"key"];
    [params setObject:@"zh" forKey:@"lang"];
    [params setObject:@"photo" forKey:@"image_type"];
//    [params setObject:@"vertical" forKey:@"orientation"];
    NSInteger page = [[params objectForKey:@"page"] integerValue];
    BOOL showHUD = page==1?YES:NO;
    [MHNetworkManager getRequstWithURL:API_HOST params:params successBlock:^(id returnData, int code, NSString *msg) {
//        NSLog(@"returnData:%@",returnData);
        NSMutableArray *ModelArr = [PixabayModel mj_objectArrayWithKeyValuesArray:returnData[@"hits"]];
        completion(ModelArr,YES);
    } failureBlock:^(NSError *error) {
//        NSLog(@"%@",error);
        completion(nil,NO);
    } showHUD:showHUD];
    
}

+(void)requestVideoParams:(NSMutableDictionary *)params completion:(PixabayCompletion)completion{
        if (params == nil) {
            params = [NSMutableDictionary dictionary];
        }
        [params setObject:API_Key forKey:@"key"];
        [params setObject:@"zh" forKey:@"lang"];
        [params setObject:@"all" forKey:@"video_type"];
        [MHNetworkManager getRequstWithURL:API_Video_HOST params:params successBlock:^(id returnData, int code, NSString *msg) {
            NSMutableArray *ModelArr = returnData[@"hits"];
            completion(ModelArr,YES);
        } failureBlock:^(NSError *error) {
            completion(nil,NO);
            
        } showHUD:YES];
    
}

@end
