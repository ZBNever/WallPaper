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

#define iPhoneXSeries (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))

#define WeakSelf __weak typeof(self) weakSelf = self;

#endif /* Header_h */
