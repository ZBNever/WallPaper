//
//  WallPaper.h
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WallPaper : NSObject

@property (nonatomic, strong) NSURL *detail;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSURL *fullSize;

@property (nonatomic, strong) NSString *large; //"https://th.wallhaven.cc/lg/1k/1k1wvv.jpg",
@property (nonatomic, strong) NSString *original; //"https://th.wallhaven.cc/orig/1k/1k1wvv.jpg",
@property (nonatomic, strong) NSString *small; //"https://th.wallhaven.cc/small/1k/1k1wvv.jpg"


@end

@interface WallPaperListModel : NSObject

@property (nonatomic, strong) NSString *Id; //"1k1wvv",
@property (nonatomic, strong) NSString *url; //"https://wallhaven.cc/w/1k1wvv",
@property (nonatomic, strong) NSString *short_url; //"https://whvn.cc/1k1wvv",
@property (nonatomic, strong) NSString *views; //181,
@property (nonatomic, strong) NSString *favorites; //6,
@property (nonatomic, strong) NSString *source; //"",
@property (nonatomic, strong) NSString *purity; //"sfw",
@property (nonatomic, strong) NSString *category; //"anime",
@property (nonatomic, strong) NSString *dimension_x; //4069,
@property (nonatomic, strong) NSString *dimension_y; //2322,
@property (nonatomic, strong) NSString *resolution; //"4069x2322",
@property (nonatomic, strong) NSString *ratio; //"1.75",
@property (nonatomic, strong) NSString *file_size; //1266141,
@property (nonatomic, strong) NSString *file_type; //"image/jpeg",
@property (nonatomic, strong) NSString *created_at; //"2021-06-05 08:56:11",
@property (nonatomic, strong) NSArray  *colors;
@property (nonatomic, strong) NSString *path; //"https://w.wallhaven.cc/full/1k/wallhaven-1k1wvv.jpg",
@property (nonatomic, strong) WallPaper *thumbs;
@property (nonatomic, strong) NSString *userImageURL;
@end
