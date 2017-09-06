//
//  AppDelegate+XMShare.m
//  WallPaper
//
//  Created by ccpg_it on 2017/9/6.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "AppDelegate+XMShare.h"
#import "PhotoBroswerVC.h"

@implementation AppDelegate (XMShare)

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        //        return [TencentOAuth HandleOpenURL:url];
        return [QQApiInterface handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wx"]) {
        
        PhotoBroswerVC *vc = [[PhotoBroswerVC alloc] init];;
        return [WXApi handleOpenURL:url delegate:vc];
        
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [TencentOAuth HandleOpenURL:url];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else{
        
        PhotoBroswerVC *vc = [[PhotoBroswerVC alloc] init];;
        return [WXApi handleOpenURL:url delegate:vc];
        //        ViewController *vc = (ViewController *)self.window.rootViewController;
        //        return [WXApi handleOpenURL:url delegate:vc];

    }
}

/**
 *  初始化第三方组件
 */
- (void)init3rdParty
{
    [WXApi registerApp:APP_KEY_WEIXIN];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:APP_KEY_WEIBO];
    
}

#pragma mark - 实现代理回调

/**
 *  微博
 
 @param request 请求响应
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
    
}

/**
 *  微博
 *
 *  @param response 响应体。根据 WeiboSDKResponseStatusCode 作对应的处理.
 *  具体参见 `WeiboSDKResponseStatusCode` 枚举.
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *message;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            message = @"分享成功";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            message = @"取消分享";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            message = @"分享失败";
            break;
        default:
            message = @"分享失败";
            break;
    }
    showAlert(message);
}

/**
 *  处理来至QQ的请求
 *
 *  @param req QQApi请求消息基类
 */
- (void)onReq:(QQBaseReq *)req
{
    
}

/**
 *  处理来至QQ的响应
 *
 *  @param resp 响应体，根据响应结果作对应处理
 */
- (void)onResp:(QQBaseResp *)resp
{
    NSString *message;
    if([resp.result integerValue] == 0) {
        message = @"分享成功";
    }else{
        message = @"分享失败";
    }
    showAlert(message);
}
/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
    
}


@end
