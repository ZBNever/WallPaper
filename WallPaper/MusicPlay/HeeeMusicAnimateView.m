//
//  HeeeMusicAnimateView.m
//  HeeeMusicPlayingView
//
//  Created by hgy on 2017/6/26.
//  Copyright © 2017年 Apple Inc. All rights reserved.
//

#define basicDuration 0.5

#import "HeeeMusicAnimateView.h"

@interface HeeeMusicAnimateView ()
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) UIView *view3;
@property (nonatomic,strong) UIView *view4;
@property (nonatomic,assign) CGFloat basicWidth;//每个竖条view的宽度
@property (nonatomic,assign) CGFloat totalheight;//整个view的高度，8倍basicWidth
@property (nonatomic,strong) NSArray *viewArr;
@property (nonatomic,assign) BOOL isAnimate;
@property (nonatomic,assign) BOOL isFirstAnimate;

@end

@implementation HeeeMusicAnimateView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isFirstAnimate = YES;
        _viewColor = [UIColor grayColor];
        _totalWidth = 39;
        _basicWidth = _totalWidth/13.0;
        _totalheight = 8*_basicWidth;
        self.frame = CGRectMake(0, 0, _totalWidth, _totalheight);
        [self addsubviews];
    }
    return self;
}

- (void)setTotalWidth:(CGFloat)totalWidth {
    [_viewArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _totalWidth = totalWidth;
    _basicWidth = _totalWidth/13.0;
    _totalheight = 8*_basicWidth;
    self.frame = CGRectMake(0, 0, _totalWidth, _totalheight);
    [self addsubviews];
}

- (void)addsubviews {
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(_basicWidth, self.frame.size.height - 2*_basicWidth, 2*_basicWidth, 2*_basicWidth)];
    _view1.backgroundColor = _viewColor;
    _view1.layer.masksToBounds = YES;
    _view1.layer.cornerRadius = _basicWidth;
    [self addSubview:_view1];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(_view1.frame.origin.x + _view1.frame.size.width + _basicWidth, _view1.frame.origin.y, 2*_basicWidth, 2*_basicWidth)];
    _view2.backgroundColor = _viewColor;
    _view2.layer.masksToBounds = YES;
    _view2.layer.cornerRadius = _basicWidth;
    [self addSubview:_view2];
    
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(_view2.frame.origin.x + _view2.frame.size.width + _basicWidth, _view2.frame.origin.y, 2*_basicWidth, 2*_basicWidth)];
    _view3.backgroundColor = _viewColor;
    _view3.layer.masksToBounds = YES;
    _view3.layer.cornerRadius = _basicWidth;
    [self addSubview:_view3];
    
    _view4 = [[UIView alloc] initWithFrame:CGRectMake(_view3.frame.origin.x + + _view3.frame.size.width + _basicWidth, _view3.frame.origin.y, 2*_basicWidth, 2*_basicWidth)];
    _view4.backgroundColor = _viewColor;
    _view4.layer.masksToBounds = YES;
    _view4.layer.cornerRadius = _basicWidth;
    [self addSubview:_view4];
    
    _viewArr = @[_view1,_view2,_view3,_view4];
}

- (void)animate1:(BOOL)flag {
    [UIView animateWithDuration:basicDuration animations:^{
        if (flag) {
            self->_view1.frame = CGRectMake(self->_view1.frame.origin.x, self->_view1.frame.origin.y, self->_view1.frame.size.width, 2*self->_basicWidth);
        }else{
            self->_view1.frame = CGRectMake(self->_view1.frame.origin.x, self->_view1.frame.origin.y, self->_view1.frame.size.width, self->_totalheight);
        }
        self->_view1.frame = CGRectMake(self->_view1.frame.origin.x, self.frame.size.height - self->_view1.frame.size.height, self->_view1.frame.size.width, self->_view1.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animate1:!flag];
        }else{
            self->_view1.frame = CGRectMake(self->_view1.frame.origin.x, self.frame.size.height - 2*self->_basicWidth, self->_view1.frame.size.width, 2*self->_basicWidth);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self animate1:!flag];
            });
        }
    }];
}

- (void)animate2:(BOOL)flag {
    [UIView animateWithDuration:basicDuration - 0.04 animations:^{
        if (flag) {
            self->_view2.frame = CGRectMake(self->_view2.frame.origin.x, self->_view2.frame.origin.y, self->_view2.frame.size.width, 2*self->_basicWidth);
        }else{
            self->_view2.frame = CGRectMake(self->_view2.frame.origin.x, self->_view2.frame.origin.y, self->_view2.frame.size.width, self->_totalheight);
        }
        self->_view2.frame = CGRectMake(self->_view2.frame.origin.x, self.frame.size.height - self->_view2.frame.size.height, self->_view2.frame.size.width, self->_view2.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animate2:!flag];
        }else{
            self->_view2.frame = CGRectMake(self->_view2.frame.origin.x, self.frame.size.height - 2*self->_basicWidth, self->_view2.frame.size.width, 2*self->_basicWidth);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.3 - 0.04) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self animate2:!flag];
            });
        }
    }];
}

- (void)animate3:(BOOL)flag {
    [UIView animateWithDuration:basicDuration + 0.04 animations:^{
        if (flag) {
            self->_view3.frame = CGRectMake(self->_view3.frame.origin.x, self->_view3.frame.origin.y, self->_view3.frame.size.width, 2*self->_basicWidth);
        }else{
            self->_view3.frame = CGRectMake(self->_view3.frame.origin.x, self->_view3.frame.origin.y, self->_view3.frame.size.width, self->_totalheight);
        }
        self->_view3.frame = CGRectMake(self->_view3.frame.origin.x, self.frame.size.height - self->_view3.frame.size.height, self->_view3.frame.size.width, self->_view3.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animate3:!flag];
        }else{
            self->_view3.frame = CGRectMake(self->_view3.frame.origin.x, self.frame.size.height - 2*self->_basicWidth, self->_view3.frame.size.width, 2*self->_basicWidth);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.3 + 0.04) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self animate3:!flag];
            });
        }
    }];
}

- (void)animate4:(BOOL)flag {
    [UIView animateWithDuration:basicDuration - 0.08 animations:^{
        if (flag) {
            self->_view4.frame = CGRectMake(self->_view4.frame.origin.x, self->_view4.frame.origin.y, self->_view4.frame.size.width, 2*self->_basicWidth);
        }else{
            self->_view4.frame = CGRectMake(self->_view4.frame.origin.x, self->_view4.frame.origin.y, self->_view4.frame.size.width, self->_totalheight);
        }
        self->_view4.frame = CGRectMake(self->_view4.frame.origin.x, self.frame.size.height - self->_view4.frame.size.height, self->_view4.frame.size.width, self->_view4.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self animate4:!flag];
        }else{
            self->_view4.frame = CGRectMake(self->_view4.frame.origin.x, self.frame.size.height - 2*self->_basicWidth, self->_view4.frame.size.width, 2*self->_basicWidth);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.3 - 0.08) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self animate4:!flag];
            });
        }
    }];
}

- (void)start {
    if (_isAnimate) {
        return;
    }
    
    if (_isFirstAnimate) {
        //第一次开启动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animate1:NO];
        });
        [self animate2:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animate3:NO];
        });
        [self animate4:NO];
    }else{
        [_viewArr enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            // 时间转换
            CFTimeInterval pauseTime = view.layer.timeOffset;
            
            // 计算暂停时间
            CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;
            
            // 取消
            view.layer.timeOffset = 0;
            
            // local time相对于parent time世界的beginTime
            view.layer.beginTime = timeSincePause;
            
            // 继续
            view.layer.speed = 1;
        }];
    }
    
    _isFirstAnimate = NO;
    _isAnimate = YES;
}

- (void)stop {
    if (!_isAnimate) {
        return;
    }
    
    [_viewArr enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        CFTimeInterval pauseTime = [view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        
        // 设置layer的timeOffset, 在继续操作也会使用到
        view.layer.timeOffset = pauseTime;
        
        // localtime与parenttime的比例为0, 意味着localtime暂停了
        view.layer.speed = 0;
    }];
    
    _isAnimate = NO;
}

@end

