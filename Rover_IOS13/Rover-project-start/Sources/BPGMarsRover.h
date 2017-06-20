//
//  BPGMarsRover.h
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BPGMarsRoverStatus) {
    BPGMarRoverStatusActive,
    BPGMarsRoverStatusComplete,
};

@interface BPGMarsRover : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - Properties

@property (nonatomic, strong, readonly) NSString *name;

@property (nonatomic, strong, readonly) NSDate *launchDate;
@property (nonatomic, strong, readonly) NSDate *landingDate;

@property (nonatomic, readonly) BPGMarsRoverStatus status; // Look into how this works.

@property (nonatomic, readonly) NSInteger maxSolDate;
@property (nonatomic, strong, readonly) NSDate *maxEarthDate;

@property (nonatomic, readonly) NSInteger solphotos;
@property (nonatomic, strong, readonly) NSArray *solDescriptions;

@end
