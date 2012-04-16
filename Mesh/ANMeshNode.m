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

CGFloat ANMeshVectorGetAngle(ANMeshVector v1) {
    return atan2(v1.y, v1.x);
}

CGFloat ANMeshVectorGetMagnitude(ANMeshVector v1) {
    return sqrt(pow(v1.x, 2) + pow(v1.y, 2));
}

ANMeshVector ANMeshVectorApplyOpposingForce(ANMeshVector v1, ANMeshVector v2, NSTimeInterval time) {
    v2.x *= time;
    v2.y *= time;
    ANMeshVector newVec = v1;
    if (newVec.x < 0) {
        newVec.x += v2.x;
        if (newVec.x > 0) newVec.x = 0;
    } else if (newVec.x > 0) {
        newVec.x += v2.x;
        if (newVec.x < 0) newVec.x = 0;
    }
    if (newVec.y < 0) {
        newVec.y += v2.y;
        if (newVec.y > 0) newVec.y = 0;
    } else if (newVec.y > 0) {
        newVec.y += v2.y;
        if (newVec.y < 0) newVec.y = 0;
    }
    return newVec;
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

- (void)accelerateWithTime:(NSTimeInterval)passed friction:(CGFloat)coeff drag:(CGFloat)drag {
    if (fixed) return;
    
    ANMeshVector force = [self netForceVector];
    velocity.x += force.x * passed;
    velocity.y += force.y * passed;
    
    CGFloat velMagnitude = ANMeshVectorGetMagnitude(velocity);
    CGFloat velAngle = ANMeshVectorGetAngle(velocity);
    ANMeshVector friction = ANMeshVectorMakeAngle(-coeff, velAngle);
    ANMeshVector dragVector = ANMeshVectorMakeAngle(-drag * velMagnitude, velAngle);
    
    velocity = ANMeshVectorApplyOpposingForce(velocity, friction, passed);
    velocity = ANMeshVectorApplyOpposingForce(velocity, dragVector, passed);
}

- (void)moveWithTime:(NSTimeInterval)passed {
    if (fixed) return;
    
    location.x += velocity.x * passed;
    location.y += velocity.y * passed;
}

@end
