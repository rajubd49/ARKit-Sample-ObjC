//
//  ViewController.h
//  ARKit_with_ObjC
//
//  Created by Raju on 8/30/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
#import "Plane.h"

@interface ViewController : UIViewController <ARSCNViewDelegate>

@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic, strong) SCNNode *selectedNode;
@property (nonatomic, retain) NSMutableDictionary<NSUUID *, Plane *> *planes;
@property (nonatomic, retain) NSMutableArray<SCNNode *> *sceneNode;
@property (nonatomic, copy) NSString *sceneName;

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

- (IBAction)addNewARNodeAction:(id)sender;
- (IBAction)refreshSessionAction:(id)sender;

@end
