//
//  BSTwitterLoginService.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginService.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

typedef enum {
    BSTwitterLoginServiceErrorConnectionFailed = 0,
    BSTwitterLoginServiceErrorNoAccounts = 1,
    BSTwitterLoginServiceErrorParsingError = 2,
    BSTwitterLoginServiceErrorNotGranted = 3
} BSTwitterLoginServiceError;

@class BSTwitterLoginService;
@protocol BSTwitterLoginProvider <NSObject>
- (BSTwitterLoginService*) twitterLoginService;
@end

@protocol BSTwitterUserAuthDataSource <NSObject>
- (NSString*) twitterId;
@end

@interface BSTwitterLoginService : BSLoginService <BSUserInfoDataSource, BSTwitterUserAuthDataSource>
@property (nonatomic, retain) ACAccountStore *accountStore;
@property (nonatomic, retain) ACAccount *twitterAccount;
@property (nonatomic, retain) NSDictionary *twitterData;

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSDate *birthdayDate;
@property (nonatomic, retain) NSString *screenName;

@property (nonatomic, retain) NSString *twitterId;

@end
