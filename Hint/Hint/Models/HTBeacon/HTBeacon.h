//
//  HTBeacon.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLBeacon;

@interface HTBeacon : NSObject

@property (nonatomic, strong) NSString *UUID;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSArray *notes;

+ (instancetype)getHTBeaconFromCLBeacon:(CLBeacon*)beacon;

@end
