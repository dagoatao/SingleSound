//
//  ViewController.m
//  SingleSound
//
//  Created by Michael Colon on 2/12/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import "ViewController.h"
#import "SoundManager.h"
#import "SoundCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadSoundManagerWithSounds];
//  [[SoundManager instance] addSoundFileWithFileName:@"sound1.aiff"];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void) loadSoundManagerWithSounds {
  NSArray<NSURL*> *wavArray = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"wav" subdirectory:nil];
  NSArray<NSURL*> *mp3Array = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"mp3" subdirectory:nil];
  NSArray<NSURL*> *urlArray = [wavArray arrayByAddingObjectsFromArray:mp3Array];
  for (NSURL*url in urlArray) {
    [[SoundManager instance] addSoundFileWithFileName:url.relativeString];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate methods

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return (NSInteger)[[SoundManager instance] numberOfSounds];
}

- (SoundCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  SoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SoundCell" forIndexPath:indexPath];
  cell.soundName = [[SoundManager instance] nameForSoundAtIndex:indexPath.row];
  if (cell.soundName == nil) cell.button.enabled = NO;
  return cell;
}

#pragma mark - CollectionView Datasource




@end
