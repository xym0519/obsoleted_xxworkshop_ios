//
//  XXSystem.h
//  DiscuzDevelopAssistor
//
//  Created by Broche Xu on 6/25/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXSystem : NSObject
#pragma mark -
#pragma mark System Path
+ (NSString *)DocumentsPath;
+ (NSString *)HomePath;
+ (NSString *)ResourcePath;
+ (NSString *)ResourcePath:(NSString *)name withExtension:(NSString *)ext;

#pragma mark -
#pragma mark Screen
+ (CGFloat)ScreenWidth;
+ (CGFloat)ScreenHeight;

#pragma mark -
#pragma mark System Version
+ (NSString *)SystemVersion;
+ (BOOL)IsIOS5;
+ (BOOL)IsIOS6;
+ (BOOL)IsIOS7;
+ (BOOL)IsIPhone4;
+ (BOOL)IsIPhone5;

#pragma mark -
#pragma mark User Defaults
+ (void)setUserDefaults:(NSString *)key object:(id)object;
+ (id)getUserDefaults:(NSString *)key;

#pragma mark -
#pragma mark Other
+ (NSTimeInterval)TimeStamp;
+ (NSString *)DeviceId;
@end
