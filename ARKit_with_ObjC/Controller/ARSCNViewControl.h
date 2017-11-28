//
//  ARSCNViewControl.h
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARViewController.h"
#import "ARAlertController.h"

@interface ARSCNViewControl : NSObject<ARSCNViewDelegate, ARSessionDelegate>

@property (nonatomic, weak) ARViewController *viewController;
@property (nonatomic, weak) ARAlertController *alertController;

@end
