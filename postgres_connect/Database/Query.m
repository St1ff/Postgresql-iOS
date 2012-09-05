//
//  Query.m
//  libpq-ios
//
//  Created by Ринат on 20.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Query.h"

@implementation Query

@synthesize database;
@synthesize textError = textError_;


-(id) init
{
    if (self = [super init]) {
        database = NULL;   
        currentRow = -1;
    }
    
    return self;
}

-(void) dealloc
{
    [textError_ release];
    
    PQclear(res);
    res = NULL;
    
    [super dealloc];
}

-(BOOL) exec
{
    return false;
}

-(BOOL) exec: (NSString*) query
{
    currentRow = -1;
    textError_ = @"";
    PQclear(res);
    
    res = PQexec([Database sharedDatabase].connection, [query cStringUsingEncoding: [Database sharedDatabase].encoding]);
    
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        textError_ = [NSString stringWithUTF8String:PQerrorMessage([Database sharedDatabase].connection)];
        return false;
    }
    
    return true;
}

-(BOOL) first
{
    if (PQntuples(res) == 0) return false;
    
    currentRow = 0;
    return true;
}

-(BOOL) last
{
    if (PQntuples(res) == 0) return false;
    
    currentRow = PQntuples(res);
    return true;
}

-(BOOL) next
{
    if (PQntuples(res) == 0) return false;
    
    ++currentRow;
    
    return currentRow < PQntuples(res);
}

-(BOOL) previous
{
    return false;
}

-(int) rowCount
{
    return PQntuples(res);
}

-(int) fieldCount
{
    return PQnfields(res);
}

-(char*) value: (int) fieldNumber
{
    if (currentRow == -1) return "";
        
    return PQgetvalue(res, currentRow, fieldNumber);
}

-(NSString*) valueByName: (const char*) fieldName
{
    int number = PQfnumber(res, fieldName);
    
    if (number == -1) 
        @throw [NSException exceptionWithName:@"NoColumnException" reason: @"Column is not exist" userInfo:nil];
    
    return [NSString stringWithCString:  PQgetvalue(res, currentRow, number) encoding: [Database sharedDatabase].encoding];
}

-(NSString*) valueCross: (int) row: (int) column
{
    if (row > -1 && row < PQntuples(res) &&
        column > -1 && column < PQnfields(res)) {
      return [NSString stringWithCString: PQgetvalue(res, row, column) encoding:[Database sharedDatabase].encoding];
    }
    
    return @"";
     
}

@end
