//
//  BSStringValidator.m
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/17/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import "BSStringValidator.h"

@implementation BSStringValidator

+ (BOOL) validateEmail:(NSString *)string {
    // Check if email is valid
    // See: http://cocoawithlove.com/2009/06/verifying-that-string-is-email-address.html
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regexp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regexp evaluateWithObject:string];
}

+ (BOOL) validateNonEmpty:(NSString *)string {
    return (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]);
}

@end
