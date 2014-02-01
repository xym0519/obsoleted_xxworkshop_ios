//
//  XXFormatter.m
//  IOSTester
//
//  Created by Broche Xu on 6/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXFormatter.h"
#import "SBJson.h"

@implementation XXFormatter
#pragma mark -
#pragma mark Json
+ (id)String2Json:(NSString *)str {
    static SBJsonParser *parser;
    if (!parser) {
        parser = [[SBJsonParser alloc] init];
    }
    return [parser objectWithString:str];
}

+ (NSString *)Json2String:(id)json {
    static SBJsonWriter *writer;
    if (!writer) {
        writer = [[SBJsonWriter alloc] init];
    }
    return [writer stringWithObject:json];
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
@end
