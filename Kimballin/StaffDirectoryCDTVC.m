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
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)]];
                                    
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Staff Member"];
    
    StaffMember *staffMember = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = staffMember.name;
    cell.detailTextLabel.text = staffMember.position;
    [cell.imageView setImage:[UIImage imageNamed:staffMember.imageName]];
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
