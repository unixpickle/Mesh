//
//  ANMeshGrid.h
//  Mesh
//
//  Created by Nichol, Alexander on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANMeshNode.h"

@interface ANMeshGrid : NSObject {
    int rows, cols;
    CGSize drawSize;
    NSArray * nodes;
    NSArray * bands;
    ANMeshVector friction;
}

@property (readwrite) ANMeshVector friction;
@property (readonly) NSArray * nodes;
@property (readonly) NSArray * bands;

- (id)initWithDimensions:(CGSize)size frame:(CGSize)scale;
- (void)moveNodes:(NSTimeInterval)period;

@end
