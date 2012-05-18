//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

//
//  FXHomeViewController.m
//  LoginServices
//
//  Created by François-Xavier Thomas on 5/11/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "FXHomeViewController.h"
#import "FXAppDelegate.h"
#import "BSFacebookLoginService.h"
#import "BSTwitterLoginService.h"

@interface FXHomeViewController ()

@end

@implementation FXHomeViewController
@synthesize uiHelloLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Check out the user's name
    FXAppDelegate *appDelegate = (FXAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.facebookLoginService.isLoggedIn) {
        uiHelloLabel.text = [NSString stringWithFormat:@"Hello, %@!", appDelegate.facebookLoginService.firstName];
    } else if (appDelegate.twitterLoginService.isLoggedIn) {
        uiHelloLabel.text = [NSString stringWithFormat:@"Hello, @%@!", appDelegate.twitterLoginService.screenName];
    } else if (appDelegate.linkedInLoginService.isLoggedIn) {
        uiHelloLabel.text = [NSString stringWithFormat:@"Hello, %@!", appDelegate.linkedInLoginService.firstName];
    } else if (appDelegate.runKeeperLoginService.isLoggedIn) {
        uiHelloLabel.text = [NSString stringWithFormat:@"Hello, %@!", appDelegate.runKeeperLoginService.firstName];
    }
}

- (void)viewDidUnload
{
    [self setUiHelloLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
