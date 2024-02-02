//
//  Header.h
//  WallPaper
//
//  Created by Never on 2017/2/17.
//  Copyright © 2017年 Never. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define iPhoneXSeries (([[UIApplication sharedApplication] statusBarFrame].size.height >= 44.0f) ? (YES):(NO))

#define KNavbarHight iPhoneXSeries?88:64
#define KTabbarHight iPhoneXSeries?83:49

#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHight [[UIScreen mainScreen] bounds].size.height

#define WeakSelf __weak typeof(self) weakSelf = self;

#define KEYWindow [UIApplication sharedApplication].keyWindow
#endif /* Header_h */
