//
//  AnswerVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "AnswerVC.h"

@interface AnswerVC ()
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@end

@implementation AnswerVC

- (void)specifyTriviaElement:(TriviaElement *)element
{
    _element = element;
    self.title = @"Answer";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.answerLabel.text = self.element.answer;
}

@end
