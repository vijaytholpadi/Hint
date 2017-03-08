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

@property (nonatomic, weak) IBOutlet UILabel *hintsNearbyStaticLabel;
@property (nonatomic, weak) IBOutlet UILabel *beaconCountLabel;
@property (nonatomic, weak) IBOutlet UIButton *validBeaconFoundButton;
@property (nonatomic, strong) CLBeacon *validBeacon;

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
    [self.validBeaconFoundButton setBackgroundColor:[UIColor ht_YellowColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction methods
- (IBAction)didPressValidBeaconFoundButton:(id)sender {
    [self.delegate dashboardViewControllerDidTapViewMessagesForBeacon:self.validBeacon];
}

#pragma mark - HTBeaconRangingDelegate methods
- (void)beaconsFoundWithCount:(int)numberOfBeacons {
    //Update the label with count
    self.beaconCountLabel.text = [NSString stringWithFormat:@"%d", numberOfBeacons];
}

- (void)didFindInterestRegionBeacon:(CLBeacon *)beacon {
    //Enable button to goto MessagesViewController
    self.validBeaconFoundButton.hidden = NO;
    self.validBeacon = beacon;
}

- (void)didLoseInterestRegionBeacon {
    //Disable/Clear button to goto MessageViewController
    self.validBeaconFoundButton.hidden = YES;
    self.validBeacon = nil;
}

@end
