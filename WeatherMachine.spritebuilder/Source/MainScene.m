//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

-(void) didLoadFromCCB {
    //add additional initialization code
}

-(void) play{
    CCScene *gamescene = (CCScene *) [CCBReader load:@"GameScene"];
    [[CCDirector sharedDirector]replaceScene:gamescene];
}

@end
