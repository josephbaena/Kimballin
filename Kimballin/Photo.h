//
//  Photo.h
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) Event *forEvent;

@end
