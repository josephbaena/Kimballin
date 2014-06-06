//
//  EventVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "EventVC.h"
#import <MapKit/MapKit.h>
#import <EventKit/EKEventStore.h>
#import <EventKit/EKReminder.h>
#import <EventKit/EventKit.h>

@interface EventVC () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *calendarButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation EventVC

- (void)specifyEvent:(Event *)event
{
    _event = event;
    self.title = event.name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

static const int RADIUS = 100;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy hh:mm a"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"US/Pacific"]];
    
    NSString *startTimeString = [formatter stringFromDate:self.event.startTime];
    NSString *endTimeString = [formatter stringFromDate:self.event.endTime];
    
    self.startTimeLabel.text = startTimeString;
    self.endTimeLabel.text = endTimeString;
    self.locationLabel.text = self.event.location;
    
    CLLocationCoordinate2D center;
    center.latitude = [self.event.latitude doubleValue];
    center.longitude = [self.event.longitude doubleValue];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, RADIUS, RADIUS);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = center;
    point.title = self.event.location;
    point.subtitle = self.event.name;
    [self.mapView addAnnotation:point];
}

- (IBAction)calendarButtonPressed:(UIButton *)sender
{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            return;
        }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = self.event.name;
        event.startDate = self.event.startTime;
        event.endDate = self.event.endTime;
        [event setCalendar:[store defaultCalendarForNewEvents]];
        
        NSError *err = nil;
        BOOL success = [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        UIAlertView *alert;
        if (!success) {
            NSLog(@"Could not save calendar event: %@", [error localizedDescription]);
            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to save event to your Calendar." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        } else {
            alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Added event to your Calendar." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

        }
        
        [alert performSelectorOnMainThread:@selector(show)
                                withObject:nil
                             waitUntilDone:NO];
    }];
}

@end
