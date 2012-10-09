//
//  calcViewController.m
//  Calc
//
//  Created by Nathan Greenway on 6/08/12.
//  Copyright (c) 2012 iosclass. All rights reserved.
//

#import "calcViewController.h"
#import "calcFactory.h"

@interface calcViewController()
@property (nonatomic) BOOL userEnteringNumber;
@property (nonatomic, strong) calcFactory *brain;
@end

@interface calcViewController ()

@end

@implementation calcViewController

@synthesize display = _display;
@synthesize userEnteringNumber = _userEnteringNumber;
@synthesize brain = _brain;

- (calcFactory *)brain
{
    if (!_brain) _brain = [[calcFactory alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle; // [sender currentTitle];
    if (self.userEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userEnteringNumber = YES;
    }
    
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userEnteringNumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userEnteringNumber = NO;
}

- (IBAction)clearPressed:(id)sender {
    self.display.text = @"0";
    [self.brain clearStack];
    self.userEnteringNumber = NO;
}

@end
