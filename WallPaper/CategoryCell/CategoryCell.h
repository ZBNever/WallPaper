//
//  CategoryCell.h
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageCategory;

@class PixabayModel;

@interface CategoryCell : UITableViewCell

- (void)setImageCategory:(ImageCategory *)category;

- (void)setImageModel:(PixabayModel *)imageModel;



@end
