//
//  XXLog.h
//  xxworkshop_ios
//
//  Created by Broche Xu on 2/4/14.
//  Copyright (c) 2014 xxworkshop. All rights reserved.
//

#ifndef XXLogDebug
#warning should define log debug flag
#define XXLogDebug YES
#endif

#if XXLogDebug
#define XXLog(f,...) NSLog(@"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(f), ##__VA_ARGS__] )
#else
#define XXLog(f,...)
#endif