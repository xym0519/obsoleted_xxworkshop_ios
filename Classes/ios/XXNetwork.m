//
//  XXNetwork.m
//  IOSTester
//
//  Created by Broche Xu on 7/22/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXNetwork.h"
#import "XXFormatter.h"

@implementation XXNetwork
#pragma mark -
#pragma mark Config
+ (void)setDefaultEncoding:(NSStringEncoding)encoding {
    XXNetworkDefaultEncoding = encoding;
}

#pragma mark -
#pragma mark Http Parameters
+ (NSString *)getQueryString:(NSDictionary *)fields {
    return [XXFormatter Dictionary2String:fields withItemSplitter:@"=" withSectionSplitter:@"&"];
}

+ (NSData *)getHttpBody:(NSDictionary *)fields {
    NSString *str = [XXFormatter Dictionary2String:fields withItemSplitter:@"=" withSectionSplitter:@"&"];
    return [str dataUsingEncoding:XXNetworkDefaultEncoding];
}

+ (void)appendMultiPartField:(NSMutableData **)httpBody withName:(NSString *)name withValue:(NSString *)value withBoundary:(NSString *)boundary {
    return [self appendMultiPartField:httpBody withName:name withFileName:nil withContentType:nil withValue:[value dataUsingEncoding:XXNetworkDefaultEncoding] withBoundary:boundary];
}

+ (void)appendMultiPartField:(NSMutableData **)httpBody withName:(NSString *)name withFileName:(NSString *)fileName withContentType:(NSString *)contentType withValue:(NSData *)value withBoundary:(NSString *)boundary {
    [*httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:XXNetworkDefaultEncoding]];
    [*httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", name] dataUsingEncoding:XXNetworkDefaultEncoding]];
    if (fileName) {
        [*httpBody appendData:[[NSString stringWithFormat:@"; filename=\"%@\"", fileName] dataUsingEncoding:XXNetworkDefaultEncoding]];
    }
    [*httpBody appendData:[@"\r\n" dataUsingEncoding:XXNetworkDefaultEncoding]];
    if (contentType) {
        [*httpBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", contentType] dataUsingEncoding:XXNetworkDefaultEncoding]];
    }
    [*httpBody appendData:[@"\r\n" dataUsingEncoding:XXNetworkDefaultEncoding]];
    [*httpBody appendData:value];
    [*httpBody appendData:[@"\r\n" dataUsingEncoding:XXNetworkDefaultEncoding]];
}

#pragma mark -
#pragma mark Http Request
+ (BOOL)sendRequestWithURL:(NSString *)url returningData:(NSData **)data {
    return [self sendRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] returningData:data returningResponse:nil error:nil];
}

+ (BOOL)sendRequestWithURL:(NSString *)url returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error {
    return [self sendRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] returningData:data returningResponse:response error:error];
}

+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters returningData:(NSData **)data {
    NSString *durl = [NSString stringWithFormat:@"%@?%@", url, [self getQueryString:parameters]];
    return [self sendRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:durl]] returningData:data returningResponse:nil error:nil];
}

+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSString *durl = [NSString stringWithFormat:@"%@?%@", url, [self getQueryString:parameters]];
    return [self sendRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:durl]] returningData:data returningResponse:response error:error];
}

+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters usingMethod:(XXNetworkMethod)method returningData:(NSData **)data {
    NSURLRequest *request;
    if (method == XXPOST) {
        NSMutableURLRequest *trequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [trequest setHTTPMethod:@"POST"];
        [trequest setHTTPBody:[self getHttpBody:parameters]];
        request = trequest;
    } else {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    }
    return [self sendRequest:request returningData:data returningResponse:nil error:nil];
}

+ (BOOL)sendRequestWithURL:(NSString *)url withParameters:(NSDictionary *)parameters usingMethod:(XXNetworkMethod)method returningData:(NSData **)data returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSURLRequest *request;
    if (method == XXPOST) {
        NSMutableURLRequest *trequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [trequest setHTTPMethod:@"POST"];
        [trequest setHTTPBody:[self getHttpBody:parameters]];
        request = trequest;
    } else {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    }
    return [self sendRequest:request returningData:data returningResponse:response error:error];
}

+ (BOOL)sendRequest:(NSURLRequest *)request returningData:(NSData *__autoreleasing *)data {
    return [self sendRequest:request returningData:data returningResponse:nil error:nil];
}

+ (BOOL)sendRequest:(NSURLRequest *)request returningData:(NSData *__autoreleasing *)data returningResponse:(NSURLResponse *__autoreleasing *)response error:(NSError *__autoreleasing *)error {
    NSURLResponse *tresponse;
    NSError *terror;
    NSData *tdata = [NSURLConnection sendSynchronousRequest:request returningResponse:&tresponse error:&terror];
    if (data) {
        *data = tdata;
    }
    if (response) {
        *response = tresponse;
    }
    if (error) {
        *error = terror;
    }
#ifdef XXDEBUG_NETWORK
    XXLog(@"\nrequest: %@\nresponse: %@\n\n",request,[[NSString alloc] initWithData:tdata encoding:XXNetworkDefaultEncoding]);
#endif
    return !error;
}

@end
