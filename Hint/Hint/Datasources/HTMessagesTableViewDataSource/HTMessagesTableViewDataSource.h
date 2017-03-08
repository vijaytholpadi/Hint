//
//  HTMessagesTableViewDataSource.h
//  Hint
//
//  Created by Vijay Tholpadi on 3/7/17.
//  Copyright © 2017 TheGeekProjekt. All rights reserved.
//

//Frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTMessagesTableViewDataSource : NSObject<UITableViewDataSource>
@property (nonatomic, strong) NSArray *notes;
@end
