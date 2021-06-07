//
//  CategoryCell.h
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallPaper.h"
#import "PixabayVideoModel.h"

@class ImageCategory;

@class PixabayModel;

@class HXTagsView;

@protocol HXCellTagsViewDelegate <NSObject>

@optional
- (void)cellTagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender;

@end

@interface CategoryCell : UITableViewCell

@property (nonatomic,assign) id<HXCellTagsViewDelegate> delegate;

@property (nonatomic, strong) UIImageView *thumbnail;

@property (nonatomic, strong) WallPaperListModel *wallPaperListModel;
/** 视频的Model */
@property (nonatomic, strong) PixabayVideoModel *videoModel;

- (void)setImageModel:(PixabayModel *)imageModel;



@end
