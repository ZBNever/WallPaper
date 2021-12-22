//
//  UIView+HUD.h
//  EYTools
//
//  Created by 袁启柏 on 2021/4/22.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HUD)
#pragma mark - MBProgressHUD
@property (strong, nonatomic, readonly) MBProgressHUD *mbProgress;

/// 弹框消失时间 默认1.5s
@property (assign, nonatomic) NSTimeInterval  hiddenTime;

/// 弹框提示
-(void)mbShowLoading;

/// 含文字的弹框
/// @param str 提示文字
-(void)mbShowToast:(NSString*)str;

/// 自定义文字和消失时间的弹框
/// @param str 提示文字
/// @param time 延迟消失时间
-(void)mbShowToast:(NSString*)str DelayTime:(NSTimeInterval)time;


/// 在keywindow上loading
/// @param str 提示文字
-(void)mbShowLoadingTextInKeyWindow:(NSString *)str;

/// 在keyWindow上弹出带文字的提示框
/// @param str 提示文字
-(void)mbshowToastInKeyWindow:(NSString *)str;

/// 在KeyWindow上显示自定义文字的弹框提示
/// @param str 自定义文字
/// @param time 延迟消失时间
- (void)mbshowToastInKeyWindow:(NSString *)str delayTime:(NSTimeInterval)time;

/// 加载提示框
/// @param loadingText 加载提示文字
-(void)mbShowLoadingText:(NSString*)loadingText;

/// 是弹框消失
-(void)mbDismiss;

@end

NS_ASSUME_NONNULL_END
