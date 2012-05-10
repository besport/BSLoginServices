//
//  FXAppDelegate.h
//  LoginServices
//
//  Created by François-Xavier Thomas on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSFacebookLoginService.h"
#import "BSTwitterLoginService.h"

@interface FXAppDelegate : UIResponder <UIApplicationDelegate, BSFacebookLoginProvider, BSTwitterLoginProvider>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) BSFacebookLoginService *facebookLoginService;
@property (nonatomic, retain) BSTwitterLoginService *twitterLoginService;

@end
