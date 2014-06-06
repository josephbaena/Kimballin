//
//  AnswerVC.h
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriviaElement.h"

@interface AnswerVC : UIViewController

@property (strong, nonatomic) TriviaElement *element;

- (void)specifyTriviaElement:(TriviaElement *)element;

@end
