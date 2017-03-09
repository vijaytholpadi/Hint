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
#import "NSDate+HTAdditions.h"

//Frameworks
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

static NSString *kBeaconNotificationHistoryDictionaryKey = @"beaconNotificationHistoryDictionaryKey";
static NSInteger kPollingCooldownPeriodInSecs = 120;

@implementation HTNotificationManager

+ (void)fireNotificationForBeacon:(CLBeacon*)beacon {
    if ([NSDate getCurrentTimeStamp] - [HTNotificationManager getLastTriggeredTimeStampForBeaconMajor:beacon.major.stringValue andBeaconMinor:beacon.minor.stringValue] > kPollingCooldownPeriodInSecs) {
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

            [HTNotificationManager saveEntryForBeaconMajor:beacon.major.stringValue andBeaconMinor:beacon.minor.stringValue];
        }
    }
}


#pragma mark - BookKeeping and Regulation
+ (void)saveEntryForBeaconMajor:(NSString*)beaconMajorString andBeaconMinor:(NSString*)beaconMinorString {
    NSMutableDictionary *triggerHistory = [[[NSUserDefaults standardUserDefaults] objectForKey:kBeaconNotificationHistoryDictionaryKey] mutableCopy];

    //Create record if never created.
    if (!triggerHistory) {
        triggerHistory = [NSMutableDictionary dictionary];
    }

    NSString *beaconCombinationKey = [NSString stringWithFormat:@"%@-%@", beaconMajorString, beaconMinorString];
    triggerHistory[beaconCombinationKey] = [NSString stringWithFormat:@"%f", [NSDate getCurrentTimeStamp]];

    [[NSUserDefaults standardUserDefaults] setObject:triggerHistory forKey:kBeaconNotificationHistoryDictionaryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (double)getLastTriggeredTimeStampForBeaconMajor:(NSString*)beaconMajorString andBeaconMinor:(NSString*)beaconMinorString {
    NSMutableDictionary *triggerHistory = [[[NSUserDefaults standardUserDefaults] objectForKey:kBeaconNotificationHistoryDictionaryKey] mutableCopy];

    NSString *beaconCombinationKey = [NSString stringWithFormat:@"%@-%@", beaconMajorString, beaconMinorString];

    double lastTriggeredTimeStamp = [triggerHistory[beaconCombinationKey] doubleValue];
    return lastTriggeredTimeStamp ? lastTriggeredTimeStamp : 0;
}

@end
