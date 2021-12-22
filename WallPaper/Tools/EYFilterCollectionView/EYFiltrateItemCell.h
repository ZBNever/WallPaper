//
//  EYFiltrateItemCell.h
//  EYSmart
//
//  Created by Never on 2021/4/25.
//  Copyright © 2021 一应科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYFiltrateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYFiltrateItemCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, strong) EYFiltrateItemModel *itemModel;
@end

NS_ASSUME_NONNULL_END
