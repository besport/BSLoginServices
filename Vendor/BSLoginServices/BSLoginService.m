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
@synthesize dataSource = _dataSource;
@synthesize shouldSignupAutomatically;

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

- (void) failWithError:(NSError*)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isLoggedIn = NO;
        [self save];
        [self.delegate loginServiceDidFail:self error:error];
        self.delegate = nil;
    });
}

- (void) saveObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (object) [defaults setObject:object forKey:key];
    else [defaults removeObjectForKey:key];
    
    [defaults synchronize];
}

- (id) restoreObjectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - Methods to implement in subclasses

- (void) login {
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

- (void) signup {
    NSLog(@"LoginProvider: Not Implemented");
}

@end
