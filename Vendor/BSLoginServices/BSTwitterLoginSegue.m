//
//  BSTwitterLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSTwitterLoginSegue.h"
#import "BSTwitterLoginService.h"

@implementation BSTwitterLoginSegue

- (BSTwitterLoginService*) service {
    BSTwitterLoginService* svc = [(id<BSTwitterLoginProvider>)[[UIApplication sharedApplication] delegate] twitterLoginService];
    self.service = svc;
    return svc;
}

@end