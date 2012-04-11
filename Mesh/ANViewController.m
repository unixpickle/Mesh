//
//  ANViewController.m
//  Mesh
//
//  Created by Alex Nichol on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANViewController.h"

@interface ANViewController ()

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    grid = [[ANMeshGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)
                                        meshSize:CGSizeMake(4, 4)];
    [grid startAnimation];
    [self.view addSubview:grid];
    
    forceSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 330, 300, 20)];
    [forceSlider addTarget:self action:@selector(forceChanged:) forControlEvents:UIControlEventValueChanged];
    [forceSlider setValue:0];
    [self.view addSubview:forceSlider];
}

- (void)forceChanged:(id)sender {
    [grid setFriction:([forceSlider value])];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
