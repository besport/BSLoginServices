//
//  BSLoginSegue.h
//  BeSport Mobile
//
//  Created by François-Xavier Thomas on 5/9/12.
//  Copyright (c) 2012 BeSport. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSLoginService.h"

@interface BSLoginSegue : UIStoryboardSegue <BSLoginServiceDelegate>
@property (nonatomic, retain, readwrite) BSLoginService* service;
@end