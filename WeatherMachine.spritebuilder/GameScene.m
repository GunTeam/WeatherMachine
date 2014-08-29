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
    
    currentTouch =CGPointMake(screenWidth/2,screenHeight/8);
    
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
    //[self schedule:@selector(addBallOYarn:) interval:dropInterval];
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
    if(touchLocation.y < (5./6)*screenHeight){
        currentTouch = CGPointMake(touchLocation.x, touchLocation.y);
    }
    else{
        currentTouch= CGPointMake(touchLocation.x, (5./6)*screenHeight);
    }
}

-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    if(touchLocation.y < (5./6)*screenHeight){
        currentTouch = CGPointMake(touchLocation.x, touchLocation.y);
    }
    else{
        currentTouch= CGPointMake(touchLocation.x, (5./6)*screenHeight);
    }
}

-(void) update:(CCTime)delta{
//    CGFloat newLocX = currentTouch.x - mainCat.position.x;
//    CGFloat newLocY = currentTouch.y - mainCat.position.y;
    CGPoint p0 = currentTouch;
    CGPoint p1 = mainCat.position;
    CGPoint pnormal = ccpSub(p0, p1);
    CGFloat angle = CGPointToDegree(pnormal);
    CGFloat xDist = (p1.x - p0.x);
    CGFloat yDist = (p1.y - p0.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    float k = 100000;
    float speed = 5;
//    if(distance>0){
//        speed = k*distance; //k*distance;
//    }
//    else{
//        speed = 5;
//    }
    float vx = cos(angle * M_PI / 180) * speed;
    float vy = sin(angle * M_PI / 180) * speed;
    CGPoint direction = CGPointMake(vx,vy);
    if(distance > 5){
        mainCat.position = ccpAdd(mainCat.position, direction);
    }
    float rand = arc4random()%70;
    
    if(rand <2){
        [self addBallOYarn:0];
    }
}

CGFloat CGPointToDegree(CGPoint point) {
    // Provides a directional bearing from (0,0) to the given point.
    // standard cartesian plain coords: X goes up, Y goes right
    // result returns degrees, -180 to 180 ish: 0 degrees = up, -90 = left, 90 = right
    CGFloat bearingRadians = atan2f(point.y, point.x);
    CGFloat bearingDegrees = bearingRadians * (180. / M_PI);
    return bearingDegrees;
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    currentTouch = touchLocation;
//    if(touchLocation.y < (5./6)*screenHeight){
//        mainCat.position = CGPointMake(touchLocation.x, touchLocation.y);
//    }
}

@end
