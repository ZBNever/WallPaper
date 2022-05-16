//
//  UIView+HUD.m
//  EYTools
//
//  Created by 袁启柏 on 2021/4/22.
//

#import "UIView+HUD.h"
#import <objc/runtime.h>

@implementation UIView (HUD)
#pragma mark - MBProgressHUD

/// 加载中
-(void)mbShowLoading{
    [self mbShowLoadingText:@""];
}

/// 显示自定义文字的加载弹框
/// @param str 自定义文字
-(void)mbShowToast:(NSString*)str{
    self.mbProgress.label.text=str;
    self.mbProgress.mode = MBProgressHUDModeText;
    [self addSubview:self.mbProgress];
    [self.mbProgress showAnimated:YES];
    [self.mbProgress hideAnimated:YES afterDelay:self.hiddenTime];
}

/// 自定义文字和消失时间的弹框
/// @param str 提示文字
/// @param time 延迟消失时间
-(void)mbShowToast:(NSString*)str DelayTime:(NSTimeInterval)time{
    self.mbProgress.label.text=str;
    self.mbProgress.mode = MBProgressHUDModeText;
    [self addSubview:self.mbProgress];
    [self.mbProgress showAnimated:YES];
    [self.mbProgress hideAnimated:YES afterDelay:time];
}

/// 在KeyWindow上显示自定义文字的弹框提示
/// @param str 自定义文字
-(void)mbshowToastInKeyWindow:(NSString *)str{
    [self mbshowToastInKeyWindow:str delayTime:self.hiddenTime];
}

/// 在KeyWindow上显示自定义文字的弹框提示
/// @param str 自定义文字
/// @param time 延迟消失时间
- (void)mbshowToastInKeyWindow:(NSString *)str delayTime:(NSTimeInterval)time {
    [[UIApplication sharedApplication].keyWindow addSubview:self.mbProgress];
    self.mbProgress.label.text=str;
    self.mbProgress.mode = MBProgressHUDModeText;
    [self.mbProgress showAnimated:YES];
    [self.mbProgress hideAnimated:YES afterDelay:time];
}

-(void)mbShowLoadingTextInKeyWindow:(NSString *)str{
    [[UIApplication sharedApplication].keyWindow addSubview:self.mbProgress];
    self.mbProgress.label.text=str;
    self.mbProgress.mode = MBProgressHUDModeIndeterminate;
    [self.mbProgress showAnimated:YES];
}

/// 加载提示框
/// @param loadingText 加载提示文字
-(void)mbShowLoadingText:(NSString*)loadingText{
    [self addSubview:self.mbProgress];
    self.mbProgress.label.text=loadingText;
    self.mbProgress.mode = MBProgressHUDModeIndeterminate;
    [self.mbProgress showAnimated:YES];
}

/// 自定义弹框消失时间
/// @param time 时间
-(void)mbDismissDelayTime:(NSTimeInterval)time{
    [self.mbProgress hideAnimated:YES afterDelay:time];
}

/// 弹框消失
-(void)mbDismiss{
    [self mbDismissDelayTime:0];
}

#pragma mark - getter

- (MBProgressHUD *)mbProgress{
    if (!objc_getAssociatedObject(self, _cmd)) {
        MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self];
        hub.removeFromSuperViewOnHide = YES;
        hub.label.numberOfLines = 0;
        objc_setAssociatedObject(self, @selector(mbProgress), hub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (NSTimeInterval)hiddenTime{
    NSTimeInterval hiddenTime = [objc_getAssociatedObject(self, _cmd) timeInterval];
    if (hiddenTime == 0) {
        hiddenTime = 1.5;//如果为0 则默认设置为1.5s;
    }
    return hiddenTime;
}

#pragma mark - setter

- (void)setHiddenTime:(NSTimeInterval)hiddenTime{
    objc_setAssociatedObject(self, @selector(hiddenTime), @(hiddenTime), OBJC_ASSOCIATION_ASSIGN);
}
@end
