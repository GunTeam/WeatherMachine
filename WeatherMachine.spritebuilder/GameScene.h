//
//  GameScene.h
//  WeatherMachine
//
//  Created by Jorrie Brettin on 8/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Cat.h"
#import "BallOYarn.h"

@interface GameScene : CCNode <CCPhysicsCollisionDelegate> {
    CGFloat screenWidth,screenHeight;
    Cat *mainCat;
    CCPhysicsNode *_physicsNode;
    CGPoint currentTouch;
}

@property int level;
@property double dropVelocity;

@end
