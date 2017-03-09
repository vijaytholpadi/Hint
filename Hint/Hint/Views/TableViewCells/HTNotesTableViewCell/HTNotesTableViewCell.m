//
//  HTNotesTableViewCell.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTNotesTableViewCell.h"

@implementation HTNotesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.noteTextLabel.textColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
