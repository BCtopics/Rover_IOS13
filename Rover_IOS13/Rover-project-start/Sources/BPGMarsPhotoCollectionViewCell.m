//
//  BPGMarsPhotoCollectionViewCell.m
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "BPGMarsPhotoCollectionViewCell.h"

@implementation BPGMarsPhotoCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
