//
//  ImageVC.h
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ImageVC : UIViewController
@property (strong, nonatomic) Photo *photo;
- (void)setPhoto:(Photo *)photo;
@end
