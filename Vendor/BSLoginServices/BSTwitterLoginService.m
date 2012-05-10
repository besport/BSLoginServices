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

@end

@implementation BSTwitterLoginService
@synthesize accountStore = _accountStore;
@synthesize twitterAccount = _twitterAccount;
@synthesize twitterData = _twitterData;

/**
 * Used internally to perform the account selection
 */
- (BOOL) _loginAccountSelection {
    ACAccountType *twitterType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSArray *twitterAccounts = [_accountStore accountsWithAccountType:twitterType];
    
    // If there are no accounts, we fail
    if(twitterAccounts == nil || [twitterAccounts count] == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self failWithError:BSTwitterLoginServiceErrorNoAccounts];
        });
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self failWithError:BSTwitterLoginServiceErrorConnectionFailed];
            });
            return;
        }
        
        // Parse the JSON response
        NSError *jsonError = nil;
        id resp = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        
        // If there was an error decoding the JSON, display a message to the user
        if(jsonError != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self failWithError:BSTwitterLoginServiceErrorParsingError];
            });
            return;
        }
        
        // Make sure to perform our operation back on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.twitterData = resp;
            [self succeed];
        });
    }];
    
    return YES;
}

/**
 * Login entry point
 */
- (void) login {
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self failWithError:BSTwitterLoginServiceErrorNotGranted];
        });
    }];
    
}

- (NSString*) localizedErrorMessage:(NSUInteger)errorCode {
    switch (errorCode) {
        case BSTwitterLoginServiceErrorNoAccounts:
            return NSLocalizedString(@"You can add a Twitter account in the Settings app.", @"loginservice.twitter.noaccount.message");
        case BSTwitterLoginServiceErrorConnectionFailed:
            return NSLocalizedString(@"Connection failed", @"loginservice.twitter.failed.message");
        case BSTwitterLoginServiceErrorNotGranted:
            return NSLocalizedString(@"Permission not granted", @"loginservice.twitter.notgranted.message");
        case BSTwitterLoginServiceErrorParsingError:
            return NSLocalizedString(@"Server error", @"loginservice.twitter.parseerror.message");
        default:
            return [super localizedErrorMessage:errorCode];
    }
}

- (NSString*) localizedErrorTitle:(NSUInteger)errorCode {
    switch (errorCode) {
        case BSTwitterLoginServiceErrorNoAccounts:
            return NSLocalizedString(@"No Twitter account", @"loginservice.twitter.noaccount.title");
        case BSTwitterLoginServiceErrorConnectionFailed:
            return NSLocalizedString(@"Twitter Login", @"loginservice.twitter.title");
        case BSTwitterLoginServiceErrorNotGranted:
            return NSLocalizedString(@"Twitter Login", @"loginservice.twitter.title");
        case BSTwitterLoginServiceErrorParsingError:
            return NSLocalizedString(@"Twitter Login", @"loginservice.twitter.title");
        default:
            return [super localizedErrorMessage:errorCode];
    }
}

// Managed by iOS, so nothing to do
- (void) logout { }
- (void) save { }
- (void) restore { }

@end
