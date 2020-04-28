//
//  SelVideoViewController.h
//  SelVideoPlayer
//
//  Created by zhuku on 2018/1/28.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelVideoViewController : UIViewController
/** 视频播放链接 */
@property (nonatomic, strong) NSString *urlStr;

/** 标题 */
@property (nonatomic, strong) NSString *titleStr;

@end
