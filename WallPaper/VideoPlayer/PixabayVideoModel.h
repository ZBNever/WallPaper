//
//  PixabayVideoModel.h
//  WallPaper
//
//  Created by Never on 2020/5/15.
//  Copyright © 2020 Never. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface VideoModel : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *width;// 2560,
@property (nonatomic, strong) NSString *height;// 1440,
@property (nonatomic, strong) NSString *size;// 21512083
@end

@interface VideoTypeModel : NSObject

@property (nonatomic, strong) VideoModel *large;
@property (nonatomic, strong) VideoModel *medium;// 2560,
@property (nonatomic, strong) VideoModel *small;// 1440,
@property (nonatomic, strong) VideoModel *tiny;// 21512083
@end


@interface PixabayVideoModel : NSObject

@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger downloads;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, strong) NSString * pageURL;
@property (nonatomic, strong) NSString * picture_id;
@property (nonatomic, strong) NSString * tags;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * user;
@property (nonatomic, strong) NSString * userImageURL;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) VideoTypeModel * videos;
@property (nonatomic, assign) NSInteger views;
@end

NS_ASSUME_NONNULL_END
