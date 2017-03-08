//
//  HTNotificationManager.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLBeacon;

@interface HTNotificationManager : NSObject
- (void)fireNotificationForBeacon:(CLBeacon*)beacon;
@end
