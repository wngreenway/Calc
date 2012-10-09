//
//  calcFactory.h
//  Calc
//
//  Created by Nathan Greenway on 6/08/12.
//  Copyright (c) 2012 iosclass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calcFactory : NSObject

- (void) pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void) clearStack;

@property (readonly) id program;

// Extra public methods
+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
