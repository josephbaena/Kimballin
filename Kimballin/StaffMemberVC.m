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
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

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

    //scale the staff photo so that it maintains original aspect ratio
    UIImage *img = [UIImage imageNamed:self.staffMember.imageName];
    UIImage *staffPhoto = [self resizeImageMaintainAspectRatio:img scaledToWidth:self.imageView.bounds.size.width];
    [self.imageView setImage:staffPhoto];
}

- (UIImage*)resizeImageMaintainAspectRatio:(UIImage*)img scaledToWidth:(float)viewWidth
{
    float oldWidth = img.size.width;
    float oldHeight = img.size.height;
    float scaleFactor = viewWidth / oldWidth;
    
    float newWidth = oldWidth * scaleFactor;
    float newHeight = oldHeight * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [img drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)phoneButtonPressed:(UIButton *)sender {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.staffMember.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)emailButtonPressed:(UIButton *)sender {
    //compose email
    NSString *subject = @"";
    NSString *body = @"";
    NSArray *recipients = [NSArray arrayWithObject:self.staffMember.email];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:subject];
    [mc setMessageBody:body isHTML:NO];
    [mc setToRecipients:recipients];
    
    if ([mc.class canSendMail]) {
        //only show the modal view if the user has an account set up
        //on his or her iOS device
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
