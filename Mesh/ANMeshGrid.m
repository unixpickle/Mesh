//
//  ANMeshGrid.m
//  Mesh
//
//  Created by Nichol, Alexander on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANMeshGrid.h"

@interface ANMeshGrid (Private)

- (NSArray *)bandNodes:(int)index;

@end

@implementation ANMeshGrid

@synthesize friction;
@synthesize drag;
@synthesize nodes;
@synthesize bands;

- (id)initWithDimensions:(CGSize)size frame:(CGSize)scale {
    if ((self = [super init])) {        
        rows = (int)size.height;
        cols = (int)size.width;
        drawSize = scale;
        
        CGFloat spacingX = drawSize.width / (CGFloat)(cols - 1);
        CGFloat spacingY = drawSize.height / (CGFloat)(rows - 1);

        NSMutableArray * nodesM = [NSMutableArray array];
        NSMutableArray * bandsM = [NSMutableArray array];
        nodes = nodesM;
        
        for (int i = 0; i < rows * cols; i++) {
            int x = i % cols, y = i / cols;
            ANMeshNode * node = [[ANMeshNode alloc] init];
            node.location = CGPointMake(spacingX * x, spacingY * y);
            [nodesM addObject:node];
            
            NSArray * newBands = [self bandNodes:i];
            [bandsM addObjectsFromArray:newBands];
            
            // if this is a wall, lets make it immobile
            if (x == 0 || x == cols - 1) node.fixed = YES;
            else if (y == 0 || y == rows - 1) node.fixed = YES;
        }
        
        nodes = [NSArray arrayWithArray:nodesM];
        bands = [NSArray arrayWithArray:bandsM];
    }
    return self;
}

- (void)moveNodes:(NSTimeInterval)period {
    for (int i = 0; i < [nodes count]; i++) {
        ANMeshNode * node = [nodes objectAtIndex:i];
        [node accelerateWithTime:period friction:friction drag:drag];
    }
    for (int i = 0; i < [nodes count]; i++) {
        ANMeshNode * node = [nodes objectAtIndex:i];
        [node moveWithTime:period];
    }
}

#pragma mark - Private -

- (NSArray *)bandNodes:(int)index {
    CGFloat spacingX = drawSize.width / (CGFloat)(cols - 1);
    
    int x = index % cols;
    int y = index / cols;
    ANMeshNode * node = [nodes objectAtIndex:index];
    NSMutableSet * neighbors = [NSMutableSet set];
    
    if (x > 0) [neighbors addObject:[NSNumber numberWithInt:((x - 1) + (y * cols))]];
    if (y > 0) [neighbors addObject:[NSNumber numberWithInt:(x + ((y - 1) * cols))]];
    
    NSMutableArray * theBands = [NSMutableArray array];
    for (NSNumber * neighborIdx in neighbors) {
        ANMeshNode * neighbor = [nodes objectAtIndex:[neighborIdx intValue]];
        NSSet * nodeSet = [NSSet setWithObjects:node, neighbor, nil];
        ANMeshBand * band = [[ANMeshBand alloc] initWithNodes:nodeSet
                                               springConstant:kANMeshGridSpringConstant
                                                         rest:spacingX];
        [node addBand:band];
        [neighbor addBand:band];
        [theBands addObject:band];
    }
    return theBands;
}

@end
