//
//  UnsplashModel.h
//  WallPaper
//
//  Created by Never on 2021/6/11.
//  Copyright © 2021 Never. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface UnsplashUserModel : NSObject

@property (nonatomic, strong) NSString *Id; //"GV2cL0IFBvQ",
@property (nonatomic, strong) NSString *updated_at; //"2021-06-11T10:25:40-04:00",
@property (nonatomic, strong) NSString *username; //"jarritos",
@property (nonatomic, strong) NSString *name; //"Jarritos Mexican Soda",
@property (nonatomic, strong) NSString *first_name; //"Jarritos",
@property (nonatomic, strong) NSString *last_name; //"Mexican Soda",
@property (nonatomic, strong) NSString *twitter_username; //"jarritos",
@property (nonatomic, strong) NSString *portfolio_url; //"https://www.jarritos.com",
@property (nonatomic, strong) NSString *bio; //"Natural Flavored Sodas made with real sugar that are available in 13 Super Good flavors!",
@property (nonatomic, strong) NSString *location; //null,
@property (nonatomic, strong) NSString *links; //Object{...},
@property (nonatomic, strong) NSString *profile_image; //Object{...},
@property (nonatomic, strong) NSString *instagram_username; //"jarritos",
@property (nonatomic, strong) NSString *total_collections; //0,
@property (nonatomic, strong) NSString *total_likes; //7,
@property (nonatomic, strong) NSString *total_photos; //344,
@property (nonatomic, strong) NSString *accepted_tos; //true,
@property (nonatomic, strong) NSString *for_hire; //false

@end

@interface UnsplashImageUrlModel : NSObject

@property (nonatomic, strong) NSString *raw;
@property (nonatomic, strong) NSString *full;
@property (nonatomic, strong) NSString *regular;
@property (nonatomic, strong) NSString *small;
@property (nonatomic, strong) NSString *thumb;
@end

@interface UnsplashModel : NSObject

@property (nonatomic, strong) NSString *Id; //"Q1SywLJM_-M",
@property (nonatomic, strong) NSString *created_at; //"2021-05-31T17:20:04-04:00",
@property (nonatomic, strong) NSString *updated_at; //"2021-06-09T18:49:28-04:00",
@property (nonatomic, strong) NSString *promoted_at; //null,
@property (nonatomic, strong) NSString *width; //6000,
@property (nonatomic, strong) NSString *height; //4000,
@property (nonatomic, strong) NSString *color; //"#f3d9d9",
@property (nonatomic, strong) NSString *blur_hash; //"LhI}bSIU?bM{~BM{xaofIAWBM{xu",
@property (nonatomic, strong) NSString *des_cription; //"Jarritos Sidewalk City Hang",
@property (nonatomic, strong) NSString *alt_description; //"woman in black leather jacket holding orange plastic bottle",
@property (nonatomic, strong) UnsplashImageUrlModel *urls; //Object{...},
@property (nonatomic, strong) NSString *links; //Object{...},
@property (nonatomic, strong) NSString *categories; //Array[0],
@property (nonatomic, strong) NSString *likes; //31,
@property (nonatomic, strong) NSString *liked_by_user; //false,
@property (nonatomic, strong) NSString *current_user_collections; //Array[0],
@property (nonatomic, strong) NSString *sponsorship; //Object{...},
@property (nonatomic, strong) UnsplashUserModel *user; //Object{...}
@end

NS_ASSUME_NONNULL_END
