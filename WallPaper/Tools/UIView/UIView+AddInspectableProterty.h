//
//  UIView+AddInspectableProterty.h
//  
//
//  Created by yuanqibai on 2017/11/8.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddInspectableProterty)

/// 圆角半径 设置这个值的话 默认会将masktobounds设置为yes
@property (assign,nonatomic)IBInspectable CGFloat  cornerRadius;

/**
 边框宽度 
 */
@property (assign,nonatomic)IBInspectable CGFloat  borderWidth;

/// 边框颜色
@property (nonatomic, strong) IBInspectable UIColor  * borderColor;

#pragma mark - 设置阴影的相关属性

///全称：cornerRadiusWithNoClip 设置圆角半径但是不clip 当需要设置圆角和阴影的时候设置这个属性，而不是cornerRadius
@property (nonatomic, assign) IBInspectable CGFloat  cRNoClip;
///设置阴影偏移量
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;
///设置阴影不透明度
@property (nonatomic, assign) IBInspectable CGFloat  shadowOpacity;
///阴影颜色
@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
///阴影半径
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;


@end
