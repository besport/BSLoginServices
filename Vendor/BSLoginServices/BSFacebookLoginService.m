//
//  BSFacebookLoginService.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSFacebookLoginService.h"

@interface BSFacebookLoginService()
- (NSError*) errorWithDescription:(NSString*)description;
@end

@implementation BSFacebookLoginService
@synthesize facebook = _facebook;
@synthesize permissions = _permissions;
@synthesize email = _email;
@synthesize lastName = _lastName;
@synthesize firstName = _firstName;
@synthesize birthdayDate = _birthdayDate;

@synthesize facebookSessionToken = _facebookSessionToken;
@synthesize facebookId = _facebookId;

- (NSError*) errorWithDescription:(NSString *)description {
    NSError *err = [NSError errorWithDomain:NSLocalizedString(@"Facebook Login", @"facebook.login") code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey, nil]];
    return err;
}

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
    if (self.isLoggedIn) {
        [self succeed];
        return;
    }
    
    if (!_facebook) {
        [self failWithError:[self errorWithDescription:NSLocalizedString(@"Facebook initialization failed", @"facebook.initializationFailed")]];
    }
    
    else if (![_facebook isSessionValid]) [_facebook authorize:_permissions];
    else {
        [_facebook requestWithGraphPath:@"me" andDelegate:self];
    }
}

- (void) logout {
    if (_facebook) [_facebook logout];
    else self.isLoggedIn = NO;
}

- (void) save {
    [self saveObject:_facebook.accessToken    forKey:@"FBAccessTokenKey"];
    [self saveObject:_facebook.expirationDate forKey:@"FBExpirationDateKey"];
    [self saveObject:_facebookId              forKey:@"FBFacebookID"];
}

- (void) restore {
    self.facebookSessionToken = [self restoreObjectForKey:@"FBAccessTokenKey"];
    _facebook.accessToken     = [self restoreObjectForKey:@"FBAccessTokenKey"];
    _facebook.expirationDate  = [self restoreObjectForKey:@"FBExpirationDateKey"];
    self.facebookId           = [self restoreObjectForKey:@"FBFacebookID"];
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
    [self failWithError:[self errorWithDescription:NSLocalizedString(@"Failed to retrieve user informations", @"facebook.failedToRetrieveInfo")]];
}

- (void) fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    [_facebook requestWithGraphPath:@"me" andDelegate:self];
    self.facebookSessionToken = _facebook.accessToken;
}

- (void) fbDidLogin {
    [_facebook requestWithGraphPath:@"me" andDelegate:self];
    self.facebookSessionToken = _facebook.accessToken;
}

- (void) fbDidLogout {
    self.isLoggedIn = NO;
}

- (void) fbDidNotLogin:(BOOL)cancelled {
    [self failWithError:[self errorWithDescription:NSLocalizedString(@"Connection failed", @"facebook.connectionFailed")]];
}

- (void) fbSessionInvalidated {
    [self failWithError:[self errorWithDescription:NSLocalizedString(@"Session invalidated", @"facebook.sessionInvalidated")]];
}

@end