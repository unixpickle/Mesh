//
//  ANMeshDragContext.m
//  Mesh
//
//  Created by Alex Nichol on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANMeshDragContext.h"

@implementation ANMeshDragContext

@synthesize touchStart;
@synthesize nodeStart;
@synthesize fixed;
@synthesize node;

- (CGPoint)nodePointForTouchPoint:(CGPoint)point {
    CGPoint offset = CGPointMake(point.x - touchStart.x, point.y - touchStart.y);
    return CGPointMake(nodeStart.x + offset.x, nodeStart.y + offset.y);
}

@end
