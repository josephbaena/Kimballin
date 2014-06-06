//
//  DefaultTriviaCDTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "DefaultTriviaCDTVC.h"
#import "KimballinDatabase.h"
#import "QuestionVC.h"
#import "TriviaElement.h"

@interface DefaultTriviaCDTVC ()

@end

@implementation DefaultTriviaCDTVC

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
            if ([segue.identifier isEqualToString:@"Display Question"]) {
                if ([segue.destinationViewController isKindOfClass:[QuestionVC class]]) {
                    QuestionVC *vc = (QuestionVC *)segue.destinationViewController;
                    TriviaElement *element = [self.fetchedResultsController objectAtIndexPath:indexPath];
                    [vc specifyTriviaElement:element];
                }
            }
        }
    }
}


@end
