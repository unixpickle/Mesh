//
//  ANMeshBand.m
//  Mesh
//
//  Created by Alex Nichol on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANMeshBand.h"
#import "ANMeshNode.h"

@implementation ANMeshBand

@synthesize node1;
@synthesize node2;
@synthesize springConstant;
@synthesize restLength;

- (id)initWithNodes:(NSSet *)theNodes springConstant:(CGFloat)spring rest:(CGFloat)rest {
    if ((self = [super init])) {
        for (id obj in theNodes) {
            if (node1) node2 = obj;
            else node1 = obj;
        }
        springConstant = spring;
        restLength = rest;
    }
    return self;
}

- (CGFloat)stretchForce {
    CGFloat length = sqrt(pow(node1.location.x - node2.location.x, 2) + pow(node1.location.y - node2.location.y, 2));
    return springConstant * (length - restLength);
}

- (CGFloat)stretchAngle:(ANMeshNode *)sourceNode {
    ANMeshNode * destNode = (sourceNode == node1 ? node2 : node1);
    return atan2(destNode.location.y - sourceNode.location.y, destNode.location.x - sourceNode.location.x);
}

@end
