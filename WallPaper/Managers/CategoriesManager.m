//
//  CategoriesManager.m
//  WallPaper
//
//  Created by Never on 2017/2/9.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "CategoriesManager.h"
#import "ImageCategory.h"
#import "PixabayService.h"


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
                [ImageCategory categoryWithName:@"Latest" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Snow" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Motorbike" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Car" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Beach" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Sunset" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                 
                [ImageCategory categoryWithName:@"Wine" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                 
                [ImageCategory categoryWithName:@"Girl" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Train" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"City" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Animal" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Architecture" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Food" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Nature" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Landscape" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Sky" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
        
                [ImageCategory categoryWithName:@"Plant" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                [ImageCategory categoryWithName:@"Ocean" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,@"kwkg5q"]]],
                
                
                ];
                 
    }
    return self;
}
@end
