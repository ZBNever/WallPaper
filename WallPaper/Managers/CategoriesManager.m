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
                                        
                [ImageCategory categoryWithName:@"Snow" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,122217]]],
                
                [ImageCategory categoryWithName:@"Motorbikes" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,140009]]],
                
                [ImageCategory categoryWithName:@"Cars" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,136550]]],
                
                [ImageCategory categoryWithName:@"Beaches" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,70477]]],
                
                [ImageCategory categoryWithName:@"Sunsets" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,131104]]],
                 
                [ImageCategory categoryWithName:@"Wine" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,377213]]],
                 
                [ImageCategory categoryWithName:@"Girls" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,484197]]],
                
                [ImageCategory categoryWithName:@"Trains" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,424393]]],
                
                [ImageCategory categoryWithName:@"Cities" thumbnail:[NSURL URLWithString:[NSString stringWithFormat:ThumbURL,228304]]],
                
                ];
                 
    }
    return self;
}
@end
