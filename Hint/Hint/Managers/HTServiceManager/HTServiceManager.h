//
//  HTServiceManager.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

#import <Foundation/Foundation.h>

//Models
#import "HTNote.h"

typedef void(^notesFetchCompletionBlock)(NSArray *notes);
typedef void(^notesPostCompletionBlock)(BOOL succeeded, NSError * _Nullable error);

@class CLBeacon;

@interface HTServiceManager : NSObject
+ (void)getMessagesForBeacon:(CLBeacon*)beacon withCompletion:(notesFetchCompletionBlock)completionBlock;
+ (void)postMessage:(HTNote*)note forBeacon:(CLBeacon*)beacon withCompletion:(notesPostCompletionBlock)completionBlock;
@end
