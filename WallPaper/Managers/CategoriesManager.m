//
//  CategoriesManager.m
//  WallPaper
//
//  Created by Never on 2017/2/9.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "CategoriesManager.h"
#import "ImageCategory.h"

#define WallPaperURL @"https://alpha.wallhaven.cc/search?q=%@&categories=111&purity=100&sorting=relevance&order=desc"
#define ThumbURL @"https://alpha.wallhaven.cc/wallpapers/thumb/small/th-%d.jpg"

@implementation CategoriesManager

+ (instancetype)shareManager{
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
    
}

- (id)init{
    if (self = [super init]) {
        _categories = @[
                [ImageCategory categoryWithName:@"Snow" data:[NSURL URLWithString:[NSString stringWithFormat:WallPaperURL,@"Snow"]] thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,122217]]],
                [ImageCategory categoryWithName:@"Motorbikes" data:[NSURL URLWithString:[NSString stringWithFormat:WallPaperURL,@"Motorbikes"]] thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,140009]]],
                [ImageCategory categoryWithName:@"Cars" data:[NSURL URLWithString:[NSString stringWithFormat:WallPaperURL,@"Cars"]] thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,136550]]],
                [ImageCategory categoryWithName:@"Beaches" data:[NSURL URLWithString:[NSString stringWithFormat:WallPaperURL,@"Beachs"]] thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,70477]]],
                [ImageCategory categoryWithName:@"Sunsets" data:[NSURL URLWithString:[NSString stringWithFormat:WallPaperURL,@"Sunsets"]] thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,131104]]],
                [ImageCategory categoryWithName:@"Wine" data:[NSURL URLWithString:[NSString stringWithFormat:WallPaperURL,@"Wine"]] thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,377213]]],
                         ];
    }
    return self;
}
@end
