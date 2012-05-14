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

- (BSLoginService*) serviceForId:(NSUInteger)sid {
    BSFacebookLoginService* svc = [(id<BSFacebookLoginProvider>)[[UIApplication sharedApplication] delegate] facebookLoginService];
    return svc;
}

- (NSUInteger) serviceCount {
    return 1;
}

@end