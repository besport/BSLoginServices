//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

//
//  BSLinkedInLoginService.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/15/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginService.h"
#import "OAuthLoginView.h"
#import "OAToken.h"

@class BSLinkedInLoginService;
@protocol BSLinkedInLoginProvider <NSObject>
- (BSLinkedInLoginService*) linkedInLoginService;
@end

typedef enum {
    BSLinkedInLoginServiceStatusLogin,
    BSLinkedInLoginServiceStatusProfile,
    BSLinkedInLoginServiceStatusCheckToken,
    BSLinkedInLoginServiceStatusIdle
} BSLinkedInLoginServiceStatus;

@protocol BSLinkedInUserAuthDataSource <NSObject>
- (NSString*) linkedInId;
@end

@interface BSLinkedInLoginService : BSLoginService <BSUserInfoDataSource, BSLinkedInUserAuthDataSource>

// Status
@property (nonatomic, assign) BSLinkedInLoginServiceStatus status;

// Request token properties
@property (nonatomic, retain) NSString *consumerKey;
@property (nonatomic, retain) NSString *consumerSecret;
@property (nonatomic, retain) NSString *authKey;
@property (nonatomic, retain) NSString *authSecret;

// LinkedIn engine
@property (nonatomic, retain) OAToken *requestToken;
@property (nonatomic, retain) OAuthLoginView *loginView;

// User info
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSDate *birthdayDate;
@property (nonatomic, retain) NSString *linkedInId;

- (id) initWithConsumerKey:(NSString*)consumerKey secret:(NSString*)consumerSecret;

@end