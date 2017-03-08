//
//  HTMainContentCoordinator.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CLBeacon;

@interface HTMainContentCoordinator : NSObject

- (instancetype)initWithNavigationController:(UINavigationController*)navigationController;
- (void)start;

//Notification Deeplink - Beacon
- (void)showNotesForBeacon:(CLBeacon*)beacon;

@end
