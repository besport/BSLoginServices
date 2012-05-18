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
//  FXAppDelegate.h
//  LoginServices
//
//  Created by François-Xavier Thomas on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSLoginServices.h"

@interface FXAppDelegate : UIResponder <UIApplicationDelegate, BSFacebookLoginProvider, BSTwitterLoginProvider, BSLinkedInLoginProvider, BSRunKeeperLoginProvider>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) BSFacebookLoginService *facebookLoginService;
@property (nonatomic, retain) BSTwitterLoginService *twitterLoginService;
@property (nonatomic, retain) BSLinkedInLoginService *linkedInLoginService;
@property (nonatomic, retain) BSRunKeeperLoginService *runKeeperLoginService;

@end
