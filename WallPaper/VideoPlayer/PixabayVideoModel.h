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

@property (nonatomic, strong) NSString *Id; //35254,
@property (nonatomic, strong) NSString *pageURL; //"https://pixabay.com/videos/id-35254/",
@property (nonatomic, strong) NSString *type; //"film",
@property (nonatomic, strong) NSString *tags; //"sunrise, birds, nature",
@property (nonatomic, strong) NSString *duration; //29,
@property (nonatomic, strong) NSString *picture_id; //"877697510",
@property (nonatomic, strong) VideoTypeModel *videos; //{},
@property (nonatomic, strong) NSString *views; //33271,
@property (nonatomic, strong) NSString *downloads; //16216,
@property (nonatomic, strong) NSString *favorites; //48,
@property (nonatomic, strong) NSString *likes; //99,
@property (nonatomic, strong) NSString *comments; //55,
@property (nonatomic, strong) NSString *user_id; //10396895,
@property (nonatomic, strong) NSString *user; //"zaidoopro",
@property (nonatomic, strong) NSString *userImageURL; //"https://cdn.pixabay.com/user/2019/08/30/18-22-25-105_250x250.jpg"
@end

NS_ASSUME_NONNULL_END
