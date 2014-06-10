//
//  DefaultStaffDirectoryCDTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/5/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "DefaultStaffDirectoryCDTVC.h"
#import "KimballinDatabase.h"
#import "StaffMemberVC.h"
#import "StaffMember.h"

@interface DefaultStaffDirectoryCDTVC ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation DefaultStaffDirectoryCDTVC


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.spinner.center=self.view.center;
    [self.spinner startAnimating];
    [self.view addSubview:self.spinner];
    
    KimballinDatabase *db = [KimballinDatabase sharedDefaultKimballinDatabase];
    if (db.managedObjectContext) {
        self.managedObjectContext = db.managedObjectContext;
    } else {
        id observer = [[NSNotificationCenter defaultCenter] addObserverForName:KimballinDatabaseAvailable
        object:db
        queue:[NSOperationQueue mainQueue]
        usingBlock:^(NSNotification *note) {
            self.managedObjectContext = db.managedObjectContext;
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        }];
    }
    [self.spinner stopAnimating];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Staff Member"]) {
                if ([segue.destinationViewController isKindOfClass:[StaffMemberVC class]]) {
                    StaffMemberVC *vc = (StaffMemberVC *)segue.destinationViewController;
                    StaffMember *staffMember = [self.fetchedResultsController objectAtIndexPath:indexPath];
                    [vc specifyStaffMember:staffMember];
                }
            }
        }
    }
}


@end
