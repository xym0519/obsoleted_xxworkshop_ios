//
//  XXNetwork.h
//  IOSTester
//
//  Created by Broche Xu on 7/22/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XXNetworkMethod) {
    XXGET = 0,
    XXPOST = 1
};

static NSStringEncoding XXNetworkDefaultEncoding = NSUTF8StringEncoding;

@interface XXNetwork : NSObject
#pragma mark -
#pragma mark Config
+ (void)setDefaultEncoding:(NSStringEncoding)encoding;

#pragma mark -
#pragma mark Http Parameters
+ (void)appendMultiPartField:(NSMutableData **)httpBody withName:(NSString *)name withValue:(NSString *)value withBoundary:(NSString *)boundary;
+ (void)appendMultiPartField:(NSMutableData **)httpBody withName:(NSString *)name withFileName:(NSString *)fileName withContentType:(NSString *)contentType withValue:(NSData *)value withBoundary:(NSString *)boundary ;

#pragma mark -
#pragma mark Http Request
+ (BOOL)sendRequestWithURL:(NSString *)url returningData:(NSData **)data;
+ (BOOL)sendRequestWithURL:(NSString *)url returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error;

+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters returningData:(NSData **)data;
+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error;

+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters usingMethod:(XXNetworkMethod)method returningData:(NSData **)data;
+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters usingMethod:(XXNetworkMethod)method returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error;

+ (BOOL)sendRequest:(NSURLRequest *)request returningData:(NSData **)data;
+ (BOOL)sendRequest:(NSURLRequest *)request returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error;
@end
