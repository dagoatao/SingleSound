//
//  SoundCell.m
//  SingleSound
//
//  Created by Michael Colon on 2/13/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import "SoundCell.h"
#import "SoundManager.h"

@interface SoundCell()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SoundCell

#pragma mark - prepare for reuse

/*** Prepare cell for reuse. Meaning clear values that where used in 
 cell before.
 
 */

- (void) prepareForReuse {
  self.soundName = @"";
  self.name.text = @"";
  self.duration.text = @"";
  self.button.enabled = YES;
  [self.button setTitle:@"" forState:UIControlStateNormal];
}

#pragma mark - IBActions

/*** Play Sound Associated with this Cell.

 */
- (IBAction) verifyAndPlayMySound {
  // check if sound is playing.
  if ([[SoundManager instance] isPlayingSoundFileName:self.soundName]) return;
  // play sound by name.
  [[SoundManager instance] playSoundFileWithName:self.soundName];
  // flash the button.
  [self.button flash];
}

- (IBAction) deleteThisSound {
  [[SoundManager instance] removeSoundByFileName:self.soundName];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"SoundFileAddedOrDeleted" object:nil];
}

@end
