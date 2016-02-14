//
//  SingleSoundTests.m
//  SingleSoundTests
//
//  Created by Michael Colon on 2/12/16.
//  Copyright © 2016 Michael Colon. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SoundManager.h"

@interface SingleSoundTests : XCTestCase
@property (nonatomic, strong) SoundManager *manager;
@end

@implementation SingleSoundTests

- (void)setUp {
    [super setUp];
    self.manager = [SoundManager instance];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
//    [SoundManager removeSounds];
}

- (void)testAddSoundByName {
  [self.manager addSoundFileWithFileName:@"sound1.aiff"];
}

- (void) testPlaySound {
}

- (void) testAddSoundsByName {
  [self.manager addSoundFileWithFileName:@"sound1.aiff"];
  [self.manager addSoundFileWithFileName:@"sound1.aiff"];
  [self.manager addSoundFileWithFileName:@"sound1.aiff"];
}

- (void)testRemoveASingleSound {
  NSInteger deletedCount = -1;
  NSInteger count = [self.manager numberOfSounds];
  XCTAssertTrue(count>1, @"In order for this test to pass there must be at least more then two files.");
  [self.manager removeSoundByFileName:@"sound1.aiff"];
  deletedCount = [self.manager numberOfSounds];
  XCTAssertTrue(count == (deletedCount+1), @"deleted count + 1 should equal count");
}

- (void) testRemoveAllSounds {
  XCTAssertTrue([self.manager numberOfSounds] > 2, @"In order for this test to pass there must be at least more then two files.");
  [self.manager removeAllSounds];
  XCTAssertTrue([self.manager numberOfSounds] == 0, @"Number of sounds should be zero.");
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
