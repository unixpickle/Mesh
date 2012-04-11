//
//  ANMeshNode.m
//  Mesh
//
//  Created by Alex Nichol on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANMeshNode.h"

ANMeshVector ANMeshVectorMake(CGFloat x, CGFloat y) {
    ANMeshVector vector;
    vector.x = x;
    vector.y = y;
    return vector;
}

ANMeshVector ANMeshVectorMakeAngle(CGFloat mag, CGFloat angle) {
    ANMeshVector vector;
    vector.x = cos(angle) * mag;
    vector.y = sin(angle) * mag;
    return vector;
}

ANMeshVector ANMeshVectorAdd(ANMeshVector v1, ANMeshVector v2) {
    ANMeshVector sum;
    sum.x = v1.x + v2.x;
    sum.y = v1.y + v2.y;
    return sum;
}

@implementation ANMeshNode

@synthesize location;
@synthesize velocity;
@synthesize bands;
@synthesize fixed;

- (void)addBand:(ANMeshBand *)aBand {
    if (!bands) {
        bands = [[NSMutableArray alloc] init];
    }
    [bands addObject:aBand];
}

- (ANMeshVector)netForceVector {
    ANMeshVector vector = ANMeshVectorMakeAngle(0, 0);
    for (ANMeshBand * band in bands) {
        ANMeshVector bandVec = ANMeshVectorMakeAngle([band stretchForce], [band stretchAngle:self]);
        vector = ANMeshVectorAdd(vector, bandVec);
    }
    return vector;
}

- (void)accelerateWithTime:(NSTimeInterval)passed friction:(ANMeshVector)coeff {
    if (fixed) return;
    
    ANMeshVector force = [self netForceVector];
    velocity.x += force.x * passed;
    velocity.y += force.y * passed;
    
    if (velocity.x > 0) {
        velocity.x = MAX(0, velocity.x - coeff.x);
    } else {
        velocity.x = MIN(0, velocity.x + coeff.x);
    }
    if (velocity.y > 0) {
        velocity.y = MAX(0, velocity.y - coeff.y);
    } else {
        velocity.y = MIN(0, velocity.y + coeff.y);
    }
}

- (void)moveWithTime:(NSTimeInterval)passed {
    if (fixed) return;
    
    location.x += velocity.x * passed;
    location.y += velocity.y * passed;
}

@end
