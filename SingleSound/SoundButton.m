//
//  SoundButton.m
//  SingleSound
//
//  Created by Michael Colon on 2/13/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import "SoundButton.h"

@implementation SoundButton

#pragma mark - initialization

- (id) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  [self style];
  return self;
}
          
- (id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self style];
  return self;
}

#pragma mark - button style

/** style the button
 */
- (void) style {
  // round button corners.
  self.layer.cornerRadius = self.frame.size.width*0.5;
  [self getPresets];
}

/** get presets after style
 */
- (void) getPresets {
  // get color.
    self.originalColor = self.backgroundColor;
}

#pragma mark - flash
/*** flash the button.
 */
- (void) flash {
  // run animation to flash button.
  [UIView animateWithDuration:0.10 animations:^{
    self.backgroundColor = [UIColor blueColor];
  } completion:^(BOOL finished) {
    self.backgroundColor = self.originalColor;
  }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
}
*/


@end
