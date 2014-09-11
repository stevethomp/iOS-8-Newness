//
//  UITouch+STRadiusTouch.m
//  STRadiusTouch
//
//  Created by Steven Thompson on 2014-08-21.
//  Copyright (c) 2014 Steven Thompson. All rights reserved.
//

#import "UITouch+STRadiusTouch.h"

CGFloat sqr(CGFloat x) { return x*x; }
CGFloat dist2(CGPoint v, CGPoint w) { return sqr(v.x - w.x) + sqr(v.y - w.y); }
CGFloat distanceToSegmentSquared(CGPoint p, CGPoint v, CGPoint w)
{
    CGFloat l2 = dist2(v, w);
    if (l2 == 0.0f) return dist2(p, v);
    
    CGFloat t = ((p.x - v.x) * (w.x - v.x) + (p.y - v.y) * (w.y - v.y)) / l2;
    if (t < 0.0f) return dist2(p, v);
    if (t > 1.0f) return dist2(p, w);
    return dist2(p, CGPointMake(v.x + t * (w.x - v.x), v.y + t * (w.y - v.y)));
}
CGFloat distanceToSegment(CGPoint point, CGPoint segmentPointV, CGPoint segmentPointW)
{
    return sqrtf(distanceToSegmentSquared(point, segmentPointV, segmentPointW));
}

@interface UIView (subViews)
- (NSMutableArray*) allSubViews;
@end

@implementation UIView (subViews)

- (NSMutableArray*)allSubViews
{
    NSMutableArray *subviews = [NSMutableArray array];
    [subviews addObject:self];
    for (UIView *subview in self.subviews)
    {
        [subviews addObjectsFromArray:(NSArray*)[subview allSubViews]];
    }
    return subviews;
}

@end

@implementation UITouch (STRadiusTouch)

- (BOOL)touchesView:(UIView *)view {
    //Convert touch to fake UIView
    
    UIView *touchView = self.view;
    while (touchView.superview) {
        touchView = touchView.superview;
    }
    
    CGFloat radius = self.majorRadius;
    radius = 15.0;
    CGPoint location = [self locationInView:touchView];
    CGRect viewFrame = view.frame;
    
    CGPoint a = CGPointMake(view.frame.origin.x, view.frame.origin.y);
    CGPoint b = CGPointMake(view.frame.origin.x+view.frame.size.width, view.frame.origin.y);
    CGPoint c = CGPointMake(view.frame.origin.x+view.frame.size.width, view.frame.origin.y+view.frame.size.height);
    CGPoint d = CGPointMake(view.frame.origin.x, view.frame.origin.y+view.frame.size.height);
    //
    
    if (CGRectContainsPoint(viewFrame, location) ||
        [self circleWithRadius:radius centre:location includesPoint:a] ||
        [self circleWithRadius:radius centre:location includesPoint:b] ||
        [self circleWithRadius:radius centre:location includesPoint:c] ||
        [self circleWithRadius:radius centre:location includesPoint:d] ||
        [self lineIntersectsCircleWithStartPoint:a endPoint:b radius:radius centre:location] ||
        [self lineIntersectsCircleWithStartPoint:b endPoint:c radius:radius centre:location] ||
        [self lineIntersectsCircleWithStartPoint:c endPoint:d radius:radius centre:location] ||
        [self lineIntersectsCircleWithStartPoint:d endPoint:a radius:radius centre:location]) {
        return YES;
        
    } else {
        return NO;
    }
}

- (NSArray *)touchedViews {
    NSMutableArray *views = [NSMutableArray array];
    
    UIView *superView = self.view;
    while (superView.superview) {
        superView = superView.superview;
    }

    for (UIView *view in [superView allSubViews]) {
        if ([self touchesView:view]) {
            [views addObject:view];
        }
    }
    
    return views;
}

//MARK: SpriteKit

//- (BOOL)touchesNode:(SKNode *)node {
//
//}

//- (NSArray *)touchedNodes;
//
//}

- (BOOL)rect:(CGRect)rect containsPoint:(CGPoint)point {
    if (rect.origin.x <= point.x <= rect.origin.x+rect.size.width && rect.origin.y <= point.y <= rect.origin.y+rect.size.height) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)lineIntersectsCircleWithStartPoint:(CGPoint)start endPoint:(CGPoint)end radius:(CGFloat)radius centre:(CGPoint)centre {
    if (distanceToSegment(centre, start, end) < radius) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)circleWithRadius:(CGFloat)radius centre:(CGPoint)centre includesPoint:(CGPoint)point {
    CGFloat distance = hypotf(centre.x - point.x, centre.y - point.y);
    if (distance < radius) {
        return YES;
    } else {
        return NO;
    }
}

@end