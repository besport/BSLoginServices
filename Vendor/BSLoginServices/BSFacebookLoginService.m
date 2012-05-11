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
@synthesize email = _email;
@synthesize lastName = _lastName;
@synthesize firstName = _firstName;
@synthesize facebookId = _facebookId;
@synthesize birthdayDate = _birthdayDate;

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
    else {
        [_facebook requestWithGraphPath:@"me" andDelegate:self];
    }
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

- (void) request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSDictionary class]])
    {
        self.email = [result objectForKey: @"email"];
        self.firstName = [result objectForKey:@"first_name"];
        self.lastName = [result objectForKey:@"last_name"];
        self.facebookId = [result objectForKey:@"id"];
        self.birthdayDate = nil;
        [self succeed];
    }
}

- (void) request:(FBRequest *)request didFailWithError:(NSError *)error {
    [self failWithError:BSFacebookLoginServiceErrorFailedToRetrieveInfo];
}

- (void) fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    [_facebook requestWithGraphPath:@"me" andDelegate:self];
}

- (void) fbDidLogin {
    [_facebook requestWithGraphPath:@"me" andDelegate:self];
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