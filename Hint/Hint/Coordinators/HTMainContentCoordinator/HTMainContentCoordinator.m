//
//  HTMainContentCoordinator.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTMainContentCoordinator.h"

//ViewControllers
#import "HTDashboardViewController.h"
#import "HTMessagesViewController.h"
#import "HTComposeViewController.h"

@interface HTMainContentCoordinator ()<HTDashBoardCoordinationDelegate, HTNotesCoordinationDelegate>
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSMutableArray *childCoordinators;
@end

@implementation HTMainContentCoordinator

- (instancetype)initWithNavigationController:(UINavigationController*)navigationController {
    self = [self init];
    if (!self) return nil;

    _navigationController = navigationController;
    return self;
}

- (void)start {
    HTDashboardViewController *dashboardViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HTDashboardViewController"];
    dashboardViewController.delegate = self;
    [self.navigationController pushViewController:dashboardViewController animated:YES];
}

#pragma mark - HTDashBoardCoordinationDelegate Methods
- (void)dashboardViewControllerDidTapViewMessagesForBeacon:(CLBeacon *)beacon {
    //TODO: Move the network call to this level
    HTMessagesViewController *messagesViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HTMessagesViewController"];
    messagesViewController.delegate = self;
    messagesViewController.beacon = beacon;
    [self.navigationController pushViewController:messagesViewController animated:YES];
}

- (void)notesViewControllerDidTapAddNoteForBeacon:(CLBeacon *)beacon {
    HTComposeViewController *composeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HTComposeViewController"];
    composeViewController.beacon = beacon;
    [self.navigationController pushViewController:composeViewController animated:YES];
}

//Notification Deeplink - Beacon
- (void)showNotesForBeacon:(CLBeacon*)beacon {
    [self dashboardViewControllerDidTapViewMessagesForBeacon:beacon];
}

@end
