//
//  BSTwitterLoginService.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSTwitterLoginService.h"

@interface BSTwitterLoginService()

- (BOOL) _loginAccountSelection;
- (BOOL) _loginTwitter;
- (NSError*) errorWithDescription:(NSString*)description;

@end

@implementation BSTwitterLoginService
@synthesize accountStore = _accountStore;
@synthesize twitterAccount = _twitterAccount;
@synthesize email;
@synthesize firstName;
@synthesize lastName;
@synthesize birthdayDate;
@synthesize twitterId;
@synthesize screenName;

- (NSError*) errorWithDescription:(NSString *)description {
    NSError *err = [NSError errorWithDomain:NSLocalizedString(@"Twitter Login", @"twitter.login") code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey, nil]];
    return err;
}

/**
 * Used internally to perform the account selection
 */
- (BOOL) _loginAccountSelection {
    ACAccountType *twitterType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSArray *twitterAccounts = [_accountStore accountsWithAccountType:twitterType];
    
    // If there are no accounts, we fail
    if(twitterAccounts == nil || [twitterAccounts count] == 0) {
        [self failWithError:[self errorWithDescription:NSLocalizedString(@"No Twitter account found! You can add one in the Settings app", @"twitter.noaccount")]];
        return NO;
        
    // Else, we set the first Twitter Accountsssss
    } else self.twitterAccount = [twitterAccounts objectAtIndex:0];
    
    [self _loginTwitter];
    return YES;
}

/**
 * Do the real login operations
 */
- (BOOL) _loginTwitter {
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/account/verify_credentials.json"];
    TWRequest *req = [[TWRequest alloc] initWithURL:url parameters:nil requestMethod:TWRequestMethodGET];
    
    // Important: attach the user's Twitter ACAccount object to the request
    req.account = _twitterAccount;
    
    // Perform the request
    [req performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        // If there was an error making the request, display a message to the user
        if(error != nil) {
            [self failWithError:[self errorWithDescription:NSLocalizedString(@"Connection failed", @"twitter.connectionFailed")]];
            return;
        }
        
        // Parse the JSON response
        NSError *jsonError = nil;
        id resp = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        
        // If there was an error decoding the JSON, display a message to the user
        if(jsonError != nil) {
            [self failWithError:[self errorWithDescription:NSLocalizedString(@"Server error", @"twitter.serverError")]];
            return;
        }

        DLog(@"%@", resp);
        
        self.twitterId = [resp objectForKey:@"id_str"];
        self.screenName = [resp objectForKey:@"screen_name"];
        self.firstName = [resp objectForKey:@"name"];
        self.lastName = @"";
        self.birthdayDate = nil;
        self.email = nil; // The e-mail address isn't available through the Twitter API
        
        [self succeed];
    }];
    
    return YES;
}

/**
 * Login entry point
 */
- (void) login {
    if (self.isLoggedIn) {
        [self succeed];
        return;
    }
    
    // Create a connection to the account store
    self.accountStore = [[ACAccountStore alloc] init];
    
    // Request access to Twitter accounts
    ACAccountType *twitterType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [_accountStore requestAccessToAccountsWithType:twitterType withCompletionHandler:^(BOOL granted, NSError *error) {
        // If everything went fine, return and wait for the login to finish
        if(granted && [self _loginAccountSelection]) {
            return;
        }
        
        // Else, fail
        [self failWithError:[self errorWithDescription:NSLocalizedString(@"Login not granted", @"twitter.loginNotGranted")]];
    }];
}

// Managed by iOS, so nothing to do
- (void) logout {
    self.isLoggedIn = NO;
}

- (void) save { }
- (void) restore { }

@end
