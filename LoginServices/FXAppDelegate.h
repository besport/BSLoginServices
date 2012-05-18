//
//  FXAppDelegate.h
//  LoginServices
//
//  Created by François-Xavier Thomas on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSLoginServices.h"

@interface FXAppDelegate : UIResponder <UIApplicationDelegate, BSFacebookLoginProvider, BSTwitterLoginProvider, BSLinkedInLoginProvider, BSRunKeeperLoginProvider>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) BSFacebookLoginService *facebookLoginService;
@property (nonatomic, retain) BSTwitterLoginService *twitterLoginService;
@property (nonatomic, retain) BSLinkedInLoginService *linkedInLoginService;
@property (nonatomic, retain) BSRunKeeperLoginService *runKeeperLoginService;

@end
