//
//  BSStringValidator.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/17/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSStringValidator : NSObject
+ (BOOL) validateNonEmpty:(NSString*)string;
+ (BOOL) validateEmail:(NSString*)string;
@end
