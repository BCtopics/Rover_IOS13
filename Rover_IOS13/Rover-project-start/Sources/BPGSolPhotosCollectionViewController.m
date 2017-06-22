//
//  BPGSolPhotosCollectionViewController.m
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "BPGSolPhotosCollectionViewController.h"
#import "BPGMarsRover.h"
#import "BPGMarsRoverClient.h"
#import "BPGMarsPhotoCollectionViewCell.h"
#import "BPGPhotoCache.h"
#import "BPGRoverPhoto.h"
#import "Rover-Swift.h"

@interface BPGSolPhotosCollectionViewController ()

@property (nonatomic, strong, readonly) BPGMarsRoverClient *client;
@property (nonatomic, copy) NSArray *photoReferences;

@end

@implementation BPGSolPhotosCollectionViewController

static NSString * const reuseIdentifier = @"marsPhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchPhotoReferences];
}

- (void)fetchPhotoReferences
{
    if (!self.rover || !self.sol) {
        return;
    }
    
    BPGMarsRoverClient *client = [[BPGMarsRoverClient alloc] init];
    [client fetchPhotosFromRover:self.rover onSol:self.sol.sol completion:^(NSArray *photos, NSError *error) {
        if (error) {
            NSLog(@"Error getting photo references for %@ on %@: %@", self.rover, self.sol, error);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoReferences = photos;
        });
    }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toDetailView"]) {
        BPGMarsPhotoDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        detailVC.photo = self.photoReferences[indexPath.row];
    }
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoReferences.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPGMarsPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BPGRoverPhoto *photo = self.photoReferences[indexPath.row];
    
    BPGPhotoCache *cache = [BPGPhotoCache sharedCache];
    NSData *cachedData = [cache imageDataForIdentifier:photo.photoIdentifier];
    if (cachedData) {
        cell.imageView.image = [UIImage imageWithData:cachedData];
        return cell;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
    }
    
    [self.client fetchImageDataForPhoto:photo completion:^(NSData *imageData, NSError *error) {
        if (error || !imageData) {
            NSLog(@"Error fetching image data for %@: %@", photo, error);
            return;
        }
        
        [cache cacheImageData:imageData forIdentifier:photo.photoIdentifier];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![indexPath isEqual:[collectionView indexPathForCell:cell]]) {
                return; // Cell has been reused for another photo
            }
            cell.imageView.image = image;
        });
    }];
    
    return cell;
}

@synthesize client = _client;
- (BPGMarsRoverClient *)client
{
    if (!_client) {
        _client = [[BPGMarsRoverClient alloc] init];
    }
    return _client;
}

- (void)setRover:(BPGMarsRover *)rover
{
    if (rover != _rover) {
        _rover = rover;
        [self fetchPhotoReferences];
    }
}

- (void)setSol:(BPGSol *)sol
{
    if (sol != _sol) {
        _sol = sol;
        [self fetchPhotoReferences];
    }
}

- (void)setPhotoReferences:(NSArray *)photoReferences
{
    if (photoReferences != _photoReferences) {
        _photoReferences = [photoReferences copy];
        [self.collectionView reloadData];
    }
}

@end
