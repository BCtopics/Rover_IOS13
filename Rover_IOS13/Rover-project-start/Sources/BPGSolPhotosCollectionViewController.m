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
//#import "BPGMarsPhotoDetailViewController.h"
#import "Rover-Swift.h"

@interface BPGSolPhotosCollectionViewController ()

@property (nonatomic, strong, readonly) BPGMarsRoverClient *client;
@property (nonatomic, copy) NSArray *photoReferences;

@end

@implementation BPGSolPhotosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

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
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
