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

+(void)requestWallpapersFromURL:(NSString *)url params:(NSMutableDictionary *)params completion:(PixabayCompletion)completion{
    [params setObject:API_Key forKey:@"key"];
    [MHNetworkManager getRequstWithURL:API_HOST params:params successBlock:^(id returnData, int code, NSString *msg) {
        NSLog(@"returnData:%@",returnData);
        NSMutableArray *ModelArr = [PixabayModel mj_objectArrayWithKeyValuesArray:returnData[@"hits"]];
        completion(ModelArr,YES);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } showHUD:NO];
    
}

@end
