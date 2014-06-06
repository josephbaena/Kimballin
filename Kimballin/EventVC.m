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

@interface EventVC () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *remindersButton;
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

- (IBAction)remindersButtonPressed:(UIButton *)sender {
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeReminder
                          completion:^(BOOL granted, NSError *error) {
                              if (!granted) {
                                NSLog(@"Permission not granted");
                              return;  
                              } else {
                                  EKReminder *reminder = [EKReminder reminderWithEventStore:store];
                                  [reminder setTitle:self.event.name];
                                  EKCalendar *defaultReminderList = [store defaultCalendarForNewReminders];
                                  
                                  [reminder setCalendar:defaultReminderList];
                                  
                                  NSError *error = nil;
                                  BOOL success = [store saveReminder:reminder
                                                              commit:YES
                                                               error:&error];
                                  if (!success) {
                                      NSLog(@"Could not save reminder: %@", [error localizedDescription]);
                                  } else {
                                      NSLog(@"Reminder created!");
                                  }
                              }
                          }];
   }

@end
