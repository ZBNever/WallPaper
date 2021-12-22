//
//  WallpapersViewController.h
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageCategory;

@interface WallpapersViewController : UICollectionViewController

@property (nonatomic, assign) int type;

@property (nonatomic, assign) BOOL isWallhaven;

- (instancetype)initWithImageTag:(NSString *)tag;

- (instancetype)initWithImageCategory:(ImageCategory *)category;
@end
