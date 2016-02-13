//
//  SoundManager.m
//  SingleSound
//
//  Created by Michael Colon on 2/12/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import "SoundManager.h"
#import <AVFoundation/AVAudioPlayer.h>

#define MAX_SOUND_EFFECTS 100

@interface SoundManager()
@property (nonatomic, strong) NSMutableDictionary<NSString*, AVAudioPlayer *> *sounds;
@end

@implementation SoundManager

# pragma mark - Initialization

+(id)instance {
  static SoundManager *sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedManager = [[self alloc] init];
  });
  return sharedManager;
}

- (id) init {
  // grab super instance
  self = [super init];
  // check self
  if (!self) return nil;
  // define (private) Mutable Dictionary
  _sounds = [[NSMutableDictionary alloc] initWithCapacity:MAX_SOUND_EFFECTS];
  return self;
}

# pragma mark - Adding sounds to manager.

/***
Add sound method.
*/
- (void) addSoundFileAtURL:(NSURL*)soundURL withName:(NSString*)soundName {
  // check to see if we exceeded max sound effects.
  if (_sounds && _sounds.count >= MAX_SOUND_EFFECTS) {
    // write warning message to log
    [self writeLog:[NSString stringWithFormat:@"Max sounds reached. Could not add sound %@ at path %@", soundName, soundURL.path] isError:NO];
    return;
  }
  if ( soundURL == nil || soundName == nil) {
    [self writeLog:[NSString stringWithFormat:@"SoundURL or SoundName is nil. Cannot add"] isError:NO];
    return;
  }
  // initialize NSError incase the url or sound file is bad.
  NSError *error = nil;
  // create sound player from url
  AVAudioPlayer *toAdd = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
  // check if an error occured
  if (error) {
    //write error to log.
    [self writeLog:[NSString stringWithFormat:@"addSoundFilePath: Could not add file %@ at URL: %@", soundName, soundURL.path] isError:YES];
  }
  // add sound to dictionary of sound
  [_sounds setObject:toAdd forKey:soundName];
  // prepare to play.
  [_sounds[soundName] prepareToPlay];
}

/***
Add sound file by name.
Name must conform to either a .mp3 or .aac extension. Expected format is filename.extension
*/

- (void) addSoundFileWithFileName:(NSString*)fileName {
  NSArray<NSString*> *components = [self fileNameComponents:fileName];
  if (components==nil)return;
  // all possible errors are handled in addSoundFileAtURL method. No need for addtional error handling here.
  [self addSoundFileAtURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:components[0] ofType:components[1]]] withName:components[0]];
}

# pragma mark - Parse file name.

- (NSArray<NSString*>*) fileNameComponents:(NSString*)fileName {
  // check file name format
  NSArray<NSString*> *components = [fileName componentsSeparatedByString:@"."];
  // check component count
  if (components.count != 2) return nil; // add error to log.
  // check that the extension is three characters
  if (components[1].length != 3) return nil; // add errror to log.
  return components;
}


# pragma mark - Removing sounds from manager


- (void) removeAllSounds {
  [_sounds removeAllObjects];
}

- (void) removeSoundByFileName:(NSString*)fileName {
  NSArray<NSString*> *components = [self fileNameComponents:fileName];
  if (components == nil) return;
  [_sounds removeObjectForKey:components[0]];
}


# pragma mark - Playing sounds

- (void) playSoundFileWithName:(NSString*)name {
  if (! [self verifySound:name]) return;
  [_sounds[name] play];
  
}

# pragma mark - Sound validation.

- (NSInteger) verifySound:(NSString*)name {
  return (NSInteger)([self hasSounds] && [self soundExists:name]);
}

- (NSInteger) hasSounds {
  return (NSInteger)(_sounds && [self numberOfSounds] > 0);
}

- (NSInteger) soundExists:(NSString*)name {
  return (NSInteger)([[_sounds allKeys] containsObject:name]);
}

- (NSInteger) numberOfSounds {
  return _sounds.count;
}

#pragma mark - Find Sounds 
- (NSString*) nameForSoundAtIndex:(NSInteger)row {
  if ([self numberOfSounds] <= row) return nil;
  return [_sounds allKeys][row];
}

# pragma mark - Console writing.

/**
 method for console logging.
 */
- (void) writeLog:(NSString*)message isError:(BOOL)isError {
  if (isError) {
    NSLog(@"ErrorLog: SoundManager.m/%@", message);
  } else {
    NSLog(@"WarningLog: SoundManager.m/%@", message);
  }
}

@end
