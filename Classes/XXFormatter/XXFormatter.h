//
//  XXFormatter.h
//  IOSTester
//
//  Created by Broche Xu on 6/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XXAnchor) {
    XXAnchorLeftTop,
    XXAnchorLeftCenter,
    XXAnchorLeftBottom,
    XXAnchorCenterTop,
    XXAnchorCenter,
    XXAnchorCenterBottom,
    XXAnchorRightTop,
    XXAnchorRightCenter,
    XXAnchorRightBottom
};

@interface XXFormatter : NSObject
#pragma mark -
#pragma mark Json
+ (id)String2Json:(NSString *)str;
+ (NSString *)Json2String:(id)json;

#pragma mark -
#pragma mark Url
+ (NSString *)UrlEncode:(NSString *)url;
+ (NSString *)UrlDecode:(NSString *)encodedUrl;

#pragma mark -
#pragma mark Array/Dictionary
+ (NSString *)Array2String:(NSArray *)arr withSplitter:(NSString *)splitter;
+ (NSString *)Dictionary2String:(NSDictionary *)dic withItemSplitter:(NSString *)itemSplitter withSectionSplitter:(NSString *)sectionSplitter;
+ (NSArray *)String2Array:(NSString *)str withSplitter:(NSString *)splitter;
+ (NSDictionary *)String2Dictionary:(NSString *)str withItemSplitter:(NSString *)itemSplitter withSectionSplitter:(NSString *)sectionSplitter;

#pragma mark -
#pragma mark CGRect/CGSize/CGPoint
+ (CGRect)CGRectFromX:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height Anchor:(XXAnchor)anchor;

#pragma mark -
#pragma mark Zip
+ (NSData *)Zip:(NSData *)data;
+ (NSData *)UnZip:(NSData *)data;

#pragma mark -
#pragma mark Base64
+ (NSString *)Base64Encode:(NSString *)src;
+ (NSString *)Base64Decode:(NSString *)src;
+ (NSString *)ZipAndBase64Encode2:(NSString *)src;
@end
