//
//  FXNavigationController.m
//  LoginServices
//
//  Created by François-Xavier Thomas on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FXNavigationController.h"
#import "FXAppDelegate.h"

@interface FXNavigationController ()

@end

@implementation FXNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction) logout {
    FXAppDelegate *appDelegate = (FXAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.facebookLoginService logout];
    [appDelegate.twitterLoginService logout];
    [self popToRootViewControllerAnimated:YES];
}

@end
