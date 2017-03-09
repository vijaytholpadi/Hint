//
//  HTServiceManager.m
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import "HTServiceManager.h"

//Models
#import "HTBeacon.h"

//Frameworks
#import <Parse/Parse.h>

@implementation HTServiceManager

+ (void)getNotesForBeacon:(CLBeacon*)beacon withCompletion:(notesFetchCompletionBlock)completionBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"Beacon"];
    [query whereKey:@"UUID" equalTo:beacon.proximityUUID.UUIDString];
    [query whereKey:@"major" equalTo:beacon.major.stringValue];
    [query whereKey:@"minor" equalTo:beacon.minor.stringValue];

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parent = %@", objects[0]];
        PFQuery *query = [PFQuery queryWithClassName:@"Note" predicate:predicate];

        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            completionBlock(objects);
        }];
    }];
}

+ (void)postNote:(HTNote*)note forBeacon:(CLBeacon*)beacon withCompletion:(notesPostCompletionBlock)completionBlock {
    PFObject *pfNote = [[PFObject alloc] initWithClassName:@"Note"];
    pfNote[@"text"] = note.text;
    pfNote[@"user"] = [PFUser currentUser];

    //If Image is present only then attach image
    if (note.image) {
        pfNote[@"photo"] = note.image;
    }

    PFQuery *query = [PFQuery queryWithClassName:@"Beacon"];
    [query whereKey:@"UUID" equalTo:beacon.proximityUUID.UUIDString];
    [query whereKey:@"major" equalTo:beacon.major.stringValue];
    [query whereKey:@"minor" equalTo:beacon.minor.stringValue];

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        PFObject *pfBeacon;

        if (objects.count) {
            pfBeacon = objects[0];
        } else {
            pfBeacon = [[PFObject alloc] initWithClassName:@"Beacon"];
            pfBeacon[@"UUID"] = beacon.proximityUUID.UUIDString;
            pfBeacon[@"major"] = beacon.major.stringValue;
            pfBeacon[@"minor"] = beacon.minor.stringValue;
        }

        pfNote[@"parent"] = pfBeacon;
        [pfNote saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            completionBlock(succeeded, error);
        }];
    }];
}

@end
