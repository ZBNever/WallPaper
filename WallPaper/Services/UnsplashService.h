//
//  UnsplashService.h
//  WallPaper
//
//  Created by Never on 2021/6/11.
//  Copyright © 2021 Never. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UnsplashServiceCompletion)(NSArray * _Nullable unsplashArr,BOOL success);

@interface UnsplashService : NSObject

+ (void)requestUnsplashImageParams:(NSMutableDictionary *)params completion:(UnsplashServiceCompletion)completion;

@end
NS_ASSUME_NONNULL_END
