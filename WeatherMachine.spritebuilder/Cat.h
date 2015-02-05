//
//  Cat.h
//  WeatherMachine
//
//  Created by Jorrie Brettin on 8/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Cat : CCSprite {
    CCAnimationManager *animationManager;

}
@property bool collidable;

-(void) deathAnimation;
-(void) shrink;

@end
