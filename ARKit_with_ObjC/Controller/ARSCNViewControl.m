//
//  ARSCNViewControl.m
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import "ARSCNViewControl.h"

@interface ARSCNViewControl ()

@end

@implementation ARSCNViewControl

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.viewController.addNodeButton.hidden = NO;
        self.viewController.snapshotButton.hidden = NO;
        [self.alertController showOverlyText:@"SURFACE DETECTED, TAP TO PLACE AN OBJECT" withDuration:2];
    });
    
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

#pragma mark - ARSessionObserver

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    [self.alertController showOverlyText:@"PLEASE TRY RESETTING THE SESSION" withDuration:1];
}

- (void)sessionWasInterrupted:(ARSession *)session {
    [self.alertController showOverlyText:@"SESSION INTERRUPTED" withDuration:1];
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    [self.viewController refreshSession];
}

@end
