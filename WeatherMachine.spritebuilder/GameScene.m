//
//  GameScene.m
//  WeatherMachine
//
//  Created by Jorrie Brettin on 8/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameScene.h"

//debugging/playtesting variables
double dropVelocity = 200;
double dropInterval = 1.2;

@implementation GameScene

-(void) didLoadFromCCB {
    self.dropVelocity = dropVelocity;
    self.level = 1;
    self.userInteractionEnabled = true;
    self.multipleTouchEnabled = true;
    [[[CCDirector sharedDirector] view] setMultipleTouchEnabled:YES];
    
    //grab screen size (3.5 inch or 4 inch screen)
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    _physicsNode = [[CCPhysicsNode alloc]init];
    [self addChild:_physicsNode];
    _physicsNode.collisionDelegate = self;

    
    mainCat = (Cat *) [CCBReader load:@"Cat"];
    mainCat.position = CGPointMake(screenWidth/2, screenHeight/8);
    mainCat.scale = .8;
    [_physicsNode addChild:mainCat];
    
//    BallOYarn *yarn = (BallOYarn *)[CCBReader load:@"BallOYarn"];
//    yarn.position = CGPointMake(screenWidth/2, screenHeight);
//    yarn.physicsBody.velocity = CGPointMake(0, -150);
//    [_physicsNode addChild:yarn];
    [self schedule:@selector(addBallOYarn:) interval:dropInterval];
}

-(void) addBallOYarn:(CCTime)delta{
    BallOYarn *yarn = (BallOYarn *)[CCBReader load:@"BallOYarn"];
    [_physicsNode addChild:yarn];
    [yarn setVelocity:self.dropVelocity];

}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)cat balloyarn:(BallOYarn *)balloyarn {
    CCLOG(@"collision occurred");
    //this just resets the scene
    //can be changed to actually do things like a crash animation and whatnot
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"GameScene"]];
    
    return true;
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CCLOG(@"touchBegan");
    CGPoint touchLocation = [touch locationInNode:self];
    mainCat.position = CGPointMake(touchLocation.x, mainCat.position.y);

}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CCLOG(@"touchMoved");
    CGPoint touchLocation = [touch locationInNode:self];
    mainCat.position = CGPointMake(touchLocation.x, mainCat.position.y);

}

@end
