//
//  BPGSolDatesTableViewController.m
//  Rover
//
//  Created by Bradley GIlmore on 6/20/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "BPGSolDatesTableViewController.h"
#import "BPGMarsRover.h"
#import "BPGSol.h"
#import "BPGSolPhotosCollectionViewController.h"

@interface BPGSolDatesTableViewController ()

@end

@implementation BPGSolDatesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rover.solDescriptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"solDatesCell" forIndexPath:indexPath];
    
    BPGSol *sol = self.rover.solDescriptions[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Sol %ld", sol.sol];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld Photos", sol.numberOfPhotos];
    return cell;
}

- (void)setRover:(BPGMarsRover *)rover
{
    if (rover != _rover) {
        _rover = rover;
        [self.tableView reloadData];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPhotoCollectionView"]) {
        BPGSolPhotosCollectionViewController *destVC = segue.destinationViewController;
        destVC.rover = self.rover;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destVC.sol = self.rover.solDescriptions[indexPath.row];
    }
}

@end
