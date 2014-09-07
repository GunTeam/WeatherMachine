//
//  BallOYarn.m
//  WeatherMachine
//
//  Created by Jorrie Brettin on 8/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "BallOYarn.h"


@implementation BallOYarn

-(void) didLoadFromCCB {
    //grab screen size (3.5 inch or 4 inch screen)
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    self.physicsBody.angularVelocity = (arc4random() % 60 + 1)*.1 ;
    
    self.physicsBody.collisionType = @"balloyarn";
    self.physicsBody.collisionGroup = @"FallingGroup";
}

-(void) update:(CCTime)delta{
    if (self.position.y < 0 - self.contentSizeInPoints.height/2) {
        [self removeFromParentAndCleanup:true];
    }
}

-(void)setVelocity:(double)desiredVelocity{
    self.physicsBody.velocity = CGPointMake(0, -desiredVelocity);
}

@end
