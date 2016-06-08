//
//  ViewController.h
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/8/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate>

- (IBAction)addGaurdians:(id)sender;
- (IBAction)sOS:(id)sender;

- (IBAction)fakeCall:(id)sender;
- (IBAction)videoCall:(id)sender;

- (IBAction)firstAid:(id)sender;

- (IBAction)instructions:(id)sender;

@end

