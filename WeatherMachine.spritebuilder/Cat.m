//
//  Cat.m
//  WeatherMachine
//
//  Created by Jorrie Brettin on 8/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Cat.h"


@implementation Cat

-(void) didLoadFromCCB {
    self.collidable = true;
    self.physicsBody.collisionType = @"cat";
    self.physicsBody.collisionGroup = @"CatGroup";
    animationManager = self.userObject;
}

-(void) deathAnimation {
    self.collidable = false;
    [animationManager runAnimationsForSequenceNamed:@"Death"];
}
-(void) shrink {
    [self runAction:[CCActionScaleTo actionWithDuration:1 scale:0.4f]];
}


@end
