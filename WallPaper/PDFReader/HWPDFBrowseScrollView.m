//
//  HWPDFBrowseScrollView.m
//  HWPDFTest
//
//  Created by sxmaps_w on 2017/12/27.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWPDFBrowseScrollView.h"

@implementation HWPDFBrowseScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return self.allowScrollScale == self.zoomScale;
}

@end
