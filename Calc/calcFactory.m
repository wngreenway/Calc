//
//  calcFactory.m
//  Calc
//
//  Created by Nathan Greenway on 6/08/12.
//  Copyright (c) 2012 iosclass. All rights reserved.
//

#import "calcFactory.h"

@interface calcFactory()

@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation calcFactory

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack =[[NSMutableArray alloc] init];
    return _programStack;
}

- (void) pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

/*
- (double)popOperand
{
    NSNumber *operandObject = [self.programStack lastObject];
    if (operandObject) [self.programStack removeLastObject];
    return operandObject.doubleValue;
}
*/

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [calcFactory runProgram:self.program];
}


- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"value";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]) {
            double subtract = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtract;
        } else if ([@"/" isEqualToString:operation]) {
            double divide = [self popOperandOffStack:stack];
            if (divide) result = [self popOperandOffStack:stack] / divide;
        }
    }
    
    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.programStack];
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}

- (void)clearStack
{
    [self.programStack removeAllObjects];
}

@end
