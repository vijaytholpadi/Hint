//
//  NSDate+HTAdditions.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/9/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "NSDate+HTAdditions.h"

@implementation NSDate (HTAdditions)

+ (double)getCurrentTimeStamp {
    return (ceil([[NSDate date] timeIntervalSince1970]));
}

@end
