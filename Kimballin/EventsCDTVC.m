//
//  EventsCDTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/5/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "EventsCDTVC.h"
#import "Event.h"

@interface EventsCDTVC ()

@end

@implementation EventsCDTVC

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    [self setupFetchedResultsController];
}

- (void)setupFetchedResultsController
{
    if (!self.managedObjectContext) {
        self.managedObjectContext = nil;
    } else {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
        request.predicate = nil; //all the events
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES selector:@selector(compare:)]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Event"];
    
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.location;
    
    return cell;
}

@end
