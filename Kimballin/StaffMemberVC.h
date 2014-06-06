//
//  StaffMemberVC.h
//  Kimballin
//
//  Created by Joseph Baena on 6/5/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "StaffMember.h"

@interface StaffMemberVC : UIViewController <MFMailComposeViewControllerDelegate>

@property StaffMember *staffMember;

- (void)specifyStaffMember:(StaffMember *)staffMember;

@end
