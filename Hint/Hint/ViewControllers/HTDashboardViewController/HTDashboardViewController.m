//
//  HTDashboardViewController.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/6/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTDashboardViewController.h"

//Categories
#import "UIColor+HTColor.h"

//Managers
#import "HTLocationManager.h"

@interface HTDashboardViewController ()<HTBeaconRangingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *hintsNearbyStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *validBeaconFoundButton;

@end

@implementation HTDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self themeScreen];

    [HTLocationManager sharedInstance].delegate = self;
    [[HTLocationManager sharedInstance] startLocationManager];
}

- (void)themeScreen {
    [self.view setBackgroundColor:[UIColor ht_BlueColor]];
    [self.hintsNearbyStaticLabel setTextColor:[UIColor ht_YellowColor]];
    [self.beaconCountLabel setTextColor:[UIColor ht_YellowColor]];
    [self.validBeaconFoundButton setTitleColor:[UIColor ht_BlueColor] forState:UIControlStateNormal];
    [self.validBeaconFoundButton setBackgroundColor:[UIColor ht_BlueColor]];
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
