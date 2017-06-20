//
//  BPGMarsRoverClient.h
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPGMarsRover;
@class BPGRoverPhoto;

@interface BPGMarsRoverClient : NSObject

-(void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray *roverNames, NSError *error))completion;
-(void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(BPGMarsRover *rover, NSError *error))completion;
-(void)fetchPhotosFromRover:(BPGMarsRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray *photos, NSError *error))completion;
-(void)fetchImageDataForPhoto:(BPGRoverPhoto *)photo completion:(void(^)(NSData *imageData, NSError *error))completion;

@end
