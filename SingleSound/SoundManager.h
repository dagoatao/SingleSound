//
//  SoundManager.h
//  SingleSound
//
//  Created by Michael Colon on 2/12/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject
+ (id) instance;
- (void) addSoundFileWithFileName:(NSString*)fileName;
- (void) removeAllSounds;
- (void) removeSoundByFileName:(NSString*)fileName;
- (NSInteger) numberOfSounds;
- (void) playSoundFileWithName:(NSString*)name;
- (NSString*) nameForSoundAtIndex:(NSInteger)row;
@end
