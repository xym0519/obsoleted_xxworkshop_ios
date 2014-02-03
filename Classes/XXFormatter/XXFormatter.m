//
//  XXFormatter.m
//  IOSTester
//
//  Created by Broche Xu on 6/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXFormatter.h"
#import <SBJson.h>
#import <Base64/MF_Base64Additions.h>
#import <GZIP.h>

@implementation XXFormatter
#pragma mark -
#pragma mark Json
+ (id)String2Json:(NSString *)str {
    return [[[SBJsonParser alloc] init] objectWithString:str];
}

+ (NSString *)Json2String:(id)json {
    return [[[SBJsonWriter alloc] init] stringWithObject:json];
}

#pragma mark -
#pragma mark Url
+ (NSString *)UrlEncode:(NSString *)url {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)url, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
}

+ (NSString *)UrlDecode:(NSString *)encodedUrl {
    return [encodedUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark -
#pragma mark Array/Dictionary
+ (NSString *)Array2String:(NSArray *)arr withSplitter:(NSString *)splitter {
    return [arr componentsJoinedByString:splitter];
}

+ (NSString *)Dictionary2String:(NSDictionary *)dic withItemSplitter:(NSString *)itemSplitter withSectionSplitter:(NSString *)sectionSplitter {
    NSMutableString *res = [[NSMutableString alloc] init];
    for (id key in dic.keyEnumerator) {
        [res appendFormat:@"%@%@%@%@", key, itemSplitter, [dic objectForKey:key], sectionSplitter];
    }
    if (res.length > 0) {
        [res deleteCharactersInRange:NSMakeRange(res.length-1, 1)];
    }
    return res;
}

+ (NSArray *)String2Array:(NSString *)str withSplitter:(NSString *)splitter {
    return [str componentsSeparatedByString:splitter];
}

+ (NSDictionary *)String2Dictionary:(NSString *)str withItemSplitter:(NSString *)itemSplitter withSectionSplitter:(NSString *)sectionSplitter {
    NSMutableDictionary *res = [[NSMutableDictionary alloc] init];
    BOOL valid = YES;
    NSArray *itemList = [str componentsSeparatedByString:sectionSplitter];
    for (NSString *item in itemList) {
        NSArray *itemDetails = [item componentsSeparatedByString:itemSplitter];
        if (itemDetails.count != 2) {
            valid = NO;
            break;
        } else {
            [res setObject:[itemDetails objectAtIndex:1] forKey:[itemDetails objectAtIndex:0]];
        }
    }
    if (!valid) {
        [res removeAllObjects];
    }
    return res;
}

#pragma mark -
#pragma mark CGRect/CGSize/CGPoint
+ (CGRect)CGRectFromX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height Anchor:(XXAnchor)anchor {
    CGFloat dx,dy;
    switch (anchor) {
        case XXAnchorLeftTop:
            dx = x;
            dy = y;
            break;
        case XXAnchorLeftCenter:
            dx = x;
            dy = y-height/2;
            break;
        case XXAnchorLeftBottom:
            dx = x;
            dy = y-height;
            break;
        case XXAnchorCenterTop:
            dx = x-width/2;
            dy = y;
            break;
        case XXAnchorCenter:
            dx = x-width/2;
            dy = y-height/2;
            break;
        case XXAnchorCenterBottom:
            dx = x-width/2;
            dy = y-height;
            break;
        case XXAnchorRightTop:
            dx = x-width;
            dy = y;
            break;
        case XXAnchorRightCenter:
            dx = x-width;
            dy = y-height/2;
            break;
        case XXAnchorRightBottom:
            dx = x-width;
            dy = y-height;
            break;
        default:
            dx = x;
            dy = y;
            break;
    }
    return CGRectMake(dx, dy, width, height);
}

#pragma mark -
#pragma mark Zip
+ (NSData *)Zip:(NSData *)data {
    return [data gzippedData];
}

+ (NSData *)UnZip:(NSData *)data {
    return [data gunzippedData];
}

#pragma mark -
#pragma mark Base64
+ (NSString *)Base64Encode:(NSString *)src {
    return [src base64String];
}

+ (NSString *)Base64Decode:(NSString *)src {
    return [NSString stringFromBase64String:src];
}

+ (NSString *)ZipAndBase64Encode2:(NSString *)src {
    NSData *data = [src dataUsingEncoding:NSUTF8StringEncoding];
    data = [data gzippedData];
    NSString *str = [data base64String];
    str = [str base64String];
    return str;
}
@end
