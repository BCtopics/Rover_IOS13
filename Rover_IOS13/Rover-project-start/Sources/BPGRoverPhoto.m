//
//  BPGRoverPhoto.m
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "BPGRoverPhoto.h"

@implementation BPGRoverPhoto

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[BPGRoverPhoto class]]) { return NO; }
    BPGRoverPhoto *photo = object;
    if (photo.photoIdentifier != self.photoIdentifier) { return NO; }
    if (photo.solDateTaken != self.solDateTaken) { return NO; }
    if (![photo.cameraName isEqualToString:self.cameraName]) { return NO; }
    if (![photo.earthDate isEqualToDate:self.earthDate]) { return NO; }
    return YES;
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    });
    return dateFormatter;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        if (!dictionary[@"id"]) { return nil; }
        _photoIdentifier = [dictionary[@"id"] integerValue];
        _solDateTaken = [dictionary[@"sol"] integerValue];
        _cameraName = dictionary[@"camera"][@"name"];
        NSString *earthDateString = dictionary[@"earth_date"];
        _earthDate = [[[self class] dateFormatter] dateFromString:earthDateString];
        _imageURL = [NSURL URLWithString:dictionary[@"img_src"]];
        if (!_imageURL) { return nil; }
    }
    return self;
}

@end
