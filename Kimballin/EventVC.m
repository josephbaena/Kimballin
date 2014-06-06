//
//  EventVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "EventVC.h"

@interface EventVC ()
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation EventVC

- (void)specifyEvent:(Event *)event
{
    _event = event;
    self.title = event.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"US/Pacific"]];
    
    NSString *startTimeString = [formatter stringFromDate:self.event.startTime];
    NSString *endTimeString = [formatter stringFromDate:self.event.endTime];
    
    self.startTimeLabel.text = startTimeString;
    self.endTimeLabel.text = endTimeString;
    self.locationLabel.text = self.event.location;
    
    NSLog(@"startTime = %@", startTimeString);
    NSLog(@"endTime = %@", endTimeString);
    NSLog(@"locationLabel = %@", self.event.location);

}
@end
