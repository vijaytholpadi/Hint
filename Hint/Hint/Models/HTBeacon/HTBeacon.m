//
//  HTBeacon.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTBeacon.h"

//Frameworks
#import <CoreLocation/CoreLocation.h>

@implementation HTBeacon

+ (instancetype)getHTBeaconFromCLBeacon:(CLBeacon*)beacon {
    HTBeacon *htBeacon = [HTBeacon new];
    htBeacon.UUID = beacon.proximityUUID.UUIDString;
    htBeacon.major = beacon.major.stringValue;
    htBeacon.minor = beacon.minor.stringValue;

    return htBeacon;
}

@end
