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
    [[CCDirector sharedDirector] setDisplayStats:true];
    Background *background = (Background *) [CCBReader load:@"Background"];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
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
    
    cloud = (Cloud*)[CCBReader load:@"Cloud"];
    cloud.position = CGPointMake(screenWidth/2, screenHeight*(99./100));
    cloud.scale = .8;
    [self addChild:cloud];
    
    
//    BallOYarn *yarn = (BallOYarn *)[CCBReader load:@"BallOYarn"];
//    yarn.position = CGPointMake(screenWidth/2, screenHeight);
//    yarn.physicsBody.velocity = CGPointMake(0, -150);
//    [_physicsNode addChild:yarn];
    //[self schedule:@selector(addBallOYarn:) interval:dropInterval];
}

-(void) addRainDrop:(CCTime)delta{
    
    float rand = arc4random()%70;
    
    
    BallOYarn *raindrop = (BallOYarn *)[CCBReader load:@"BallOYarn"];
    
    //generate random x position where the sprite will still be fully on the screen
    int randRange = screenWidth-raindrop.contentSizeInPoints.width;
    float posX = arc4random()%(randRange) + raindrop.contentSizeInPoints.width/2;
    
    //assign sprite to generated x position and to y position just above the screen
    cloud.position = CGPointMake(posX, screenHeight*(99./100));
    //With a probability of 2/70, make the raindrop a powerup
    if(rand <25){
        SpeedUp *greendrop = (SpeedUp *)[CCBReader load:@"SpeedUp"];
        greendrop.position = CGPointMake(posX, screenHeight+greendrop.contentSizeInPoints.height/2);
        
        [_physicsNode addChild:greendrop];
        [greendrop setVelocity:self.dropVelocity];
    }
    else if(rand<50){
        SlowDown *slowdown = (SlowDown *)[CCBReader load:@"SlowDown"];
        slowdown.position = CGPointMake(posX, screenHeight+slowdown.contentSizeInPoints.height/2);
        
        [_physicsNode addChild:slowdown];
        [slowdown setVelocity:self.dropVelocity];
    }
    else if(rand<70){
        ShrinkDrop *shrinkdrop = (ShrinkDrop *)[CCBReader load:@"ShrinkDrop"];
        shrinkdrop.position = CGPointMake(posX, screenHeight+shrinkdrop.contentSizeInPoints.height/2);
        
        [_physicsNode addChild:shrinkdrop];
        [shrinkdrop setVelocity:self.dropVelocity];
    }
    else{
        raindrop.position = CGPointMake(posX, screenHeight+raindrop.contentSizeInPoints.height/2);
        
        [_physicsNode addChild:raindrop];
        [raindrop setVelocity:self.dropVelocity];
    }


}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)cat balloyarn:(BallOYarn *)balloyarn {
    CCLOG(@"collision occurred");
    //this just resets the scene
    //can be changed to actually do things like a crash animation and whatnot
    if(mainCat.collidable == true){
        [mainCat deathAnimation];
        [self scheduleOnce:@selector(resetGame) delay:2];
    }
    return true;
}
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)cat speedup:(SpeedUp *)speedup {
    CCLOG(@"speedup collision");
    //this speeds up the velocity of all the drops
    self.dropVelocity+=50;
    [speedup removeFromParent];
    return true;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)cat shrinkdrop:(ShrinkDrop *)shrinkdrop {
    //this shrinks your main cat
    double a = mainCat.scale;
    if(mainCat.scale>0.2){
    }
    [shrinkdrop removeFromParent];
    return true;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair cat:(Cat *)cat slowdown:(SlowDown *)slowdown {
    CCLOG(@"slowdown collision");
    //this slows the velocity of all the drops
    if(self.dropVelocity > 50){
        self.dropVelocity-=50;
    }
    else{
        self.dropVelocity = 1;
    }
    [slowdown removeFromParent];
    return true;
}
-(void) resetGame{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"GameScene"]];
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
        [self addRainDrop:0];
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
