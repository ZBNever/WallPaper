//
//  CategoryCell.m
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "CategoryCell.h"
#import "ImageCategory.h"
#import "PixabayModel.h"
#import "YYKit.h"
#import "HXTagsView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CategoryCell ()<HXTagsViewDelegate>

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) HXTagsView *tagsView;
@end

@implementation CategoryCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.thumbnail = [[UIImageView alloc] init];
        self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        self.thumbnail.clipsToBounds = YES;
        [self.contentView addSubview:self.thumbnail];
        
        self.name = [[UILabel alloc] init];
        self.name.backgroundColor = [UIColor clearColor];
        self.name.textColor = [UIColor whiteColor];
        self.name.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
        self.name.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:self.name];

        self.tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 140, KScreenWidth, 0)];
        self.tagsView.tagOriginY = 4.f;
        self.tagsView.tagVerticalSpace = 4.f;
        self.tagsView.tagHeight = 30;
        self.tagsView.cornerRadius = 5;
        self.tagsView.titleColor = [UIColor whiteColor];
        self.tagsView.borderColor = [UIColor whiteColor];
        self.tagsView.type = 1;
        self.tagsView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self.contentView addSubview:self.tagsView];
    }
    return self;
}

- (void)configTag:(NSArray *)tagArr{

    [self.tagsView setTagAry:tagArr delegate:self];
}

- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(cellTagsViewButtonAction:button:)]) {
        [self.delegate cellTagsViewButtonAction:tagsView button:sender];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.thumbnail.frame = self.contentView.bounds;
    self.name.frame = self.contentView.bounds;
//    self.tagsView.frame = CGRectMake(0, self.contentView.bounds.size.height - 30, self.contentView.bounds.size.width, 0);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
//    self.thumbnail.alpha = selected ? 0.5 : 1;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageModel:(PixabayModel *)imageModel{
//    WeakSelf
    self.tagsView.hidden = NO;
    [self.thumbnail setImageWithURL:imageModel.webformatURL placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        /**   if (stage == YYWebImageStageFinished) {
            CATransform3D rotation;//3D旋转
            rotation = CATransform3DMakeTranslation(0 ,50 ,20);
            rotation = CATransform3DMakeRotation(M_PI_4 , 0.0, 0.7, 0.4);
            //逆时针旋转
            rotation = CATransform3DScale(rotation, 0.9, .9, 1);
            rotation.m34 = 1.0/ -600;
            weakSelf.layer.shadowColor = [[UIColor blackColor] CGColor];
            weakSelf.layer.shadowOffset = CGSizeMake(10, 10);
            weakSelf.alpha = 0.2;
            weakSelf.layer.transform = rotation;
            
            [UIView beginAnimations:@"rotation" context:NULL];
            //旋转时间
            [UIView setAnimationDuration:0.5];
            weakSelf.layer.transform = CATransform3DIdentity;
            weakSelf.alpha = 1;
            weakSelf.layer.shadowOffset = CGSizeMake(0, 0);
            [UIView commitAnimations];
        }
         */

    }];
    NSArray *arr = [imageModel.tags componentsSeparatedByString:@","];
    [self configTag:arr];
    NSString *tag = [[imageModel.tags componentsSeparatedByString:@","] firstObject];
    self.name.text = tag;
    
}

- (void)setWallPaperListModel:(WallPaperListModel *)wallPaperListModel{
    self.tagsView.hidden = YES;
    [self.thumbnail setImageWithURL:[NSURL URLWithString:wallPaperListModel.path] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        /**   if (stage == YYWebImageStageFinished) {
            CATransform3D rotation;//3D旋转
            rotation = CATransform3DMakeTranslation(0 ,50 ,20);
            rotation = CATransform3DMakeRotation(M_PI_4 , 0.0, 0.7, 0.4);
            //逆时针旋转
            rotation = CATransform3DScale(rotation, 0.9, .9, 1);
            rotation.m34 = 1.0/ -600;
            weakSelf.layer.shadowColor = [[UIColor blackColor] CGColor];
            weakSelf.layer.shadowOffset = CGSizeMake(10, 10);
            weakSelf.alpha = 0.2;
            weakSelf.layer.transform = rotation;
            
            [UIView beginAnimations:@"rotation" context:NULL];
            //旋转时间
            [UIView setAnimationDuration:0.5];
            weakSelf.layer.transform = CATransform3DIdentity;
            weakSelf.alpha = 1;
            weakSelf.layer.shadowOffset = CGSizeMake(0, 0);
            [UIView commitAnimations];
        }
         */

    }];
}

@end
