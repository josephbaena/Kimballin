//
//  EventVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "EventVC.h"
#import <MapKit/MapKit.h>

@interface EventVC () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
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
    
    CLLocationCoordinate2D ctrpoint;
    ctrpoint.latitude = [self.event.latitude doubleValue];
    ctrpoint.longitude = [self.event.longitude doubleValue];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(ctrpoint, RADIUS, RADIUS);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = ctrpoint;
    point.title = self.event.location;
    [self.mapView addAnnotation:point];
}

@end
