//
//  ARViewController.m
//  ARKit_with_ObjC
//
//  Created by Raju on 8/30/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import "ARViewController.h"
#import "ARAlertController.h"
#import "ARSCNViewControl.h"
#import "ARGestureControl.h"

@interface ARViewController ()

@property (nonatomic, strong) ARAlertController *alertController;
@property (nonatomic, strong) ARSCNViewControl *sceneControl;
@property (nonatomic, strong) ARGestureControl *gestureControl;

@end
    
@implementation ARViewController

#pragma mark - UIViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialGetter];
    [self setupScene];
    [self.gestureControl setupGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (ARWorldTrackingConfiguration.isSupported) {
        [self startSession];
        self.sceneName = @"art.scnassets/cup.dae";
    } else {
        [self.alertController showUnsupportedAlert];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters

-(void)initialGetter {
    
    if (!self.alertController) {
        self.alertController = [[ARAlertController alloc] init];
        self.alertController.viewController = self;
    }
    
    if (!self.sceneControl) {
        self.sceneControl = [[ARSCNViewControl alloc] init];
        self.sceneControl.viewController = self;
        self.sceneControl.alertController = self.alertController;
    }
    
    if (!self.gestureControl) {
        self.gestureControl = [[ARGestureControl alloc] init];
        self.gestureControl.viewController = self;
    }
}

#pragma mark - Configure SCNScene

- (void)setupSceneView {
    
    self.sceneView.delegate = self.sceneControl;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.showsStatistics = YES;
}

- (void)setupScene {
    
    self.sceneView.delegate = self.sceneControl;
    self.sceneNode = [NSMutableArray new];
    self.sceneView.showsStatistics = YES;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.debugOptions = SCNDebugOptionNone;
    
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
}

#pragma mark - Configure ARSession

- (void)startSession {
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration];
    
    [self checkMediaPermissionAndButtonState];
}


- (void)refreshSession {
    
    for (SCNNode *cube in self.sceneNode) {
        [cube removeFromParentNode];
    }
    
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];

    [self checkMediaPermissionAndButtonState];
}

#pragma mark - Media Premission Check

-(void)checkMediaPermissionAndButtonState {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined) {
            [self.alertController showOverlyText:@"STARTING A NEW SESSION, TRY MOVING LEFT OR RIGHT" withDuration:2];
        } else {
            NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSCameraUsageDescription"];
            [self.alertController showPermissionAlertWithDescription:accessDescription];
        }
        
        self.currentYAngle = 0.0;
        self.removeButton.hidden = YES;
        self.addNodeButton.hidden = YES;
        self.snapshotButton.hidden = YES;
    });
}

#pragma mark - Button Actions

- (IBAction)refreshSessionAction:(id)sender {
    [self refreshSession];
}

- (IBAction)addNodeAction:(id)sender {
    [self.alertController showAddARNodeAlert];
}

- (IBAction)removeAction:(id)sender {
    [self.gestureControl removeARObject:sender];
}

- (IBAction)snapshotAction:(id)sender {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            UIImage *image = [self.sceneView snapshot];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        } else {
            NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSPhotoLibraryUsageDescription"];
            [self.alertController showPermissionAlertWithDescription:accessDescription];
        }
    }];
}

#pragma mark - Write Image CompletionHandler

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo {
    if (error) {
        [self.alertController showOverlyText:@"Error saving snapshot." withDuration:1];
    } else {
        [self.alertController showOverlyText:@"Saved snapshot successfully." withDuration:1];
    }
}

@end
