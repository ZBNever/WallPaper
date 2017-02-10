//
//  WallPaperService.m
//  WallPaper
//
//  Created by Never on 2017/2/10.
//  Copyright © 2017年 Never. All rights reserved.
//

#import "WallPaperService.h"
#import "WallPaper.h"
#import <AFNetworking.h>

@implementation WallPaperService

+(void)requestWallpapersFromURL:(NSURL *)url completion:(WallpapersCompletion)completion{
//
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         NSLog(@"成功%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败%@",error);
//    }];

    
    
    /*
    // 快捷方式获得session对象
    NSURLSession *session = [NSURLSession sharedSession];
//    url = [NSURL URLWithString:@"http://www.daka.com/login?username=daka&pwd=123"];
    // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError* error) {
                                        NSLog(@"*****%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                    }];
    
    // 启动任务
    [task resume];
    
   */
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data.length && !connectionError) {

            NSArray *wallpapers = [self parse:data];
            completion(wallpapers,YES);
        }else{
        
            NSLog(@"Error %@",connectionError);
            completion(nil,NO);
        }
    }];
}

+ (NSArray *)parse:(NSData *)data{

    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *thumbSection = [self stringByExtractingFrom:@"<section class=\"thumb-listing-page\">" to:@"</section>" in:html];
    NSArray *thumbStrings = [thumbSection componentsSeparatedByString:@"<li><figure"];
    NSMutableArray *wallpapers = [NSMutableArray array];
    for (NSString *thumbString in thumbStrings) {
        NSString *thumbnail = [self stringByExtractingFrom:@"data-src=\"" to:@"\"" in:thumbString];
        NSString *detail = [self stringByExtractingFrom:@"href=\"" to:@"\"" in:thumbString];
        if (thumbnail && detail) {
            WallPaper *wallpaper = [[WallPaper alloc] init];
            wallpaper.thumbnail = [NSURL URLWithString:thumbnail];
            wallpaper.detail = [NSURL URLWithString:detail];
            [wallpapers addObject:wallpaper];
        }
    }
    return [wallpapers copy];
}

+ (NSString *)stringByExtractingFrom:(NSString *)startString to:(NSString *)endString in:(NSString *)source{
    NSRange startRange = [source rangeOfString:startString];
    if (startRange.length) {
        NSUInteger location = startRange.length + startRange.location;
        NSRange endRange = [source rangeOfString:endString
                                         options:0
                                           range:NSMakeRange(location, source.length-location)];
        if (endRange.length) {
            return [source substringWithRange:NSMakeRange(location,endRange.location-location)];
        }
    }
    return nil;
}




@end
