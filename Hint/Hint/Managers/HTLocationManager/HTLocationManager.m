//
//  HTLocationManager.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTLocationManager.h"

//Categories
#import <CLLocationManager+blocks.h>

//Frameworks
#import <CoreLocation/CoreLocation.h>

//static NSString *beaconUUIDString = @"BAEA0D57-07CD-4633-8058-DFFE03F1CA7C";
static NSString *beaconUUIDString = @"62FD1802-A807-441B-A869-5483398238A7";


@interface HTLocationManager ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation HTLocationManager

+ (HTLocationManager*)sharedInstance {
    static HTLocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startLocationManager {
    self.manager = [CLLocationManager updateManagerWithAccuracy:50.0 locationAge:15.0 authorizationDesciption:CLLocationUpdateAuthorizationDescriptionAlways];

    //To Trigger location permission window
    if ([CLLocationManager isLocationUpdatesAvailable]) {
        [self.manager startUpdatingLocationWithUpdateBlock:^(CLLocationManager *manager, CLLocation *location, NSError *error, BOOL *stopUpdating) {
            *stopUpdating = YES;
        }];

        [self setupBeaconRegionForUUIDString:beaconUUIDString forIdentifier:@"HintBeaconRegion"];
    }

    //Did determine beacon region entry
    [self.manager didDetermineStateWithBlock:^(CLLocationManager *manager, CLRegionState state, CLRegion *region) {
        if ([region isKindOfClass:[CLBeaconRegion class]]) {
            if (state == CLRegionStateInside) {
                CLBeaconRegion *beaconRegion = (CLBeaconRegion*)region;
                [self startRangingForBeaconRegion:beaconRegion];
            }
        }
    }];

    //Did range beacons
    [self.manager didRangeBeaconsWithBlock:^(CLLocationManager *manager, NSArray *beacons, CLBeaconRegion *region) {
            NSLog(@"Our new location: %@", [beacons firstObject]);

            //Find out the nearest beacon
            CLBeacon *nearestBeacon = [beacons firstObject];
            if (nearestBeacon.proximity == CLProximityImmediate || nearestBeacon.proximity == CLProximityNear) {
                [self.delegate didFindInterestRegionBeacon:nearestBeacon];
            } else {
                //Clear button
                [self.delegate didLoseInterestRegionBeacon];
            }
        [self.delegate beaconsFoundWithCount:beacons.count];
    }];


    //Listener for change in authorization status
    [self.manager didChangeAuthorizationStatusWithBlock:^(CLLocationManager *manager, CLAuthorizationStatus status) {
    }];
}

- (void)setupBeaconRegionForUUIDString:(NSString*)UUIDString forIdentifier:(NSString*)beaconIdentifier {
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID UUID] initWithUUIDString:UUIDString] identifier:beaconIdentifier];
    beaconRegion.notifyOnEntry=YES;
    beaconRegion.notifyOnExit=NO;

    [self.manager startMonitoringForRegion:beaconRegion];
    [self.manager requestStateForRegion:beaconRegion];

    [self startRangingForBeaconRegion:beaconRegion];
}

- (void)startRangingForBeaconRegion:(CLBeaconRegion*)beaconRegion {
    [self.manager startRangingBeaconsInRegion:beaconRegion];
}
@end
