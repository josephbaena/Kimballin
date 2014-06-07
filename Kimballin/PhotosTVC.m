//
//  PhotosTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "PhotosTVC.h"
#import "Photo.h"
#import "ImageVC.h"

@interface PhotosTVC ()
@property (strong, nonatomic) NSMutableArray *photos;
@end

@implementation PhotosTVC

- (void)specifyEvent:(Event *)event
{
    _event = event;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.photos = [[NSMutableArray alloc] init];

    [super viewWillAppear:animated];
    for (Photo *p in self.event.photos) {
        [self.photos addObject:p];
    }
    
    //sort the photos by imageName
    NSArray *sortedArray;
    sortedArray = [self.photos sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        Photo *first = (Photo *)a;
        Photo *second = (Photo *)b;
        NSString *imageNameFirst = first.imageName;
        NSString *imageNameSecond = second.imageName;
        return [imageNameFirst compare:imageNameSecond];
    }];
    
    self.photos = [NSMutableArray arrayWithArray:sortedArray];
    
    self.title = @"Photos";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo Cell" forIndexPath:indexPath];
    NSLog(@"indexPath.row = %ld", (long)indexPath.row);
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text = photo.imageName;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Photo"]) {
                if ([segue.destinationViewController isKindOfClass:[ImageVC class]]) {
                    ImageVC *vc = (ImageVC *)segue.destinationViewController;
                    Photo *photo = [self.photos objectAtIndex:indexPath.row];
                    [vc setPhoto:photo];
                }
            }
        }
    }
}

@end
