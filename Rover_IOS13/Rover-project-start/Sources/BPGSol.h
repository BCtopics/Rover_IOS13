//
//  BPGSol.h
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPGSol : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - Properties

@property (nonatomic, readonly) NSInteger *sol;
@property (nonatomic, readonly) NSInteger *numberOfPhotos;
@property (nonatomic, strong, readonly) NSArray *cameras; // Make this an array of strings.

@end
