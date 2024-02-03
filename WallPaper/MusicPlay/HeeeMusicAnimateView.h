//
//  HeeeMusicAnimateView.h
//  HeeeMusicPlayingView
//
//  Created by hgy on 2017/6/26.
//  Copyright © 2017年 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeeeMusicAnimateView : UIView
@property (nonatomic,strong) UIColor *viewColor;//竖条的颜色
@property (nonatomic,assign) CGFloat totalWidth;//整个view的宽度，默认39
@property (nonatomic,assign,readonly) BOOL isAnimate;
- (void)start;
- (void)stop;

@end
