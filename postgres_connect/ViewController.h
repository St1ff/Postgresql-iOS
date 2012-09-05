//
//  ViewController.h
//  postgres_connect
//
//  Created by Rinat Farvazov on 10.08.12.
//  Copyright (c) 2012 stiff.rf@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UITextField *tfHost;
    IBOutlet UITextField *tfDatabase;
    IBOutlet UITextField *tfLogin;
    IBOutlet UITextField *tfPass;
    IBOutlet UITextField *tfPort;
    
    IBOutlet UIButton *btConn;
    
    IBOutlet UILabel *lblVersion;
}

-(IBAction) connectToDB : (id) sender;

@end
