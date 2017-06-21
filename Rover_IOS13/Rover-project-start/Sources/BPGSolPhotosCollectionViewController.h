//
//  BPGSolPhotosCollectionViewController.h
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPGMarsRover.h"
#import "BPGSol.h"

@interface BPGSolPhotosCollectionViewController : UICollectionViewController

@property (nonatomic, strong) BPGMarsRover *rover;
@property (nonatomic, strong) BPGSol *sol;

@end
