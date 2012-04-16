//
//  ANMeshGridView.h
//  Mesh
//
//  Created by Alex Nichol on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMeshGrid.h"
#import "ANMeshDragContext.h"

@interface ANMeshGridView : UIView {
    ANMeshGrid * meshGrid;
    NSTimer * animationTimer;
    NSDate * lastDraw;
    ANMeshDragContext * dragContext;
}

@property (readonly) ANMeshGrid * meshGrid;

- (id)initWithFrame:(CGRect)frame meshSize:(CGSize)dimensions;
- (void)startAnimation;
- (void)stopAnimation;
- (void)setFriction:(CGFloat)force;
- (void)setDrag:(CGFloat)coefficient;

@end
