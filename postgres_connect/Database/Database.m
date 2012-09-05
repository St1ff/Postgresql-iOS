//
//  Database.m
//  libpq-ios
//
//  Created by Ринат on 17.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Database.h"

@implementation Database

@synthesize connection = conn;
@synthesize textError = textError_;
@synthesize encoding;

@synthesize host;
@synthesize dbname;
@synthesize user;
@synthesize psw;
@synthesize port;

static Database *database = NULL;

-(id) init
{
    conn = nil;
    
    if (self = [super init]) {
      self.encoding = NSUTF8StringEncoding;
    }
    
    return self;
}

-(void) dealloc
{
    PQfinish(conn);
    conn = NULL;
    
    [textError_ release];
    
    self.host = nil;
    self.dbname = nil;
    self.user = nil;
    self.psw = nil;
    self.port = nil;
    
    [database release];
    database = NULL;
    
    [super dealloc];
}

+(Database*) sharedDatabase
{
    if (!database || database == NULL)
        database = [Database new];
    
    return database;
}

-(BOOL) connect
{
    NSString *strconn = [NSString stringWithFormat:@"dbname = %@ host=%@ port=%@ user=%@ password=%@",
                         dbname, host, port, user, psw];
    
    PQfinish(conn);
    conn = PQconnectdb([strconn cStringUsingEncoding:encoding]);
    
    if (PQstatus(conn) != CONNECTION_OK) {
        textError_ = [NSString stringWithUTF8String: PQerrorMessage(conn)];
         NSLog(@"Connection to database failed: %@", textError_);            
    }else{
        NSLog(@"Connection is ok");
    } 
    
    return PQstatus(conn) == CONNECTION_OK;
}

-(BOOL) connect: (NSString*) host DBName: (NSString*) db 
           User: (NSString*) user Password: (NSString*) psw port: (int) port
{
    return  false;
}

@end

