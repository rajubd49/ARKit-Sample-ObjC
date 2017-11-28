//
//  ARGestureControl.h
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARViewController.h"

@interface ARGestureControl : NSObject

@property (nonatomic, strong) SCNNode *selectedNode;

@property (nonatomic, weak) ARViewController *viewController;

- (void)setupGestureRecognizer;
- (void)removeARObject:(id)sender;

@end
