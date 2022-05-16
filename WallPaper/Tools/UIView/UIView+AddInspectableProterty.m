//
//  UIView+AddInspectableProterty.m
//  
//
//  Created by yuanqibai on 2017/11/8.
//  Copyright © 2017年 . All rights reserved.
//

#import "UIView+AddInspectableProterty.h"

@implementation UIView (AddInspectableProterty)


#pragma mark - 圆角半径
-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    self.layer.cornerRadius = cornerRadius;
    //设置遮罩到Bounds  区域外的地方不显示  如果设置阴影 阴影将看不到
    self.layer.masksToBounds = YES;
    
}

-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

#pragma mark - 边框宽度
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
-(CGFloat)borderWidth{
    return self.layer.borderWidth;
}
#pragma mark - 边框颜色
-(UIColor *)borderColor{
    
    return [UIColor colorWithCGColor: self.layer.borderColor ];
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

#pragma mark - 阴影相关
-(void)setCRNoClip:(CGFloat)cornerRadiusWithNoClip{
    self.layer.cornerRadius = cornerRadiusWithNoClip;
}
-(CGFloat)cRNoClip{
    return self.layer.cornerRadius;
}

-(void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
-(CGSize)shadowOffset{
    return self.layer.shadowOffset;
}

-(void)setShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}
- (CGFloat)shadowOpacity{
    return self.layer.shadowOpacity;
}

-(void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
-(UIColor *)shadowColor{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}
-(void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
-(CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
@end
