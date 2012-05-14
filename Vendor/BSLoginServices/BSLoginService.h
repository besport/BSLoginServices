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

@end
