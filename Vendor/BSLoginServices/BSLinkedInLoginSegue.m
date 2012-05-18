//
//  BSLinkedInLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/15/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLinkedInLoginSegue.h"
#import "BSLinkedInLoginService.h"

@implementation BSLinkedInLoginSegue

- (BSLoginService*) serviceForId:(NSUInteger)sid {
    BSLinkedInLoginService* svc = [(id<BSLinkedInLoginProvider>)[[UIApplication sharedApplication] delegate] linkedInLoginService];
    return svc;
}

- (NSUInteger) serviceCount {
    return 1;
}

@end
