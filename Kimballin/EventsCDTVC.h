//
//  EventsCDTVC.h
//  Kimballin
//
//  Created by Joseph Baena on 6/5/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface EventsCDTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
