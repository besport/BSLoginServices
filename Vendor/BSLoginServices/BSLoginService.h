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
//  BSLoginProvider.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSLoginService;
@protocol BSLoginServiceDelegate <NSObject>
- (void) loginServiceDidSucceed:(BSLoginService*)svc;
- (void) loginServiceDidFail:(BSLoginService*)svc error:(NSError*)error;
@end

@protocol BSUserInfoDataSource <NSObject>
- (NSString*) email;
- (NSString*) firstName;
- (NSString*) lastName;
- (NSDate*) birthdayDate;
@end

@protocol BSUserAuthDataSource <NSObject>
- (NSString*) password;
- (NSString*) email;
@end

@interface BSLoginService : NSObject

// The delegate is **retained** and will be set to nil when the operation completes
@property (nonatomic, retain) id<BSLoginServiceDelegate> delegate;

@property (nonatomic, weak) id dataSource;
@property (nonatomic, assign) BOOL isLoggedIn;
@property (nonatomic, assign) BOOL shouldSignupAutomatically;

- (void) signup;
- (void) login;
- (void) logout;
- (void) save;
- (void) restore;

- (void) succeed;
- (void) failWithError:(NSError*)error;

- (void) saveObject:(id)object forKey:(NSString*)key;
- (id) restoreObjectForKey:(NSString*)key;

@end
