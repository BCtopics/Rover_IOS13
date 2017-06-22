//
//  BPGPhotoCache.m
//  Rover
//
//  Created by Bradley GIlmore on 6/22/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "BPGPhotoCache.h"

@interface BPGPhotoCache ()

@property (nonatomic, strong) NSCache *cache;

@end


@implementation BPGPhotoCache

+ (instancetype)sharedCache
{
    static BPGPhotoCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[self alloc] init];
    });
    return sharedCache;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
        _cache.name = @"com.BradleyGilmore.Rover.PhotosCache";
    }
    return self;
}

- (void)cacheImageData:(NSData *)data forIdentifier:(NSInteger)identifier
{
    [self.cache setObject:data forKey:@(identifier) cost:[data length]];
}

- (NSData *)imageDataForIdentifier:(NSInteger)identifier
{
    return [self.cache objectForKey:@(identifier)];
}

@end
