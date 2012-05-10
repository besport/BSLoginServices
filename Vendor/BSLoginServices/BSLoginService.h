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
- (void) loginServiceDidFail:(BSLoginService*)svc error:(NSUInteger)code;
@end

@interface BSLoginService : NSObject

// The delegate is **retained** and will be set to nil when the operation completes
@property (nonatomic, retain) id<BSLoginServiceDelegate> delegate;
@property (nonatomic, assign) BOOL isLoggedIn;

- (void) login;
- (void) logout;
- (void) save;
- (void) restore;
- (NSString*) localizedErrorMessage:(NSUInteger)errorCode;
- (NSString*) localizedErrorTitle:(NSUInteger)errorCode;

- (void) fail;
- (void) failWithError:(NSUInteger)error;
- (void) succeed;
- (void) logoutSuccessful;

@end
