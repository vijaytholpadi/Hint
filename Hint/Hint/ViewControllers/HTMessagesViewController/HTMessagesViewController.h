//
//  HTMessagesViewController.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLBeacon;

@protocol HTNotesCoordinationDelegate <NSObject>
@required
- (void)notesViewControllerDidTapAddNoteForBeacon:(CLBeacon*)beacon;
@end

@interface HTMessagesViewController : UIViewController
@property (nonatomic, weak) id <HTNotesCoordinationDelegate> delegate;
@property (nonatomic, strong) CLBeacon *beacon;
@end
