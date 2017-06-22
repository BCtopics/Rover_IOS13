//
//  BPGPhotoCache.h
//  Rover
//
//  Created by Bradley GIlmore on 6/22/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPGPhotoCache : NSObject

@property (nonatomic, readonly, class) BPGPhotoCache *sharedCache;

- (void)cacheImageData:(NSData *)data forIdentifier:(NSInteger)identifier;
- (NSData *)imageDataForIdentifier:(NSInteger)identifier;

@end
