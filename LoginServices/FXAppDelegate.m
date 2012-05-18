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
//  FXAppDelegate.m
//  LoginServices
//
//  Created by François-Xavier Thomas on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FXAppDelegate.h"

@implementation FXAppDelegate

@synthesize window = _window;
@synthesize facebookLoginService = _facebookLoginService;
@synthesize twitterLoginService = _twitterLoginService;
@synthesize linkedInLoginService = _linkedInLoginService;
@synthesize runKeeperLoginService = _runKeeperLoginService;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Start up Facebook login service
    self.facebookLoginService = [[BSFacebookLoginService alloc] initWithAppId:@"YOUR FACEBOOK APP ID"];
    self.facebookLoginService.permissions = [NSArray arrayWithObjects:@"email", nil];
    
    // Start up Twitter login service
    self.twitterLoginService = [[BSTwitterLoginService alloc] init];
    
    // Start up LinkedIn login service
    self.linkedInLoginService = [[BSLinkedInLoginService alloc] initWithConsumerKey:@"" secret:@""];
    
    // Start up RunKeeper login service
    self.runKeeperLoginService = [[BSRunKeeperLoginService alloc] initWithClientId:@"" secret:@""];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [_facebookLoginService.facebook handleOpenURL:url];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [_facebookLoginService.facebook handleOpenURL:url];
}

@end
