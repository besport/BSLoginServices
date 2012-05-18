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

//;;;;;
//  BSRunKeeperLoginService.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/18/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSRunKeeperLoginService.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2Authentication.h"

@interface BSRunKeeperLoginService()
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error;
- (void)viewControllerDidCancelAuth:(id)sender;
@end

@implementation BSRunKeeperLoginService
@synthesize clientId = _clientId;
@synthesize clientSecret = _clientSecret;
@synthesize loginViewController;

@synthesize email;
@synthesize lastName;
@synthesize firstName;
@synthesize birthdayDate;
@synthesize runKeeperId;

- (id) initWithClientId:(NSString *)clientId secret:(NSString *)clientSecret {
    self = [super init];
    
    if (self) {
        self.clientSecret = clientSecret;
        self.clientId = clientId;
        [self restore];
    }
    
    return self;
}

- (void) login {
    NSURL *authURL = [NSURL URLWithString:@"https://runkeeper.com/apps/authorize"];
    NSURL *tokenURL = [NSURL URLWithString:@"https://runkeeper.com/apps/token"];
    NSString *redirectURI = @"runkeeper://login";
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:@"RunKeeper" tokenURL:tokenURL redirectURI:redirectURI clientID:self.clientId clientSecret:self.clientSecret];
    
    
    self.loginViewController = [[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth
                                                                 authorizationURL:authURL
                                                                 keychainItemName:nil
                                                                         delegate:self
                                                                 finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:self.loginViewController animated:YES];
    
    // Add close button
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeButton setFrame:CGRectMake(self.loginViewController.view.frame.size.width-40, 0, 40, 40)];
    [closeButton addTarget:self action:@selector(viewControllerDidCancelAuth:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginViewController.view addSubview:closeButton];
}

- (void) viewControllerDidCancelAuth:(id)sender {
    [self.loginViewController cancelSigningIn];
    [self failWithError:nil];
    [self.loginViewController dismissModalViewControllerAnimated:YES];
    self.loginViewController = nil;
}

- (void) viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {    
    if (error || !auth) {
        [self failWithError:error];
    } else {
        [self succeed];
    }
        
    [self.loginViewController dismissModalViewControllerAnimated:YES];
    self.loginViewController = nil;
    
}

@end