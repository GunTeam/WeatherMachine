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
    
    //generate random x position where the sprite will still be fully on the screen
    int randRange = screenWidth-self.contentSizeInPoints.width;
    float posX = arc4random()%(randRange) + self.contentSizeInPoints.width/2;

    //assign sprite to generated x position and to y position just above the screen
    self.position = CGPointMake(posX, screenHeight+self.contentSizeInPoints.height/2);
    
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
