//
//  HTLocationManager.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLBeacon;

@protocol HTBeaconRangingDelegate <NSObject>

@optional
- (void)beaconsFoundWithCount:(int)numberOfBeacons;
- (void)didFindInterestRegionBeacon:(CLBeacon*)beacon;
- (void)didLoseInterestRegionBeacon;

@end

@interface HTLocationManager : NSObject

@property (nonatomic, weak) id <HTBeaconRangingDelegate> delegate;

+ (HTLocationManager*)sharedInstance;
- (void)startLocationManager;

@end
