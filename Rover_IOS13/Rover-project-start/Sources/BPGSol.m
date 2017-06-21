//
//  BPGSol.m
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "BPGSol.h"

@implementation BPGSol

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _sol = [dictionary[@"sol"] integerValue];
        _numberOfPhotos = [dictionary[@"total_photos"] integerValue];
        _cameras = [dictionary[@"cameras"] copy];
    }
    return self;
}

@end
