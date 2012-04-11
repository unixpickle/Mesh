//
//  ANViewController.h
//  Mesh
//
//  Created by Alex Nichol on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMeshGridView.h"

@interface ANViewController : UIViewController {
    ANMeshGridView * grid;
    UISlider * forceSlider;
}

- (void)forceChanged:(id)sender;

@end
