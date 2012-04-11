//
//  ANMeshBand.h
//  Mesh
//
//  Created by Alex Nichol on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANMeshNode;

@interface ANMeshBand : NSObject {
    __weak ANMeshNode * node1;
    __weak ANMeshNode * node2;
    CGFloat springConstant;
    CGFloat restLength;
}

@property (nonatomic, weak) ANMeshNode * node1;
@property (nonatomic, weak) ANMeshNode * node2;
@property (readonly) CGFloat springConstant;
@property (readonly) CGFloat restLength;

- (id)initWithNodes:(NSSet *)theNodes springConstant:(CGFloat)spring rest:(CGFloat)rest;
- (CGFloat)stretchForce;
- (CGFloat)stretchAngle:(ANMeshNode *)sourceNode;

@end
