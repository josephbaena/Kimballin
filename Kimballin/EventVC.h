//
//  EventVC.h
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventVC : UIViewController

@property (strong, nonatomic) Event *event;

- (void)specifyEvent:(Event *)event;

@end
