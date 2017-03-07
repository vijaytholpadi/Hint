//
//  HTAuthenticationCoordinator.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTAuthenticationCoordinator.h"
@interface HTAuthenticationCoordinator ()
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSMutableArray *childCoordinators;
@end

@implementation HTAuthenticationCoordinator
- (instancetype)initWithNavigationController:(UINavigationController*)navigationController {
    self = [self init];
    if (!self) return nil;

    _navigationController = navigationController;
    return self;
}

- (void)start {

}
@end
