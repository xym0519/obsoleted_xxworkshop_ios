//
//  XXGenerator.m
//  xxworkshop_ios
//
//  Created by Broche Xu on 2/3/14.
//  Copyright (c) 2014 xxworkshop. All rights reserved.
//

#import "XXGenerator.h"

@implementation XXGenerator
+ (NSString *)generateUUID {
    CFUUIDRef uuid = CFUUIDCreate(nil);
    CFStringRef uuidStr = CFUUIDCreateString(nil, uuid);
    NSString *suuid = (NSString *)CFBridgingRelease(CFStringCreateCopy(nil, uuidStr));
    CFRelease(uuidStr);
    CFRelease(uuid);
    return suuid;
}
@end
