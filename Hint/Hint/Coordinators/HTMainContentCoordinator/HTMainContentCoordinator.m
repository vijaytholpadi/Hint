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

@interface HTMainContentCoordinator ()<HTDashBoardCoordinationDelegate>
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
    [self.navigationController pushViewController:dashboardViewController animated:YES];
}

#pragma mark - HTDashBoardCoordinationDelegate Methods
-(void)dashboardViewControllerDidTapViewMessagesForBeacon:(CLBeacon *)beacon {
    
}
@end
