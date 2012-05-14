//
//  BSLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginSegue.h"

@interface BSLoginSegue() {
    NSUInteger currentServiceId;
}

@end

@implementation BSLoginSegue

- (BSLoginService*) serviceForId:(NSUInteger)sid {
    NSLog(@"BSLoginSegue: Not Implemented");
    return nil;
}

- (NSUInteger) serviceCount {
    NSLog(@"BSLoginSegue: Not Implemented");
    return 0;
}

- (BOOL) serviceNeedsDataSource:(NSUInteger)sid {
    NSLog(@"BSLoginSegue: Not Implemented");
    return NO;
}

- (void) perform {
    if (currentServiceId == 0) {
        // Lock the source view controller
        if ([self.sourceViewController isKindOfClass:[UIViewController class]]) {
            [(UIViewController*)self.sourceViewController view].userInteractionEnabled = NO;
        }
        
        if ([self.sourceViewController respondsToSelector:@selector(activityIndicator)]) {
            UIActivityIndicatorView *activity = [self.sourceViewController performSelector:@selector(activityIndicator)];
            [activity startAnimating];
        }
    }
    
    if (currentServiceId < [self serviceCount]) {
        [[self serviceForId:currentServiceId] setDelegate:self];
        
        if (currentServiceId == 0) [[self serviceForId:currentServiceId] setDataSource:self.sourceViewController];
        else [[self serviceForId:currentServiceId] setDataSource:[self serviceForId:currentServiceId-1]];
        
        [[self serviceForId:currentServiceId] login];
    }
}

- (void) loginServiceDidFail:(BSLoginService *)svc error:(NSError*)error {
    // Unlock the source view controller
    if ([self.sourceViewController isKindOfClass:[UIViewController class]]) {
        [(UIViewController*)self.sourceViewController view].userInteractionEnabled = YES;
    }
    
    // Display the failure
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.domain message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    // Stop the activity indicator
    if ([self.sourceViewController respondsToSelector:@selector(activityIndicator)]) {
        [[self.sourceViewController performSelector:@selector(activityIndicator)] stopAnimating];
    }
}

- (void) loginServiceDidSucceed:(BSLoginService *)svc {
    if (currentServiceId >= [self serviceCount]-1) {
        // Unlock the source view controller
        if ([self.sourceViewController isKindOfClass:[UIViewController class]]) {
            [(UIViewController*)self.sourceViewController view].userInteractionEnabled = YES;
        }
        
        // If no source/destination view controller, do nothing
        if (nil == self.sourceViewController || nil == self.destinationViewController) return;
        
        // Else, push the new destination controller onto the nav. controller stack
        UINavigationController *ctrl = [self.sourceViewController navigationController];
        [ctrl pushViewController:self.destinationViewController animated:YES];
        
        // Stop the activity indicator
        if ([self.sourceViewController respondsToSelector:@selector(activityIndicator)]) {
            [[self.sourceViewController performSelector:@selector(activityIndicator)] stopAnimating];
        }
    } else {
        currentServiceId++;
        [self perform];
    }
}

@end
