//
//  BSLoginProvider.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginService.h"

@implementation BSLoginService
@synthesize delegate = _delegate;
@synthesize isLoggedIn = _isLoggedIn;

- (id) init {
    self = [super init];
    
    if (self) {
        _isLoggedIn = NO;
    }
    
    return self;
}

#pragma mark - Convenience methods

- (void) succeed {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isLoggedIn = YES;
        [self save];
        [self.delegate loginServiceDidSucceed:self];
        self.delegate = nil;
    });
}

- (void) logoutSuccessful {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isLoggedIn = NO;
        [self save];
        [self.delegate loginServiceDidSucceed:self];
        self.delegate = nil;
    });
}

- (void) fail {
    [self failWithError:0];
}

- (void) failWithError:(NSUInteger)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isLoggedIn = NO;
        [self save];
        [self.delegate loginServiceDidFail:self error:error];
        self.delegate = nil;
    });
}

#pragma mark - Methods to implement in subclasses

- (void) login {
    NSLog(@"LoginProvider: Not Implemented");
}

- (void) login:(id)dataSource {
    NSLog(@"LoginProvider: Not Implemented");
}

- (void) logout {
    NSLog(@"LoginProvider: Not Implemented");
}

- (void) save {
    NSLog(@"LoginProvider: Not Implemented");
}

- (void) restore {
    NSLog(@"LoginProvider: Not Implemented");
}

- (void) signup:(NSString *)password {
    NSLog(@"LoginProvider: Not Implemented");
}

- (NSString*) localizedErrorMessage:(NSUInteger)errorCode {
    return NSLocalizedString(@"An unknown error has occured", @"loginservice.unknownerror.message");
}

- (NSString*) localizedErrorTitle:(NSUInteger)errorCode {
    return NSLocalizedString(@"Login", @"loginservice.unknownerror.title");
}

@end
