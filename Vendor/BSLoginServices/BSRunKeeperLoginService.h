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
//  BSRunKeeperLoginService.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/18/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginService.h"

typedef enum {
    BSRunKeeperLoginServiceStatusLogin,
    BSRunKeeperLoginServiceStatusProfile,
    BSRunKeeperLoginServiceStatusCheckToken,
    BSRunKeeperLoginServiceStatusIdle
} BSRunKeeperLoginServiceStatus;

@class BSRunKeeperLoginService, GTMOAuth2ViewControllerTouch;
@protocol BSRunKeeperUserAuthDataSource <NSObject>
- (NSString*) runKeeperId;
@end

@protocol BSRunKeeperLoginProvider <NSObject>
- (BSRunKeeperLoginService*) runKeeperLoginService;
@end

@interface BSRunKeeperLoginService : BSLoginService <BSUserInfoDataSource, BSRunKeeperUserAuthDataSource>
// RunKeeper API tokens
@property (nonatomic, retain) NSString *clientId;
@property (nonatomic, retain) NSString *clientSecret;
@property (nonatomic, retain) GTMOAuth2ViewControllerTouch *loginViewController;

// User info
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSDate *birthdayDate;
@property (nonatomic, retain) NSString *runKeeperId;

- (id) initWithClientId:(NSString*)clientId secret:(NSString*)clientSecret;

@end
