//
//  BPGRoverPhoto.h
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPGRoverPhoto : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - Properties

@property (nonatomic, readonly) NSInteger photoIdentifier;
@property (nonatomic, readonly) NSInteger solDateTaken;

@property (nonatomic, readonly, strong) NSString *cameraName;
@property (nonatomic, readonly, strong) NSDate *earthDate;

@property (nonatomic, readonly, strong) NSString *imageURL;

// On the photo model, you will have to add the Objective-C equivalent of the Equatable Protocol using the method isEqual

@end
