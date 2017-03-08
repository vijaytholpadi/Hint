//
//  HTAppCoordinator.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTAppCoordinator.h"

//Coordinators
#import "HTMainContentCoordinator.h"

@interface HTAppCoordinator ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSMutableArray *childCoordinators;

@end

@implementation HTAppCoordinator

- (instancetype)initWithNavigationController:(UINavigationController*)navigationController {
    self = [self init];
    if (!self) return nil;

    _navigationController = navigationController;

    self.childCoordinators = [NSMutableArray array];
    return self;
}

- (void)start {
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    mainWindow.rootViewController = self.navigationController;

    //Booting Main Content
    [self showMainContent];
}

- (void)showMainContent {
    HTMainContentCoordinator *mainContentCoordinator = [[HTMainContentCoordinator alloc] initWithNavigationController:self.navigationController];
    [mainContentCoordinator start];
    [self.childCoordinators addObject:mainContentCoordinator];
}

//Notification Deeplink - Beacon
- (void)showNotesForBeacon:(CLBeacon*)beacon {
    HTMainContentCoordinator *mainContentCoordinator = self.childCoordinators[0];
    [mainContentCoordinator showNotesForBeacon:beacon];
}

@end
