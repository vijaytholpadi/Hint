//
//  CLBeacon+NSCoding.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/8/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLBeacon (NSCoding)

- (NSData*)archivedData;
+ (instancetype)unArchivedBeaconFromData:(NSData*)beaconData;

@end
