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
//  BSTwitterLoginService.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSLoginService.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@class BSTwitterLoginService;
@protocol BSTwitterLoginProvider <NSObject>
- (BSTwitterLoginService*) twitterLoginService;
@end

@protocol BSTwitterUserAuthDataSource <NSObject>
- (NSString*) twitterId;
@end

@interface BSTwitterLoginService : BSLoginService <BSUserInfoDataSource, BSTwitterUserAuthDataSource>

// Twitter objects
@property (nonatomic, retain) ACAccountStore *accountStore;
@property (nonatomic, retain) ACAccount *twitterAccount;

// Twitter user information
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSDate *birthdayDate;
@property (nonatomic, retain) NSString *screenName;

// Twitter auth information
@property (nonatomic, retain) NSString *twitterId;

@end
