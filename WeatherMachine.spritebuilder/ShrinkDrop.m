//
//  ShrinkDrop.m
//  WeatherMachine
//
//  Created by Laura Breiman on 9/9/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "ShrinkDrop.h"


@implementation ShrinkDrop
-(void) didLoadFromCCB {
    //grab screen size (3.5 inch or 4 inch screen)
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    self.physicsBody.angularVelocity = (arc4random() % 60 + 1)*.1 ;
    
    self.physicsBody.collisionType = @"shrinkdrop";
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
