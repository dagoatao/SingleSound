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

- (void) loadSoundManagerWithSounds;

- (NSArray<NSURL*>*) soundsInBundle;

- (void) addSoundFileWithFileName:(NSString*)fileName;

- (void) removeAllSounds;

- (void) removeSoundByFileName:(NSString*)fileName;

- (NSInteger) numberOfSounds;

- (void) playSoundFileWithName:(NSString*)name;

- (void) playSoundFileWithName:(NSString*)name avPlayerDelegate:(id)delegate;

- (BOOL) isPlayingSoundFileName:(NSString*)name;

- (NSString*) nameForSoundAtIndex:(NSInteger)row;

- (NSString*) durationForSoundAtIndex:(NSInteger)row;

+ (NSString*) displayNameForFileName:(NSString*)name;

@end
