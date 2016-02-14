//
//  SoundCell.h
//  SingleSound
//
//  Created by Michael Colon on 2/13/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "SoundButton.h"

@interface SoundCell : UICollectionViewCell <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSString *soundName;
@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *duration;
@property (nonatomic, weak) IBOutlet SoundButton *button;

@end
