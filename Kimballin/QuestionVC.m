//
//  QuestionVC.m
//  Kimballin
//
//  Created by Joseph Baena on 6/6/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

#import "QuestionVC.h"
#import "AnswerVC.h"
#import "TriviaElement.h"

@interface QuestionVC ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation QuestionVC

- (void)specifyTriviaElement:(TriviaElement *)element
{
    _element = element;
    self.title = @"Question";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.questionLabel.text = self.element.question;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
          if ([segue.identifier isEqualToString:@"Display Answer"]) {
                if ([segue.destinationViewController isKindOfClass:[AnswerVC class]]) {
                    AnswerVC *vc = (AnswerVC *)segue.destinationViewController;
                    [vc specifyTriviaElement:self.element];
            }
        }
    }
}

@end
