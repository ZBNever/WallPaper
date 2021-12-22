//
//  EYFiltrateItemCell.m
//  EYSmart
//
//  Created by Never on 2021/4/25.
//  Copyright © 2021 一应科技. All rights reserved.
//

#import "EYFiltrateItemCell.h"
#import "UIView+AddInspectableProterty.h"

@implementation EYFiltrateItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cornerRadius = 3.f;

}

- (void)setItemModel:(EYFiltrateItemModel *)itemModel{
    _itemModel = itemModel;
    self.titleLab.text = itemModel.titleStr;
    self.selected = itemModel.isSelected;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.borderColor = [UIColor blackColor];
        self.titleLab.textColor = [UIColor blackColor];
        self.contentView.borderWidth = 1.f;
        
    }else{
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        self.contentView.borderColor = [UIColor clearColor];
        self.contentView.borderWidth = 1.f;
        self.titleLab.textColor = [UIColor lightGrayColor];
        
    }

}
@end
