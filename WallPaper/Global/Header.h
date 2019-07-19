//
//  Header.h
//  WallPaper
//
//  Created by Never on 2017/2/17.
//  Copyright © 2017年 Never. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define KScreenWidth self.view.frame.size.width
#define KScreenHight self.view.frame.size.height

#define isIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if (!UIEdgeInsetsEqualToEdgeInsets([UIApplication sharedApplication].delegate.window.safeAreaInsets, UIEdgeInsetsZero)) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})

#endif /* Header_h */
