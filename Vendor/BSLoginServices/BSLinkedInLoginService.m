//
//  BSLinkedInLoginService.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/15/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLinkedInLoginService.h"

@interface BSLinkedInLoginService()
- (void) loginViewDidFinish:(NSNotification*)notification;
- (void) retrieveProfile;
- (NSError*) errorWithDescription:(NSString *)description;
@end

@implementation BSLinkedInLoginService
@synthesize status = _status;
@synthesize consumerKey = _consumerKey;
@synthesize consumerSecret = _consumerSecret;
@synthesize authKey = _authKey;
@synthesize authSecret = _authSecret;

@synthesize loginView = _loginView;
@synthesize requestToken = _requestToken;

@synthesize email;
@synthesize lastName;
@synthesize firstName;
@synthesize birthdayDate;
@synthesize linkedInId;

- (NSError*) errorWithDescription:(NSString *)description {
    NSError *err = [NSError errorWithDomain:NSLocalizedString(@"LinkedIn Login", @"linkedin.login") code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey, nil]];
    return err;
}

- (id) initWithConsumerKey:(NSString *)consumerKey secret:(NSString *)consumerSecret {
    self = [super init];
    
    if (self) {
        self.consumerKey = consumerKey;
        self.consumerSecret = consumerSecret;
        self.status = BSLinkedInLoginServiceStatusIdle;
        [self restore];
    }
    
    return self;
}

#pragma mark - Login Service Methods

- (void) login {
    // If we're logged in, just succeed
    if (self.isLoggedIn) {
        [self succeed];
        return;
    }
    
    // If we have a token, but not logged in, try to authenticate with it
    if (self.authKey && ![self.authKey isEqualToString:@""] && self.authSecret && ![self.authSecret isEqualToString:@""]) {
        self.status = BSLinkedInLoginServiceStatusCheckToken;
        self.requestToken = [[OAToken alloc] initWithKey:_authKey secret:_authSecret];
        [self retrieveProfile];
        return;
    }
    
    // Else, start the login process
    self.status = BSLinkedInLoginServiceStatusLogin;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.loginView = [[OAuthLoginView alloc] initLinkedInApiKey:self.consumerKey secret:self.consumerSecret];    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginViewDidFinish:)
                                                 name:@"loginViewDidFinish"
                                               object:_loginView];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:self.loginView animated:YES];
}

- (void) logout {
    self.isLoggedIn = NO;
    self.authKey = nil;
    self.authSecret = nil;
    [self save];
    
    self.status = BSLinkedInLoginServiceStatusIdle;
}

- (void) save {
    [self saveObject:_authKey forKey:@"LIAuthKey"];
    [self saveObject:_authSecret forKey:@"LIAuthSecret"];
}

- (void) restore {
    self.authKey = [self restoreObjectForKey:@"LIAuthKey"];
    self.authSecret = [self restoreObjectForKey:@"LIAuthSecret"];
}

#pragma mark - Login View Callbacks

- (void) loginViewDidFinish:(NSNotification *)notification {
    self.requestToken = self.loginView.accessToken;

    if (self.requestToken) {
        self.status = BSLinkedInLoginServiceStatusProfile;
        [self retrieveProfile];
    }
    else {
        self.status = BSLinkedInLoginServiceStatusIdle;
        [self failWithError:[self errorWithDescription:NSLocalizedString(@"Connection failed", @"linkedin.connectionFailed")]];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
}

#pragma mark - Profile Retrieval Callbacks

- (void) retrieveProfile {
    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~:(id,firstName,lastName)"];
    OAConsumer *linkedInConsumer = [[OAConsumer alloc] initWithKey:self.consumerKey
                                                            secret:self.consumerSecret
                                                             realm:@"http://api.linkedin.com/"];
    
    
    OAMutableURLRequest *request = 
    [[OAMutableURLRequest alloc] initWithURL:url
                                    consumer:linkedInConsumer
                                       token:self.requestToken
                                    callback:nil
                           signatureProvider:nil];
    
    [request setValue:@"json" forHTTPHeaderField:@"x-li-format"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(profileApiCallResult:didFinish:)
                  didFailSelector:@selector(profileApiCallResult:didFail:)];    
}

- (void)profileApiCallResult:(OAServiceTicket *)ticket didFinish:(NSData *)data {
    NSString *responseBody = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    
    // Do some nasty copying because of JSONKit's nasty JKDictionary messing up objectForKey.
    NSDictionary *profile = [NSDictionary dictionaryWithDictionary:[responseBody objectFromJSONString]];
    
    if (profile && ![profile objectForKey:@"errorCode"]) {
        //NSLog(@"%@", profile);
        
        self.firstName = [profile objectForKey:@"firstName"];
        self.lastName = [profile objectForKey:@"lastName"];
        self.linkedInId = [profile objectForKey:@"id"];
        self.email = @""; // Can't get email from LinkedIn
        
        self.authKey = self.requestToken.key;
        self.authSecret = self.requestToken.secret;
        
        [self succeed];
    } else {
        if (self.status == BSLinkedInLoginServiceStatusProfile) {
            [self failWithError:[self errorWithDescription:NSLocalizedString(@"Failed to retrieve LinkedIn profile", @"linkedin.didNotRetrieveProfile")]];
        } else if (self.status == BSLinkedInLoginServiceStatusCheckToken) {
            NSLog(@"Token verification failed --> Classic login");
            [self logout];
            [self login];
        }
    }
    
    self.status = BSLinkedInLoginServiceStatusIdle;
}

- (void)profileApiCallResult:(OAServiceTicket *)ticket didFail:(NSData *)error 
{
    [self failWithError:[self errorWithDescription:NSLocalizedString(@"Failed to retrieve LinkedIn profile", @"linkedin.didNotRetrieveProfile")]];
}

@end