//
//  StaffDirectoryCDTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/3/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "StaffDirectoryCDTVC.h"
#import "StaffMember.h"

@interface StaffDirectoryCDTVC ()

@end

@implementation StaffDirectoryCDTVC

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
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
        request.predicate = nil;
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES selector:@selector(localizedStandardCompare:)], [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)]];
                                    
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
}

- (UIImage*) imageScaledToSize:(UIImage *)img :(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Staff Member"];
    
    StaffMember *staffMember = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //fill out cell
    cell.textLabel.text = staffMember.name;
    cell.detailTextLabel.text = staffMember.position;
    
    //set up thumbnail for cell
    UIImage *img = [UIImage imageNamed:staffMember.imageName];
    UIImage *thumbnail = [self imageScaledToSize:img :CGSizeMake(50, 50)];
    [cell.imageView setImage:thumbnail];

    return cell;
}

@end
