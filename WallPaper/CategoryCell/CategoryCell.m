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

    [_thumbnail sd_setImageWithURL:category.thumbnail completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        _name.text = category.name;
        
        CATransform3D rotation;//3D旋转
        rotation = CATransform3DMakeTranslation(0 ,50 ,20);
        rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
        //逆时针旋转
        rotation = CATransform3DScale(rotation, 0.9, .9, 1);
        rotation.m34 = 1.0/ -600;
        self.layer.shadowColor = [[UIColor blackColor]CGColor];
        self.layer.shadowOffset = CGSizeMake(10, 10);
        self.alpha = 0.2;
        self.layer.transform = rotation;
        
        [UIView beginAnimations:@"rotation" context:NULL];
        //旋转时间
        [UIView setAnimationDuration:0.5];
        self.layer.transform = CATransform3DIdentity;
        self.alpha = 1;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];

    }];
    
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
