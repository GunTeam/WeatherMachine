//
//  BallOYarn.h
//  WeatherMachine
//
//  Created by Jorrie Brettin on 8/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BallOYarn : CCSprite {
    CGFloat screenWidth,screenHeight;
}

-(void) setVelocity:(double)desiredVelocity;

@end
