//
//  UIView+convenienceMethod.m
//
//
//  Created by yuanqibai on 2018/11/5.
//  Copyright © 2018 . All rights reserved.
//  

#import "UIView+convenienceMethod.h"

@implementation UIView (convenienceMethod)


- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize size = [self sizeThatFits:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    size.width = fmin(size.width, maxWidth); //在numberOfLine为1模式下返回的可能会比maxWidth大，所以这里我们限制下
    return size;
}

-(UIView *)addCornerRadius:(CGFloat)cornerRadius
               shadowColor:(UIColor *)shadowColor
             shadowOffsetX:(CGFloat)x
             shadowOffsetY:(CGFloat)y
              shadowRadius:(CGFloat)shadowRadius
             shadowOpacity:(CGFloat)opacity{
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    //add插入一个子视图 用来显示阴影
    UIView *shadowView = [[UIView alloc] initWithFrame:self.frame];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.frame = shadowView.bounds;
    [shadowView addSubview:self];
    shadowView.backgroundColor = self.backgroundColor;
    shadowView.layer.cornerRadius = cornerRadius;
    shadowView.layer.shadowRadius = shadowRadius;
    shadowView.layer.shadowOffset = CGSizeMake(x, y);
    shadowView.layer.shadowColor = shadowColor.CGColor;
    shadowView.layer.shadowOpacity = opacity;
    shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:shadowRadius].CGPath;
    return shadowView;
}
-(void)makeCornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor shadowOffsetX:(CGFloat)x shadowOffsetY:(CGFloat)y shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)opacity{
//        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        self.layer.cornerRadius = cornerRadius;
//        self.layer.masksToBounds = YES;
    
        CALayer *subLayer = self.layer;//[CALayer layer];

        CGRect fixframe = self.layer.frame;

//        fixframe.size.width = [UIScreen mainScreen].bounds.size.width-40;

        subLayer.frame = fixframe;

        subLayer.cornerRadius = cornerRadius;

//        subLayer.backgroundColor = [shadowColor colorWithAlphaComponent:0.5].CGColor;

        subLayer.masksToBounds = NO;

        subLayer.shadowColor = shadowColor.CGColor;

        subLayer.shadowOffset = CGSizeMake(x,y);

        subLayer.shadowOpacity = opacity;

        subLayer.shadowRadius = shadowRadius;

//        [self.layer insertSublayer:subLayer below:self.layer];
}

-(void)addCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path  = bp.CGPath;
    self.layer.mask = maskLayer;
//    self.layer.masksToBounds = YES;
}

/**
 给view添加渐变色
 
 @param colors 颜色数组，
 @param locations 渐变色位置，每个值大小必须为0-1
 @param direction 0为从左到右➡️ 1为从上到下⬇️
 @param size 如果传0使用view当前size 如果非0则使用传入的size
 */
-(void)addLineGraditentWithColors:(NSArray<UIColor *> *)colors
                        locations:(NSArray<NSNumber *> *)locations
                        direction:(UIViewLineGraditentDirectionType)direction
                             size:(CGSize)size{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGSizeEqualToSize(CGSizeZero, size)?self.bounds:(CGRect){CGPointZero,size};
    NSMutableArray *colorsMA = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsMA addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = colorsMA;
    gradientLayer.locations = locations;
    switch (direction) {
        case UIViewLineGraditentDirectionTypeFromLeftToRight:
        {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 1);
        }
            break;
        case UIViewLineGraditentDirectionTypeFromTopToBottom:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
            
        default:
            break;
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
}

@end
