//
//  SoundCell.m
//  SingleSound
//
//  Created by Michael Colon on 2/13/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import "SoundCell.h"
#import "SoundManager.h"

@implementation SoundCell

- (void) prepareForReuse {
  self.soundName = nil;
  self.button.enabled = YES;
}

- (IBAction) verifyAndPlayMySound {
  [[SoundManager instance] playSoundFileWithName:self.soundName];
}
@end
