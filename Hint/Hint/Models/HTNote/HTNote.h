//
//  HTNote.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse.h>

@interface HTNote : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) PFFile *image;

+ (NSArray*)getNotesArrayForRawArray:(NSArray*)array;
@end
