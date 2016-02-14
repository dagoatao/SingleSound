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
@property (nonatomic, weak) IBOutlet UIButton *mc;
@property (nonatomic, weak) IBOutlet UIView *balloon;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIView *noSoundFilesView;
@end

@implementation ViewController

#pragma mark - init

- (void)viewDidLoad {
  [super viewDidLoad];
  self.balloon.alpha = 0;
  self.balloon.hidden = NO;
  self.noSoundFilesView.hidden = YES;
  [[SoundManager instance] loadSoundManagerWithSounds];
}
- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"SoundFileAddedOrDeleted" object:nil];
}

#pragma mark - memory warning

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Data work

- (void) reload {
  [self.collectionView reloadData];
  if ([[SoundManager instance] numberOfSounds] == 0) {
    self.noSoundFilesView.hidden = NO;
  } else {
    self.noSoundFilesView.hidden = YES;
  }
}


#pragma mark - CollectionView Delegate methods

// basic collection view stuff.
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return (NSInteger)[[SoundManager instance] numberOfSounds];
}

/** Return custom SoundCell.
 Populate cell with sound and file information.
 
 */
- (SoundCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  // grab a reusable cell
  SoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SoundCell" forIndexPath:indexPath];
  // set soundName
  cell.soundName = [[SoundManager instance] nameForSoundAtIndex:indexPath.row];
  //check to see if we need to disable button.
  if (cell.soundName == nil) cell.button.enabled = NO;
  //get formatted display name
  cell.name.text = [SoundManager displayNameForFileName:cell.soundName];
  // get the duration of the sound file.
  cell.duration.text = [[SoundManager instance] durationForSoundAtIndex:indexPath.row];
  // set button title to a number.
  [cell.button setTitle:[NSString stringWithFormat:@"%i", indexPath.row+1] forState:UIControlStateNormal];
  return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionSound" forIndexPath:indexPath];
  return view;
}

#pragma mark - IBActions 
/*** show speech bubble
 */
-(IBAction) showDeveloper:(id)sender {
  // play a click sound
  [[SoundManager instance] playSoundFileWithName:@"click0"];
  // run animatio to show speech bubble
  [UIView animateWithDuration:0.2f animations:^{
    // set alpha
    self.balloon.alpha = 1.0f;
  } completion:^(BOOL finished) {
    // fade out speech bubble after delay.
    [self performSelector:@selector(dissolveDeveloper) withObject:self afterDelay:1.0f];
  }];
}
/*** hide speech bubble
 */
- (void) dissolveDeveloper {
  // run animation to make speech bubble dissappear.
  [UIView animateWithDuration:1.0f animations:^{
    self.balloon.alpha = 0.0f;
  }];
}

/*** Action to load sound files in nib.
 Replaces existing, since there is no requirement to add sound files to 
 storage.
 */

- (IBAction) loadSoundFilesTapped:(id)sender {
  [[SoundManager instance] loadSoundManagerWithSounds];
  [self postSoundsModifiedNotification];
}

/** Action to remove all sound files from SoundManager
 All sound managers should be able to remove everything and start from scratch.
 */
- (IBAction) removeAllSoundsTapped:(id)sender {
  [[SoundManager instance] removeAllSounds];
  [self postSoundsModifiedNotification];
}

#pragma mark - Notifications

/*** Send notification out to appverse for any addition or deletion.
 
 */

- (void) postSoundsModifiedNotification {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"SoundFileAddedOrDeleted" object:nil];
}

#pragma mark - status bar modification.

/** hide status bar.
 */

- (BOOL)prefersStatusBarHidden
{
  return YES;
}


@end
