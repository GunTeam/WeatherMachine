//
//  SlowDown.h
//  WeatherMachine
//
//  Created by Laura Breiman on 9/8/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SlowDown : CCSprite {
    CGFloat screenWidth,screenHeight;
}

-(void) setVelocity:(double)desiredVelocity;
@end
