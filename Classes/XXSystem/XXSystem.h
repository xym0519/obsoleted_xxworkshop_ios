//
//  XXSystem.h
//  xxworkshop_ios
//
//  Created by Broche Xu on 2/4/14.
//  Copyright (c) 2014 xxworkshop. All rights reserved.
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
#pragma mark Graphics
+ (UIImage *)getImageFromView:(UIView *)view;
+ (UIImage *)modifyImage:(UIImage *)originImg addImage:(UIImage *)newImg atPosition:(CGPoint)position;
+ (UIImage *)cutImage:(UIImage *)image in:(CGRect)rect;

#pragma mark -
#pragma mark Other
+ (NSTimeInterval)TimeStamp;
+ (NSString *)DeviceId;
@end
