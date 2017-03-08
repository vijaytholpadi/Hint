//
//  HTDashboardViewController.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLBeacon;

@protocol HTDashBoardCoordinationDelegate <NSObject>

@required
- (void)dashboardViewControllerDidTapViewMessagesForBeacon:(CLBeacon*)beacon;

@end

@interface HTDashboardViewController : UIViewController

@property (nonatomic, weak) id <HTDashBoardCoordinationDelegate> delegate;

@end
