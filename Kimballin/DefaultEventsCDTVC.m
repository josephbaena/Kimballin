//
//  DefaultEventsCDTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/5/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "DefaultEventsCDTVC.h"
#import "KimballinDatabase.h"
#import "EventVC.h"
#import "Event.h"

@interface DefaultEventsCDTVC ()

@end

@implementation DefaultEventsCDTVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Staff Member"]) {
                if ([segue.destinationViewController isKindOfClass:[EventVC class]]) {
                    EventVC *vc = (EventVC *)segue.destinationViewController;
                    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
                    NSLog(@"event = %@", event);
                    [vc specifyEvent:event];
                }
            }
        }
    }
}

@end
