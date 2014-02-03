//
//  XXSystem.m
//  xxworkshop_ios
//
//  Created by Broche Xu on 2/4/14.
//  Copyright (c) 2014 xxworkshop. All rights reserved.
//

#import "XXSystem.h"
#import "XXGenerator.h"
#import <SSKeychain.h>

@implementation XXSystem
#pragma mark -
#pragma mark System Path
+ (NSString *)HomePath {
    return NSHomeDirectory();
}

+ (NSString *)DocumentsPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)ResourcePath {
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)ResourcePath:(NSString *)name withExtension:(NSString *)ext {
    return [[NSBundle mainBundle] pathForResource:name ofType:ext];
}

#pragma mark -
#pragma mark Screen
+ (CGFloat)ScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)ScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

#pragma mark -
#pragma mark System Version
+ (NSString *)SystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (BOOL)IsIOS5 {
    return [[[self SystemVersion] substringToIndex:1] isEqualToString:@"5"];
}

+ (BOOL)IsIOS6 {
    return [[[self SystemVersion] substringToIndex:1] isEqualToString:@"6"];
}

+ (BOOL)IsIOS7 {
    return [[[self SystemVersion] substringToIndex:1] isEqualToString:@"7"];
}

+ (BOOL)IsIPhone4 {
    return [self ScreenHeight]-568 < 0;
}

+ (BOOL)IsIPhone5 {
    return [self ScreenHeight]-568 == 0;
}

#pragma mark -
#pragma mark User Defaults
+ (void)setUserDefaults:(NSString *)key object:(id)object {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (id)getUserDefaults:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

#pragma mark -
#pragma mark Other
+ (NSTimeInterval)TimeStamp {
    return [[[NSDate alloc] init] timeIntervalSince1970];
}

+ (NSString *)DeviceId {
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    NSString *deviceId = [SSKeychain passwordForService:service account:@"deviceid"];
    if (!deviceId) {
        deviceId = [XXGenerator generateUUID];
        if (![SSKeychain setPassword:deviceId forService:service account:@"deviceid"]) {
            deviceId = nil;
        }
    }
    return deviceId;
}
@end
