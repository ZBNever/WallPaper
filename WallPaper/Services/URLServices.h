//
//  URLServices.h
//  WallPaper
//
//  Created by Never on 2017/2/13.
//  Copyright © 2017年 Never. All rights reserved.
//

#ifndef URLServices_h
#define URLServices_h
//服务器地址
#define WallHavenURL @"https://alpha.wallhaven.cc/"
//最新
#define WallLatesURL WallHavenURL@"latest?page=%d"
//搜索
#define WallPaperSearchURL WallHavenURL@"search?q=%@&categories=100&purity=110&sorting=random&order=desc"
//缩略图
#define ThumbURL WallHavenURL@"wallpapers/thumb/small/th-%d.jpg"

#endif /* URLServices_h */
