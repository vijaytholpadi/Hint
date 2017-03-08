//
//  AppDelegate.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTAppDelegate.h"

//Coordinators
#import "HTAppCoordinator.h"

//Frameworks
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Parse/Parse.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

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
        // Add your Parse applicationId:
        configuration.applicationId = @"7e487db101990ea80db27b61463cbd9d4fed50ce";

        // Uncomment and add your clientKey (it's not required if you are using Parse Server):
         configuration.clientKey = @"db7f3e1b2b1c47be8cc739c5c0fb808f2f531fbd";

        // Uncomment the following line and change to your Parse Server address;
         configuration.server = @"http://ec2-52-33-176-59.us-west-2.compute.amazonaws.com:80/parse";

        // Enable storing and querying data from Local Datastore. Remove this line if you don't want to
        // use Local Datastore features or want to use cachePolicy.
        configuration.localDatastoreEnabled = YES;
    }]];

    // ****************************************************************************
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // [PFFacebookUtils initializeFacebook];
    // ****************************************************************************

    [PFUser enableAutomaticUser];

    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    defaultACL.publicReadAccess = YES;

    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
}

- (void)enableIQKeyboardManager {
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)askForNotificationPermissions {
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
}
@end
