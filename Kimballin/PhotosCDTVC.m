//
//  PhotosCDTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "PhotosCDTVC.h"
#import "Event.h"

@interface PhotosCDTVC ()

@end

@implementation PhotosCDTVC

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
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.predicate = nil; //all the events
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"imageName" ascending:YES selector:@selector(compare:)]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Photo"];
    
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = event.name;
    cell.detailTextLabel.text = event.location;
    
    return cell;
}


@end
