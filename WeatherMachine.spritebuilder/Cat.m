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
    self.physicsBody.collisionType = @"cat";
    self.physicsBody.collisionGroup = @"CatGroup";
}



@end
