//
//  AppDelegate.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTAppDelegate.h"

//Categories
#import "CLBeacon+NSCoding.h"

//Coordinators
#import "HTAppCoordinator.h"

//Frameworks
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Parse/Parse.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <Keys/HintKeys.h>

@interface HTAppDelegate ()

@property (nonatomic, strong) HTAppCoordinator *coordinator;

@end

@implementation HTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];
    [self configureParse];
    [self enableIQKeyboardManager];
    [self askForNotificationPermissions];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [UINavigationController new];
    self.coordinator = [[HTAppCoordinator alloc] initWithNavigationController:(UINavigationController*)self.window.rootViewController];

    [self.coordinator start];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)configureParse {
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
        HintKeys *keys = [[HintKeys alloc] init];
        configuration.applicationId = keys.parseApplicationID;
        configuration.clientKey = keys.parseClientKey;
        configuration.server = keys.parseServerURL;
        configuration.localDatastoreEnabled = YES;
    }]];

    [PFUser enableAutomaticUser];

    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    defaultACL.publicReadAccess = YES;

    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
}

- (void)enableIQKeyboardManager {
    [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark - Notification methods
- (void)askForNotificationPermissions {
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive || [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        NSDictionary *notificationPayload = notification.userInfo;

        CLBeacon *beacon = [CLBeacon unArchivedBeaconFromData:notificationPayload[@"beacon"]];
        [self.coordinator showNotesForBeacon:beacon];
    }
}

@end
