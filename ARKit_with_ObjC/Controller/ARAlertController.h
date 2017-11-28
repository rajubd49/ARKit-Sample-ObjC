//
//  ARAlertController.h
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ARViewController.h"

@interface ARAlertController : NSObject

@property (nonatomic, weak) ARViewController *viewController;

- (void)showUnsupportedAlert;
- (void)showAddARNodeAlert;
- (void)showOverlyText:(NSString *)text withDuration:(int)duration;
- (void)showPermissionAlertWithDescription:(NSString *)accessDescription;

@end
