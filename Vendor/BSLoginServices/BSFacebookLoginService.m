//
//  BSFacebookLoginService.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSFacebookLoginService.h"

@implementation BSFacebookLoginService
@synthesize facebook = _facebook;
@synthesize permissions = _permissions;

- (id) initWithAppId:(NSString*)appId {
    self = [super init];
    
    if (self) {
        self.facebook = [[Facebook alloc] initWithAppId:appId andDelegate:self];
        self.permissions = nil;
        [self restore];
    }
    
    return self;
}

#pragma mark - Login Service methods

- (void) login {
    if (!_facebook) {
        [self failWithError:BSFacebookLoginServiceErrorNotInitialized];
    }
    
    else if (![_facebook isSessionValid]) [_facebook authorize:_permissions];
    else [self succeed];
}

- (void) logout {
    if (!_facebook) [self logoutSuccessful];
    [_facebook logout];
}

- (void) save {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[_facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void) restore {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        _facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        _facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
}

- (NSString*) localizedErrorMessage:(NSUInteger)errorCode {
    switch (errorCode) {
        case BSFacebookLoginServiceErrorNotInitialized:
            return NSLocalizedString(@"Connection not initialized", @"loginservice.facebook.notinitialized.message");
        case BSFacebookLoginServiceErrorConnectionFailed:
            return NSLocalizedString(@"Connection failed", @"loginservice.facebook.failed.message");
        default:
            return [super localizedErrorMessage:errorCode];
    }
}

- (NSString*) localizedErrorTitle:(NSUInteger)errorCode {
    switch (errorCode) {
        case BSFacebookLoginServiceErrorNotInitialized:
            return NSLocalizedString(@"Facebook Login", @"loginservice.facebook.title");
        case BSFacebookLoginServiceErrorConnectionFailed:
            return NSLocalizedString(@"Facebook Login", @"loginservice.facebook.title");
        default:
            return [super localizedErrorMessage:errorCode];
    }
}

#pragma mark - Facebook delegate

- (void) fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    [self succeed];
}

- (void) fbDidLogin {
    [self succeed];
}

- (void) fbDidLogout {
    [self logoutSuccessful];
}

- (void) fbDidNotLogin:(BOOL)cancelled {
    [self failWithError:BSFacebookLoginServiceErrorConnectionFailed];
}

- (void) fbSessionInvalidated {
    [self fail];
}

@end