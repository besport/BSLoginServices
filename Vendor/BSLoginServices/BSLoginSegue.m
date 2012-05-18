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
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.domain message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        NSLog(@"LoginSegue: Unknown error");
    }
    
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
