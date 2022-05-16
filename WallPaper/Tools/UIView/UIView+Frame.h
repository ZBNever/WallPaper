//
//  UIView+YWFTool.h
//  YWFApp
//
//  Created by Calvin Tse on 2019/7/16.
//  Copyright © 2019 Yinyan. All rights reserved.
//  说明:可以直接获取屏幕或当前view的宽高，坐标点等
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGSize size;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (assign, nonatomic, readonly) CGFloat maxX;
@property (assign, nonatomic, readonly) CGFloat minX;
@property (assign, nonatomic, readonly) CGFloat midX;
@property (assign, nonatomic, readonly) CGFloat maxY;
@property (assign, nonatomic, readonly) CGFloat minY;
@property (assign, nonatomic, readonly) CGFloat midY;
@property (assign, nonatomic, readonly) CGFloat maxW;
@property (assign, nonatomic, readonly) CGFloat maxH;

#pragma mark - 屏幕信息

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGRect)screenBounds;
+ (BOOL)isIphoneX;
+ (CGFloat)navH;
+ (CGFloat)tabH;
@end

NS_ASSUME_NONNULL_END
