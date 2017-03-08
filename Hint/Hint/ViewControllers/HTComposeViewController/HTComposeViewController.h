//
//  HTComposeViewController.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLBeacon;

@interface HTComposeViewController : UIViewController

@property (nonatomic, strong) CLBeacon *beacon;

@end
