//
//  ARViewController.h
//  ARKit_with_ObjC
//
//  Created by Raju on 8/30/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>


@interface ARViewController : UIViewController

@property (nonatomic, retain) NSMutableArray<SCNNode *> *sceneNode;
@property (nonatomic, copy) NSString *sceneName;
@property (nonatomic, assign) CGFloat currentYAngle;

@property (strong, nonatomic) IBOutlet ARSCNView *sceneView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *addNodeButton;
@property (weak, nonatomic) IBOutlet UIButton *snapshotButton;

- (IBAction)refreshSessionAction:(id)sender;
- (IBAction)removeAction:(id)sender;
- (IBAction)addNodeAction:(id)sender;
- (IBAction)snapshotAction:(id)sender;

- (void)refreshSession;

@end
