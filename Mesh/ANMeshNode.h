//
//  ANMeshNode.h
//  Mesh
//
//  Created by Alex Nichol on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANMeshBand.h"

typedef struct {
    CGFloat x, y;
} ANMeshVector;

ANMeshVector ANMeshVectorMake(CGFloat x, CGFloat y);
ANMeshVector ANMeshVectorMakeAngle(CGFloat mag, CGFloat angle);
ANMeshVector ANMeshVectorAdd(ANMeshVector v1, ANMeshVector v2);

@interface ANMeshNode : NSObject {
    CGPoint location;
    ANMeshVector velocity;
    NSMutableArray * bands;
    BOOL fixed;
}

@property (readwrite) CGPoint location;
@property (readwrite) ANMeshVector velocity;
@property (nonatomic, strong) NSMutableArray * bands;
@property (readwrite, getter = isFixed) BOOL fixed;

- (void)addBand:(ANMeshBand *)aBand;

- (ANMeshVector)netForceVector;
- (void)accelerateWithTime:(NSTimeInterval)passed friction:(ANMeshVector)coeff;
- (void)moveWithTime:(NSTimeInterval)passed;

@end
