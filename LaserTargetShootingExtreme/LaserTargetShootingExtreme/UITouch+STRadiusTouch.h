//
//  UITouch+STRadiusTouch.h
//  STRadiusTouch
//
//  Created by Steven Thompson on 2014-08-21.
//  Copyright (c) 2014 Steven Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface UITouch (STRadiusTouch)

///Does the touch hit specified UIView
- (BOOL)touchesView:(UIView *)view;

///Returns an array of views the touch hits
- (NSArray *)touchedViews;

//MARK: SpriteKit

///Does the touch hit specified SKNode
- (BOOL)touchesNode:(SKNode *)node;

///Returns an array of nodes the touch hits
- (NSArray *)touchedNodes;

@end
