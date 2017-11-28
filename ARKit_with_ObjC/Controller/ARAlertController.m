//
//  ARAlertController.m
//  ARKit_with_ObjC
//
//  Created by Raju on 11/7/17.
//  Copyright © 2017 rajubd49. All rights reserved.
//

#import "ARAlertController.h"

@interface ARAlertController ()

@end

@implementation ARAlertController

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
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

- (void)showAddARNodeAlert {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Select AR Object"
                                 message:nil
                                 preferredStyle: (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    UIAlertAction *cupAction = [UIAlertAction actionWithTitle:@"Cup"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          self.viewController.sceneName = @"art.scnassets/cup.dae";
                                                      }];
    UIAlertAction *vaseAction = [UIAlertAction actionWithTitle:@"Vase"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           self.viewController.sceneName = @"art.scnassets/vase.dae";
                                                       }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    [alert addAction:cupAction];
    [alert addAction:vaseAction];
    [alert addAction:cancelAction];
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

- (void)showOverlyText:(NSString *)text withDuration:(int)duration {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [self.viewController presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)showPermissionAlertWithDescription:(NSString *)accessDescription {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:accessDescription message:@"To give permission tap on 'Change Settings' button." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}  completionHandler:nil];
    }];
    [alertController addAction:settingsAction];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
