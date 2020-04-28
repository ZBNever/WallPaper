//
//  CommentNode.m
//  yu
//
//  Created by  atide on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

#import "CommentNode.h"

@implementation CommentNode
- (id)initWithCatalog:(CGPDFDictionaryRef)dictionary
{
    self = [self init];
    if (self == nil)
        return nil;
    
    type = kCGPDFObjectTypeDictionary;
    catalog = dictionary;
    
    return self;
}

/* Initialize a VoyeurNode with a PDF object. */

- (id)initWithObject:(CGPDFObjectRef)obj name:(NSString *)string
{
    self = [self init];
    if (self == nil)
        return nil;
    
    object = obj;
    name = [string copy];
    type = CGPDFObjectGetType(object);
    
    return self;
}

- (NSString *)name
{
    return name;
}

- (CGPDFObjectType)type
{
    return type;
}

- (NSString *)typeAsString
{
    switch (type) {
        case kCGPDFObjectTypeBoolean:
            return @"Boolean";
        case kCGPDFObjectTypeInteger:
            return @"Integer";
        case kCGPDFObjectTypeReal:
            return @"Real";
        case kCGPDFObjectTypeName:
            return @"Name";
        case kCGPDFObjectTypeString:
            return @"String";
        case kCGPDFObjectTypeArray:
            return @"Array";
        case kCGPDFObjectTypeDictionary:
            return @"Dictionary";
        case kCGPDFObjectTypeStream:
            return @"Stream";
        case kCGPDFObjectTypeNull:
        default:
            return nil;
    }
}

- (CGPDFObjectRef)object
{
    return object;
}

- (NSString *)value
{
    const char *n;
    CGPDFReal real;
    CGPDFInteger integer;
    CGPDFBoolean boolean;
    CGPDFStringRef string;
    
    switch (type) {
        case kCGPDFObjectTypeNull:
            return @"null";
            
        case kCGPDFObjectTypeBoolean:
            CGPDFObjectGetValue(object, type, &boolean);
            return boolean ? @"true" : @"false";
            
        case kCGPDFObjectTypeInteger:
            CGPDFObjectGetValue(object, type, &integer);
            return [NSString stringWithFormat:@"%d", (int)integer];
            
        case kCGPDFObjectTypeReal:
            CGPDFObjectGetValue(object, type, &real);
            return [NSString stringWithFormat:@"%g", (double)real];
            
        case kCGPDFObjectTypeName:
            CGPDFObjectGetValue(object, type, &n);
            return [NSString stringWithFormat:@"/%s", n];
            
        case kCGPDFObjectTypeString:
            CGPDFObjectGetValue(object, type, &string);
            return (__bridge NSString *)CGPDFStringCopyTextString(string);
            
        case kCGPDFObjectTypeArray:
        case kCGPDFObjectTypeDictionary:
        case kCGPDFObjectTypeStream:
        default:
            return @"";
    }
}

static void
addItems(const char *key, CGPDFObjectRef object, void *info)
{
    NSString *string;
    NSMutableArray *children;
    CommentNode *node;
    
    children = (__bridge NSMutableArray *)(info);
    string = [[NSString alloc] initWithFormat:@"/%s", key];
    node = [[CommentNode alloc] initWithObject:object name:string];
    if (node != nil) {
        [children addObject:node];
    }
}

- (NSArray *)children
{
    size_t k, count;
    CGPDFObjectRef obj;
    CGPDFArrayRef array;
    CGPDFStreamRef stream;
    CGPDFDictionaryRef dict;
    NSString *string;
    CommentNode *node;
    
    if (children != nil)
        return children;
    
    switch (type) {
        case kCGPDFObjectTypeArray:
            CGPDFObjectGetValue(object, kCGPDFObjectTypeArray, &array);
            count = CGPDFArrayGetCount(array);
            children = [[NSMutableArray alloc] initWithCapacity:count];
            for (k = 0; k < count; k++) {
                CGPDFArrayGetObject(array, k, &obj);
                string = [[NSString alloc] initWithFormat:@"%d", (int)k];
                node = [[CommentNode alloc] initWithObject:obj name:string];
                if (node != nil) {
                    [children addObject:node];
                }
            }
            break;
            
        case kCGPDFObjectTypeDictionary:
            if (catalog != nil) {
                dict = catalog;
            } else {
                CGPDFObjectGetValue(object, kCGPDFObjectTypeDictionary, &dict);
            }
            count = CGPDFDictionaryGetCount(dict);
            children = [[NSMutableArray alloc] initWithCapacity:count];
            CGPDFDictionaryApplyFunction(dict, &addItems, (__bridge void *)(children));
            break;
            
        case kCGPDFObjectTypeStream:
            CGPDFObjectGetValue(object, kCGPDFObjectTypeStream, &stream);
            dict = CGPDFStreamGetDictionary(stream);
            count = CGPDFDictionaryGetCount(dict);
            children = [[NSMutableArray alloc] initWithCapacity:count];
            CGPDFDictionaryApplyFunction(dict, &addItems, (__bridge void *)(children));
            break;
            
        default:
            return nil;
    }
    
    return children;
}

- (CommentNode *)childrenForName:(NSString *)key
{
    NSArray *_children = [self children];
    for (CommentNode *node in _children) {
        if ([node.name isEqualToString:key]) {
            return node;
        }
    }
    return nil;
}


@end
