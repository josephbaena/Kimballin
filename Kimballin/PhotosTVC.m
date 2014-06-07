//
//  PhotosTVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "PhotosTVC.h"
#import "Photo.h"

@interface PhotosTVC ()
@property (strong, nonatomic) NSMutableArray *photos;
@end

@implementation PhotosTVC

- (void)specifyEvent:(Event *)event
{
    _event = event;
}

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (Photo *p in self.event.photos) {
        [self.photos addObject:p];
    }
    
    self.title = @"Photos";
    
    NSLog(@"self.photos = %@", self.photos);
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


@end
