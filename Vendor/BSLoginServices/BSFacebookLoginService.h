//
//  BSFacebookLoginService.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLoginService.h"
#import "FBConnect.h"

typedef enum {
    BSFacebookLoginServiceErrorConnectionFailed = 0,
    BSFacebookLoginServiceErrorNotInitialized = 1,
    BSFacebookLoginServiceErrorFailedToRetrieveInfo = 2
} BSFacebookLoginServiceError;

@class BSFacebookLoginService;
@protocol BSFacebookLoginProvider <NSObject>
- (BSFacebookLoginService*) facebookLoginService;
@end

@protocol BSFacebookUserAuthDataSource <NSObject>
- (NSString*) facebookId;
@end

@interface BSFacebookLoginService : BSLoginService <FBSessionDelegate, FBRequestDelegate, BSUserInfoDataSource, BSFacebookUserAuthDataSource>
@property (nonatomic, retain) Facebook* facebook;
@property (nonatomic, retain) NSArray *permissions;

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSDate *birthdayDate;

@property (nonatomic, retain) NSString *facebookId;

- (id) initWithAppId:(NSString*)appId;

@end