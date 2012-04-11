//
//  ANMeshGridView.m
//  Mesh
//
//  Created by Alex Nichol on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANMeshGridView.h"

static CGFloat CGPointDistance(CGPoint p1, CGPoint p2);

@interface ANMeshGridView (Private)

- (void)redraw;

@end

@implementation ANMeshGridView

@synthesize meshGrid;

- (id)initWithFrame:(CGRect)frame meshSize:(CGSize)dimensions {
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        meshGrid = [[ANMeshGrid alloc] initWithDimensions:dimensions frame:frame.size];
    }
    return self;
}

- (void)setFriction:(CGFloat)force {
    meshGrid.friction = ANMeshVectorMake(force, force);
}

- (void)startAnimation {
    if (animationTimer != nil) return;
    lastDraw = nil;
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
                                                      target:self
                                                    selector:@selector(redraw)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)stopAnimation {
    [animationTimer invalidate];
    animationTimer = nil;
    lastDraw = nil;
}

- (void)redraw {
    NSDate * now = [NSDate date];
    NSTimeInterval duration = 0;
    if (lastDraw) {
        duration = [now timeIntervalSinceDate:lastDraw];
    }
    lastDraw = now;
    if (duration > 0) {
        [meshGrid moveNodes:duration];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw bands
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 5);
    for (NSUInteger i = 0; i < [[meshGrid bands] count]; i++) {
        ANMeshBand * band = [[meshGrid bands] objectAtIndex:i];
        CGPoint p1 = band.node1.location;
        CGPoint p2 = band.node2.location;
        CGPoint points[2] = {p1, p2};
        CGContextStrokeLineSegments(context, points, 2);
    }
    
    // draw nodes
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.8);
    for (NSUInteger i = 0; i < [[meshGrid nodes] count]; i++) {
        ANMeshNode * node = [[meshGrid nodes] objectAtIndex:i];
        CGPoint dotPoint = [node location];
        CGContextFillEllipseInRect(context, CGRectMake(dotPoint.x - 10, dotPoint.y - 10, 20, 20));
    }
}

#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    
    ANMeshNode * node = nil;
    CGFloat distance = CGFLOAT_MAX;
    for (ANMeshNode * aNode in [meshGrid nodes]) {
        CGFloat dist = CGPointDistance(aNode.location, point);
        if (dist < distance) {
            distance = dist;
            node = aNode;
        }
    }
    
    if (!dragContext) {
        dragContext = [[ANMeshDragContext alloc] init];
    }

    dragContext.touchStart = point;
    dragContext.nodeStart = node.location;
    dragContext.fixed = node.fixed;
    dragContext.node = node;
    node.velocity = ANMeshVectorMake(0, 0);
    node.fixed = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    ANMeshNode * node = dragContext.node;
    CGPoint point = [dragContext nodePointForTouchPoint:touchPoint];
    node.location = point;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    dragContext.node.fixed = dragContext.fixed;
    dragContext = nil;
}

@end

static CGFloat CGPointDistance(CGPoint p1, CGPoint p2) {
    return sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2));
}
