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