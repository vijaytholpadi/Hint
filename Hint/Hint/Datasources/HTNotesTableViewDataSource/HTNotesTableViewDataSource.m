//
//  HTNotesTableViewDataSource.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTNotesTableViewDataSource.h"

//Models
#import "HTNote.h"

//Views
#import "HTNotesTableViewCell.h"

@implementation HTNotesTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTNote *note = self.notes[indexPath.row];

    HTNotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNotesTableViewCell"];
    cell.noteTextLabel.text = note.text;
    cell.noteImageView.file = note.image;
    [cell.noteImageView loadInBackground];
    
    return cell;
}

@end
