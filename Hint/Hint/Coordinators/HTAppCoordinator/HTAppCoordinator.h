//
//  HTAppCoordinator.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTAppCoordinator : NSObject
- (instancetype)initWithNavigationController:(UINavigationController*)navigationController;

- (void)start;
@end
