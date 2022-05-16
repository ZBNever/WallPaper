//
//  PixabayVideoModel.m
//  WallPaper
//
//  Created by Never on 2020/5/15.
//  Copyright © 2020 Never. All rights reserved.
//

#import "PixabayVideoModel.h"

@implementation VideoModel


@end

@implementation VideoTypeModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"large":@"VideoModel",@"medium":@"VideoModel",@"small":@"VideoModel",@"tiny":@"VideoModel"};
}

@end

@implementation PixabayVideoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"Id":@"id"};
    
}
+(NSDictionary *)mj_objectClassInArray{
    return @{@"videos":@"VideoTypeModel"};
}
@end
