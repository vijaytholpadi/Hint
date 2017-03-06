//
//  HTDashboardViewController.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTDashboardViewController.h"

#import "HTLocationManager.h"

@interface HTDashboardViewController ()<HTBeaconRangingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *beaconCountLabel;

@end

@implementation HTDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [HTLocationManager sharedInstance].delegate = self;
    [[HTLocationManager sharedInstance] startLocationManager];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - HTBeaconRangingDelegate methods
- (void)beaconsFoundWithCount:(int)numberOfBeacons {
    //Update the label with count
    self.beaconCountLabel.text = [NSString stringWithFormat:@"%d", numberOfBeacons];
}

- (void)didFindInterestRegionBeacon:(CLBeacon *)beacon {
    //Enable button to goto MessagesViewController

}

- (void)didLoseInterestRegionBeacon {
    //Disable/Clear button to goto MessageViewController
}
@end
