//
//  XXDataManagerBase.h
//  xxworkshop_ios
//
//  Created by Broche Xu on 2/4/14.
//  Copyright (c) 2014 xxworkshop. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XXDataManagerBase : NSObject
- (id)init:(NSString *)fileName;
- (void)initTable:(NSString *)tableName withData:(NSMutableArray *)data;

- (NSMutableArray *)query:(NSString *)sql;
- (NSDictionary *)fetch:(NSString *)sql;
- (id)scalar:(NSString *)sql;
- (BOOL)execute:(NSString *)sql;
- (long long int)insert:(NSString *)sql;
- (void)beginTransaction;
- (void)commit;
- (void)batchImportable:(NSString *) tableName WithData:(NSMutableArray *) data;
@end
