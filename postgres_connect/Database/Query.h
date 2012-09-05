//
//  Query.h
//  libpq-ios
//
//  Created by Ринат on 20.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"

@interface Query : NSObject
{
    PGresult *res;
    int currentRow;
    NSString *textError_;
}

@property (nonatomic, retain) Database *database;
@property (nonatomic, retain, readonly) NSString *textError;

-(BOOL) exec;
-(BOOL) exec: (NSString*) query;

-(BOOL) first;
-(BOOL) last;

-(BOOL) next;
-(BOOL) previous;

-(int) rowCount;
-(int) fieldCount;

-(char*) value: (int) fieldNumber;
-(NSString*) valueByName: (const char*) fieldName;
-(NSString*) valueCross: (int) row: (int) column;

@end
