//
//  UIView+convenienceMethod.h
//  
//
//  Created by yuanqibai on 2018/11/5.
//  Copyright © 2018 . All rights reserved.
//  说明:

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIViewLineGraditentDirectionType) {
    UIViewLineGraditentDirectionTypeFromLeftToRight,
    UIViewLineGraditentDirectionTypeFromTopToBottom
};

@interface UIView (convenienceMethod)


///  给view设置一个最大宽度，在当前宽度和字体下，最合适的size
/// @param maxWidth 最大宽度
- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth;

/**
 设置圆角与阴影共存 给self添加父视图 使self与父视图保持大小一致 之后布局就是对父视图的布局。
 
 @param cornerRadius 圆角半径
 @param shadowColor 阴影颜色
 @param x 往x轴偏移量
 @param y 往y轴偏移量
 @param shadowRadius 阴影半径
 @param opacity 阴影透明度
 @return self的父视图
 */
-(UIView *)addCornerRadius:(CGFloat)cornerRadius
               shadowColor:(UIColor *)shadowColor
             shadowOffsetX:(CGFloat)x
             shadowOffsetY:(CGFloat)y
              shadowRadius:(CGFloat)shadowRadius
             shadowOpacity:(CGFloat)opacity;

/**
 设置圆角与阴影共存 给self添加父视图 使self与父视图保持大小一致 之后布局就是对父视图的布局。
 
 @param cornerRadius 圆角半径
 @param shadowColor 阴影颜色
 @param x 往x轴偏移量
 @param y 往y轴偏移量
 @param shadowRadius 阴影半径
 @param opacity 阴影透明度
 @return self的父视图
 */
- (void)makeCornerRadius:(CGFloat)cornerRadius
               shadowColor:(UIColor *)shadowColor
             shadowOffsetX:(CGFloat)x
             shadowOffsetY:(CGFloat)y
              shadowRadius:(CGFloat)shadowRadius
             shadowOpacity:(CGFloat)opacity;


/**
 添加独立圆角，需要此时视图的大小已经确定。其次scrollView不要直接使用此方法。

 @param corners 圆角位置
 @param cornerRadiu 圆角半径
 */
-(void)addCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadiu;

/**
 给view添加渐变色

 @param colors 颜色数组，
 @param locations 渐变色位置，每个值大小必须为0-1之间，数量需要和颜色相同
 @param direction 0为从左到右➡️ 1为从上到下⬇️
 @param size 如果传0使用view当前size 如果非0则使用传入的size
 */
-(void)addLineGraditentWithColors:(NSArray<UIColor *> *)colors
                        locations:(NSArray<NSNumber *> *)locations
                        direction:(UIViewLineGraditentDirectionType)direction
                             size:(CGSize)size;


@end
