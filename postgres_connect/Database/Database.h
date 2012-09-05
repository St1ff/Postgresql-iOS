//
//  Database.h
//  libpq-ios
//
//  Created by Ринат on 17.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libpq-fe.h"

@interface Database : NSObject
{
    const char *conninfo;
    PGconn     *conn;
    NSString   *textError_;
    NSString *host, *dbname, *user, *psw, *port;
}

@property (readonly) PGconn *connection;
@property (nonatomic, readonly) NSString *textError;
@property (nonatomic) NSStringEncoding encoding;

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *dbname;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *psw;
@property (nonatomic, strong) NSString *port;

+(Database*) sharedDatabase;

-(BOOL) connect;
-(BOOL) connect: (NSString*) host DBName: (NSString*) db 
           User: (NSString*) user Password: (NSString*) psw port: (int) port;

@end

