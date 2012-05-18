//
//  BSRunKeeperLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/18/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSRunKeeperLoginSegue.h"
#import "BSRunKeeperLoginService.h"

@implementation BSRunKeeperLoginSegue

- (BSLoginService*) serviceForId:(NSUInteger)sid {
    BSRunKeeperLoginService* svc = [(id<BSRunKeeperLoginProvider>)[[UIApplication sharedApplication] delegate] runKeeperLoginService];
    return svc;
}

- (NSUInteger) serviceCount {
    return 1;
}

@end
