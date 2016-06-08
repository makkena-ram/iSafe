//
//  VideoCallViewController.h
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/30/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface VideoCallViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
    UIActionSheet *actionSheet;
    IBOutlet UIImageView *captureImage;
}


-(IBAction)captureImage:(id)sender;
- (IBAction)playVideo:(UIButton *)sender;



@end
