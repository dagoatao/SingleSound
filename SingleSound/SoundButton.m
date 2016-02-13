//
//  SoundButton.m
//  SingleSound
//
//  Created by Michael Colon on 2/13/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import "SoundButton.h"

@implementation SoundButton

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

- (void) style {
    self.layer.cornerRadius = self.frame.size.width*0.5;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
}
*/


@end
