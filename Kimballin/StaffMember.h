//
//  StaffMember.h
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StaffMember : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * position;
@property (nonatomic, retain) NSString * room;

@end
