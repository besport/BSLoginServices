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
    BSFacebookLoginServiceErrorNotInitialized = 1
} BSFacebookLoginServiceError;

@class BSFacebookLoginService;
@protocol BSFacebookLoginProvider <NSObject>
- (BSFacebookLoginService*) facebookLoginService;
@end

@interface BSFacebookLoginService : BSLoginService <FBSessionDelegate>
@property (nonatomic, retain) Facebook* facebook;
@property (nonatomic, retain) NSArray *permissions;

- (id) initWithAppId:(NSString*)appId;

@end