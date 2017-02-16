//
//  CategoriesManager.m
//  WallPaper
//
//  Created by Never on 2017/2/9.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "CategoriesManager.h"
#import "ImageCategory.h"



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
                [ImageCategory categoryWithName:@"Latest" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,188271]]],
                
                [ImageCategory categoryWithName:@"Snow" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,122217]]],
                
                [ImageCategory categoryWithName:@"Motorbike" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,140009]]],
                
                [ImageCategory categoryWithName:@"Car" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,136550]]],
                
                [ImageCategory categoryWithName:@"Beach" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,70477]]],
                
                [ImageCategory categoryWithName:@"Sunset" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,131104]]],
                 
                [ImageCategory categoryWithName:@"Wine" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,377213]]],
                 
                [ImageCategory categoryWithName:@"Girl" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,484197]]],
                
                [ImageCategory categoryWithName:@"Train" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,424393]]],
                
                [ImageCategory categoryWithName:@"City" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,228304]]],
                
                [ImageCategory categoryWithName:@"Animal" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,196775]]],
                
                [ImageCategory categoryWithName:@"Architecture" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,423312]]],
                
                [ImageCategory categoryWithName:@"Food" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,276316]]],
                
                [ImageCategory categoryWithName:@"Nature" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,265254]]],
                
                [ImageCategory categoryWithName:@"Landscape" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,155541]]],
                
                [ImageCategory categoryWithName:@"Sky" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,26646]]],
        
                [ImageCategory categoryWithName:@"Plant" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,307700]]],
                
                [ImageCategory categoryWithName:@"Ocean" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,381367]]],
                
                
                ];
                 
    }
    return self;
}
@end
