//
//  StaffMemberVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/5/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "StaffMemberVC.h"

@interface StaffMemberVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;

@end

@implementation StaffMemberVC

- (void)specifyStaffMember:(StaffMember *)staffMember
{
    _staffMember = staffMember;
    self.title = staffMember.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.phoneLabel.text = self.staffMember.phone;
    self.emailLabel.text = self.staffMember.email;
    self.roomLabel.text = self.staffMember.room;
    
    //TODO: scale the image size
    UIImage *img = [UIImage imageNamed:self.staffMember.imageName];
    [self.imageView setImage:img];
}

@end
