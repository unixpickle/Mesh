//
//  ANMeshDragContext.h
//  Mesh
//
//  Created by Alex Nichol on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANMeshNode;

@interface ANMeshDragContext : NSObject {
    CGPoint touchStart;
    CGPoint nodeStart;
    BOOL fixed;
    __weak ANMeshNode * node;
}

@property (readwrite) CGPoint touchStart;
@property (readwrite) CGPoint nodeStart;
@property (readwrite) BOOL fixed;
@property (nonatomic, weak) ANMeshNode * node;

- (CGPoint)nodePointForTouchPoint:(CGPoint)point;

@end
