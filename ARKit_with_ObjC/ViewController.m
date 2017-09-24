//
//  ViewController.m
//  ARKit_with_ObjC
//
//  Created by Raju on 8/30/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
    
@implementation ViewController

#pragma mark - UIViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupScene];
    [self addGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (ARWorldTrackingConfiguration.isSupported) {
        [self startSession];
        self.sceneName = @"art.scnassets/cup.dae";
    } else {
        [self showUnsupportedAlert];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Add Gesture Recognizer

- (void)addGestureRecognizer {
    
    // Tap Gesture
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAddARSceneNodeFrom:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.sceneView addGestureRecognizer:tapGestureRecognizer];
    
    // Long Press Gesture
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleRemoveARSceneNodeFrom:)];
    longPressGestureRecognizer.minimumPressDuration = 0.5;
    [self.sceneView addGestureRecognizer:longPressGestureRecognizer];
    
    // Pan Press Gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMoveARSceneNodeFrom:)];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [panGestureRecognizer setMinimumNumberOfTouches:1];
    [self.sceneView addGestureRecognizer:panGestureRecognizer];
    
    // Pinch Press Gesture
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleScaleARSceneNodeFrom:)];
    [self.sceneView addGestureRecognizer:pinchGestureRecognizer];
}

#pragma mark - Handle Gesture Recognizer

- (void)handleAddARSceneNodeFrom: (UITapGestureRecognizer *)tapGestureRecognizer {
    
    CGPoint tapPoint = [tapGestureRecognizer locationInView:self.sceneView];
    NSArray<ARHitTestResult *> *result = [self.sceneView hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    
    if (result.count == 0) {
        return;
    }
    
    ARHitTestResult * hitResult = [result firstObject];
    [self insertGeometry:hitResult];
}

- (void)handleRemoveARSceneNodeFrom: (UILongPressGestureRecognizer *)longPressGestureRecognizer {
    
    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint holdPoint = [longPressGestureRecognizer locationInView:self.sceneView];
    NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:holdPoint
                                                          options:@{SCNHitTestBoundingBoxOnlyKey: @YES, SCNHitTestFirstFoundOnlyKey: @YES}];
    if (result.count == 0) {
        return;
    }
    
    SCNHitTestResult * hitResult = [result firstObject];
    if (![hitResult.node.parentNode isKindOfClass:[Plane class]]) {
        [[hitResult.node parentNode] removeFromParentNode];
    }
}

-(void)handleMoveARSceneNodeFrom:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint tapPoint = [panGestureRecognizer locationInView:self.sceneView];
        NSArray <SCNHitTestResult *> *result = [self.sceneView hitTest:tapPoint options:nil];
        
        if ([result count] == 0) {
            return;
        }
        SCNHitTestResult *hitResult = [result firstObject];
        if (![hitResult.node.parentNode isKindOfClass:[Plane class]]) {
            self.selectedNode = [[hitResult node] parentNode];
        }
    }
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (self.selectedNode) {
            CGPoint tapPoint = [panGestureRecognizer locationInView:self.sceneView];
            NSArray <ARHitTestResult *> *hitResults = [self.sceneView hitTest:tapPoint types:ARHitTestResultTypeFeaturePoint];
            ARHitTestResult *result = [hitResults lastObject];
            
            SCNMatrix4 matrix = SCNMatrix4FromMat4(result.worldTransform);
            SCNVector3 vector = SCNVector3Make(matrix.m41, matrix.m42, matrix.m43);
            [self.selectedNode setPosition:vector];
        }
    }
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.selectedNode = nil;
    }
}

- (void)handleScaleARSceneNodeFrom: (UIPinchGestureRecognizer *)pinchGestureRecognizer {
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint tapPoint = [pinchGestureRecognizer locationOfTouch:1 inView:self.sceneView];
        NSArray <SCNHitTestResult *> *result = [self.sceneView hitTest:tapPoint options:nil];
        if ([result count] == 0) {
            tapPoint = [pinchGestureRecognizer locationOfTouch:0 inView:self.sceneView];
            result = [self.sceneView hitTest:tapPoint options:nil];
            if ([result count] == 0) {
                return;
            }
        }
        
        SCNHitTestResult *hitResult = [result firstObject];
        self.selectedNode = [[hitResult node] parentNode];
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (self.selectedNode) {
            CGFloat pinchScaleX = pinchGestureRecognizer.scale * self.selectedNode.scale.x;
            CGFloat pinchScaleY = pinchGestureRecognizer.scale * self.selectedNode.scale.y;
            CGFloat pinchScaleZ = pinchGestureRecognizer.scale * self.selectedNode.scale.z;
            [self.selectedNode setScale:SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ)];
        }
        pinchGestureRecognizer.scale = 1;
    }
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.selectedNode = nil;
    }
}

#pragma mark - Additional Utils

- (void)insertGeometry:(ARHitTestResult *)hitResult {
    
    SCNScene *scene = [SCNScene sceneNamed:self.sceneName];
    SCNNode *node = [scene.rootNode clone];
    float insertionYOffset = 0.01;
    node.position = SCNVector3Make(
                                   hitResult.worldTransform.columns[3].x,
                                   hitResult.worldTransform.columns[3].y + insertionYOffset,
                                   hitResult.worldTransform.columns[3].z
                                   );
    [self.sceneNode addObject:node];
    [self.sceneView.scene.rootNode addChildNode:node];
}

- (void)showUnsupportedAlert {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Unsupported platform"
                                 message:@"This app requires world tracking. World tracking is only available on iOS 11 with A9 processor devices or newer."
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                     }];
    [alert addAction:noAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAddARNodeAlert {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Select AR Object"
                                 message:nil
                                 preferredStyle: (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    UIAlertAction *cupAction = [UIAlertAction actionWithTitle:@"Cup"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          self.sceneName = @"art.scnassets/cup.dae";
                                                      }];
    UIAlertAction *vaseAction = [UIAlertAction actionWithTitle:@"Vase"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           self.sceneName = @"art.scnassets/vase.dae";
                                                       }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addAction:cupAction];
    [alert addAction:vaseAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Button Actions

- (IBAction)addNewARNodeAction:(id)sender {
    [self showAddARNodeAlert];
}

- (IBAction)refreshSessionAction:(id)sender {
    [self refreshSession];
}

#pragma mark - Configure SCNScene

- (void)setupSceneView {
    self.sceneView.delegate = self;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.showsStatistics = YES;
}

- (void)setupScene {
    
    self.sceneView.delegate = self;
    self.planes = [NSMutableDictionary new];
    self.sceneNode = [NSMutableArray new];
    self.sceneView.showsStatistics = YES;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.debugOptions =
    ARSCNDebugOptionShowFeaturePoints;
    
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
}

#pragma mark - Configure ARSession

- (void)startSession {
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)refreshSession {
    
    for (NSUUID *planeId in self.planes) {
        [self.planes[planeId] remove];
    }
    for (SCNNode *cube in self.sceneNode) {
        [cube removeFromParentNode];
    }
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
}

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    Plane *plane = [[Plane alloc] initWithAnchor: (ARPlaneAnchor *)anchor];
    [self.planes setObject:plane forKey:anchor.identifier];
    [node addChildNode:plane];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    Plane *plane = [self.planes objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }
    [plane update:(ARPlaneAnchor *)anchor];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    [self.planes removeObjectForKey:anchor.identifier];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

#pragma mark - ARSessionObserver

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
}

- (void)sessionWasInterrupted:(ARSession *)session {
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    [self refreshSession];
}

@end
