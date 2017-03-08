//
//  HTNote.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTNote.h"

@implementation HTNote

+ (NSArray*)getNotesArrayForRawArray:(NSArray*)array {
    NSMutableArray *notesArray = [NSMutableArray array];

    for (PFObject *pfobject in array) {
        HTNote *note = [HTNote new];
        note.text = pfobject[@"text"];
        note.image = pfobject[@"photo"];

        [notesArray addObject:note];
    }
    return notesArray;
}

@end
