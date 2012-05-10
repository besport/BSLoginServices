//
//  BSLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginSegue.h"

@implementation BSLoginSegue
@synthesize service = _service;

- (void) perform {
    if ([self.sourceViewController respondsToSelector:@selector(activityIndicator)]) {
        UIActivityIndicatorView *activity = [self.sourceViewController performSelector:@selector(activityIndicator)];
        [activity startAnimating];
    }
    
    [self.service setDelegate:self];
    [self.service login];
}

- (void) loginServiceDidFail:(BSLoginService *)svc error:(NSUInteger)code {
    // Display the failure
    NSString *message = [_service localizedErrorMessage:code];
    NSString *title = [_service localizedErrorTitle:code];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    // Stop the activity indicator
    if ([self.sourceViewController respondsToSelector:@selector(activityIndicator)]) {
        [[self.sourceViewController performSelector:@selector(activityIndicator)] stopAnimating];
    }
}

- (void) loginServiceDidSucceed:(BSLoginService *)svc {    
    // If no source/destination view controller, do nothing
    if (nil == self.sourceViewController || nil == self.destinationViewController) return;
    
    // Else, push the new destination controller onto the nav. controller stack
    UINavigationController *ctrl = [self.sourceViewController navigationController];
    [ctrl pushViewController:self.destinationViewController animated:YES];
    
    // Stop the activity indicator
    if ([self.sourceViewController respondsToSelector:@selector(activityIndicator)]) {
        [[self.sourceViewController performSelector:@selector(activityIndicator)] stopAnimating];
    }
}

@end
