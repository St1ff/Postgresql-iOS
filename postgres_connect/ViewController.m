//
//  ViewController.m
//  postgres_connect
//
//  Created by Rinat Farvazov on 10.08.12.
//  Copyright (c) 2012 stiff.rf@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "Query.h"

@implementation ViewController

static const char * COLUMN_VERSION = "version";

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    tfHost.text     = @"192.168.1.1";
    tfDatabase.text = @"db";
    tfLogin.text    = @"login";
    tfPass.text     = @"password";
    tfPort.text     = @"5432";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(IBAction) connectToDB : (id) sender
{
    [Database sharedDatabase].host = tfHost.text;
    [Database sharedDatabase].dbname = tfDatabase.text;
    [Database sharedDatabase].user = tfLogin.text;
    [Database sharedDatabase].psw = tfPass.text;
    [Database sharedDatabase].port = tfPort.text;
    
    lblVersion.text = @"Версия БД";
    
    BOOL ok = [[Database sharedDatabase] connect];
    
    if (!ok) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problem" message:@"Не удалось подключиться" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];  
        [alert show];
        
        [alert release];
    }else{
        Query *q = [[Query alloc] init];
        [q exec:@"select * from version()"];
        [q first];
        
        //lblVersion.text = [NSString stringWithCString: [q value:0] encoding: [Database sharedDatabase].encoding];
        
        @try {
            lblVersion.text = [q valueByName: COLUMN_VERSION];
        }
        @catch (NSException *exception) {
            NSLog(@"Unknown column");
        }
     
        
        //lblVersion.text = [q valueCross: 0 : 0];
        
        [q exec:@"select * from pg_database"];
        while ([q next]) {
            NSLog(@"name %@", [NSString stringWithUTF8String:[q value: 0]]);
        }
        
        [q release];
    }
        
}

@end
