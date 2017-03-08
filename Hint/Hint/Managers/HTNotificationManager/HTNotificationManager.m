//
//  HTNotificationManager.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTNotificationManager.h"

//Frameworks
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation HTNotificationManager
- (void)fireNotificationForBeacon:(CLBeacon*)beacon {
    //Depending on app state, fire the notification
    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;

    if (applicationState == UIApplicationStateActive) {
        //Show in app notification
    } else if ((applicationState == UIApplicationStateInactive) || (applicationState == UIApplicationStateBackground)) {
        //Throw a UILocalNotification
//        UILocalNotification
    }
}
@end
