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

@class BSFacebookLoginService;
@protocol BSFacebookLoginProvider <NSObject>
- (BSFacebookLoginService*) facebookLoginService;
@end

@protocol BSFacebookUserAuthDataSource <NSObject>
- (NSString*) facebookId;
- (NSString*) facebookSessionToken;
@end

@interface BSFacebookLoginService : BSLoginService <FBSessionDelegate, FBRequestDelegate, BSUserInfoDataSource, BSFacebookUserAuthDataSource>

// Some facebook-related properties
@property (nonatomic, retain) Facebook* facebook;
@property (nonatomic, retain) NSArray *permissions;

// User information
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSDate *birthdayDate;

// Facebook information
@property (nonatomic, retain) NSString *facebookId;
@property (nonatomic, retain) NSString *facebookSessionToken;

- (id) initWithAppId:(NSString*)appId;

@end