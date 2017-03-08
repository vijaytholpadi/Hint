//
//  CLBeacon+NSCoding.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/8/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "CLBeacon+NSCoding.h"

@implementation CLBeacon (NSCoding)

- (NSData*)archivedData {
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

+ (instancetype)unArchivedBeaconFromData:(NSData*)beaconData; {
    return (CLBeacon*)[NSKeyedUnarchiver unarchiveObjectWithData:beaconData];
}

@end
