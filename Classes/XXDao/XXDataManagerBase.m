//
//  XXDataManagerBase.m
//  xxworkshop_ios
//
//  Created by Broche Xu on 2/4/14.
//  Copyright (c) 2014 xxworkshop. All rights reserved.
//

#import "XXDataManagerBase.h"
#import "FMDatabase.h"
#import "XXLog.h"
#import "XXSystem.h"

#ifndef XXDaoDebug
#define XXDaoDebug YES
#warning should define dao debug flag
#endif

@implementation XXDataManagerBase {
    FMDatabase *db;
}

- (id)init:(NSString *)fileName {
    self = [super init];
    if (self) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *srcPath = [[XXSystem ResourcePath] stringByAppendingPathComponent:fileName];
        NSString *dstPath = [[XXSystem DocumentsPath] stringByAppendingPathComponent:fileName];
        if (![fm fileExistsAtPath:dstPath]) {
            [fm copyItemAtPath:srcPath toPath:dstPath error:nil];
        }
        db = [FMDatabase databaseWithPath:dstPath];
        if (![db open]) {
            exit(0);
        }
    }
    return self;
}

- (void)dealloc {
    [db close];
}

- (NSMutableArray *)query:(NSString *)sql {
#if XXDaoDebug
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [db executeQuery:sql];
    while([rs next]) {
        [result addObject:[rs resultDictionary]];
    }
    [rs close];
    return result;
}

- (NSDictionary *)fetch:(NSString *)sql {
#if XXDaoDebug
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    FMResultSet *rs = [db executeQuery:sql];
    NSDictionary *result = nil;
    if ([rs next]) {
        result = [rs resultDictionary];
    }
    [rs close];
    return result;
}

- (id)scalar:(NSString *)sql {
#if XXDaoDebug
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    FMResultSet *rs = [db executeQuery:sql];
    id result;
    if ([rs next]) {
        result = [rs objectForColumnIndex:0];
    } else {
        result = nil;
    }
    [rs close];
    return result;
}

- (BOOL)execute:(NSString *)sql {
#if XXDaoDebug
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    return [db executeUpdate:sql];
}

- (long long int)insert:(NSString *)sql {
#if XXDaoDebug
    XXLog(@"\nsql: %@\n\n", sql);
#endif
    [db executeUpdate:sql];
    return db.lastInsertRowId;
}

- (void)beginTransaction {
    [db beginTransaction];
}

- (void)commit {
    [db commit];
}

- (void)initTable:(NSString *)tableName withData:(NSMutableArray *)data {
    [self beginTransaction];
    [self execute:[NSString stringWithFormat:@"delete from %@",tableName]];
    for (NSMutableDictionary *row in data) {
        NSString *fields = [[NSString alloc] init];
        NSString *values = [[NSString alloc] init];
        for (NSString *key in [row allKeys]) {
            fields = [fields stringByAppendingFormat:@"%@,",key];
            values = [values stringByAppendingFormat:@"'%@',",[row objectForKey:key]];
        }
        fields = [fields substringToIndex:[fields length]-1];
        values = [values substringToIndex:[values length]-1];
        NSString *sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",tableName,fields,values];
        [self execute:sql];
    }
    [self commit];
}

-(void) batchImportable:(NSString *) tableName WithData:(NSMutableArray *) data {
    [self beginTransaction];
    [self execute:[NSString stringWithFormat:@"delete from %@",tableName]];
    for (int i=0; i<data.count; i++) {
        [self execute:[data objectAtIndex:i]];
    }
    [self commit];
}
@end
