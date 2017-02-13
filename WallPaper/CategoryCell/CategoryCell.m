//
//  CategoryCell.m
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "CategoryCell.h"
#import "ImageCategory.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CategoryCell{

    UIImageView *_thumbnail;
    UILabel *_name;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _thumbnail = [[UIImageView alloc] init];
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail.clipsToBounds = YES;
        [self.contentView addSubview:_thumbnail];
        
        _name = [[UILabel alloc] init];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor = [UIColor whiteColor];
        _name.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
        _name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_name];
    }
    return self;
}
- (void)setImageCategory:(ImageCategory *)category{

   _name.text = category.name;
    [_thumbnail sd_setImageWithURL:category.thumbnail];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _thumbnail.frame = self.contentView.bounds;
    _name.frame = self.contentView.bounds;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
//    _thumbnail.alpha = selected ? 0.5 : 1;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
