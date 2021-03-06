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
//  BSRunKeeperLoginSegue.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/18/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSRunKeeperLoginSegue.h"
#import "BSRunKeeperLoginService.h"

@implementation BSRunKeeperLoginSegue

- (BSLoginService*) serviceForId:(NSUInteger)sid {
    BSRunKeeperLoginService* svc = [(id<BSRunKeeperLoginProvider>)[[UIApplication sharedApplication] delegate] runKeeperLoginService];
    return svc;
}

- (NSUInteger) serviceCount {
    return 1;
}

@end
