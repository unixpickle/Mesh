//
//  ANMeshGrid.h
//  Mesh
//
//  Created by Nichol, Alexander on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANMeshNode.h"

#define kANMeshGridSpringConstant 10

@interface ANMeshGrid : NSObject {
    int rows, cols;
    CGSize drawSize;
    NSArray * nodes;
    NSArray * bands;
    CGFloat friction;
	CGFloat drag;
}

@property (readwrite) CGFloat friction;
@property (readwrite) CGFloat drag;
@property (readonly) NSArray * nodes;
@property (readonly) NSArray * bands;

- (id)initWithDimensions:(CGSize)size frame:(CGSize)scale;
- (void)moveNodes:(NSTimeInterval)period;

@end
