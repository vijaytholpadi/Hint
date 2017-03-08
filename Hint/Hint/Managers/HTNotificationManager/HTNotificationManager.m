//
//  HTNotificationManager.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTNotificationManager.h"

//Categories
#import "CLBeacon+NSCoding.h"

//Frameworks
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation HTNotificationManager
+ (void)fireNotificationForBeacon:(CLBeacon*)beacon {
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {

        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Psst! Check out this secret.";
        notification.alertAction = @"View Note";
        notification.soundName = @"default";
        notification.userInfo = @{@"beacon":[beacon archivedData],
                                  @"UUID":beacon.proximityUUID.UUIDString,
                                  @"major":beacon.major,
                                  @"minor":beacon.minor};

        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}
@end
