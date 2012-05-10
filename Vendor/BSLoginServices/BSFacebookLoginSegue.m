//
//  BSFacebookLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSFacebookLoginSegue.h"
#import "BSFacebookLoginService.h"

@implementation BSFacebookLoginSegue

- (BSFacebookLoginService*) service {
    BSFacebookLoginService* svc = [(id<BSFacebookLoginProvider>)[[UIApplication sharedApplication] delegate] facebookLoginService];
    self.service = svc;
    return svc;
}

@end