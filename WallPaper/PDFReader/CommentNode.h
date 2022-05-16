//
//  CommentNode.h
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommentNode : NSObject{
    CGPDFObjectType type;
    CGPDFObjectRef object;
    CGPDFDictionaryRef catalog;
    NSString *name;
    NSMutableArray *children;
}

- (id)initWithCatalog:(CGPDFDictionaryRef)value;
- (id)initWithObject:(CGPDFObjectRef)value name:(NSString *)name;

- (NSString *)name;
- (CGPDFObjectType)type;
- (NSString *)typeAsString;
- (CGPDFObjectRef)object;
- (NSString *)value;
- (NSArray *)children;
- (CommentNode *)childrenForName:(NSString *)key;

@end
