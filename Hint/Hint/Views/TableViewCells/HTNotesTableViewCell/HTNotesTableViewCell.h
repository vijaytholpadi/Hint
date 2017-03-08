//
//  HTNotesTableViewCell.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <UIKit/UIKit.h>

//Frameworks
#import <ParseUI/ParseUI.h>

@interface HTNotesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *noteImageView;
@property (weak, nonatomic) IBOutlet UILabel *noteTextLabel;

@end
