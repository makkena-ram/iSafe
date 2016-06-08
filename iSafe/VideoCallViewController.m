//
//  VideoCallViewController.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/30/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "VideoCallViewController.h"

@implementation VideoCallViewController

-(void)viewDidLoad
{
    
}

-(IBAction)captureImage:(id)sender
{
    
    UIImagePickerController *videoScreen = [[UIImagePickerController alloc] init];
    videoScreen.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose movie capture
    videoScreen.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    
    videoScreen.allowsEditing = NO;
    videoScreen.delegate = self;
    
    [self presentViewController:videoScreen animated: YES completion:NO];

    
//    actionSheet=[[UIActionSheet alloc]initWithTitle:@"UploadImage" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Library Image",@"Camera Image", nil];
//    [actionSheet showInView:self.view];
    
}

- (IBAction)playVideo:(UIButton *)sender {
    
    UIImagePickerController *mediaLibrary = [[UIImagePickerController alloc] init];
    mediaLibrary.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaLibrary.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for,
    // trimming movies. To instead show the controls, use YES.
    mediaLibrary.allowsEditing = NO;
    //mediaUI.delegate = delegate;
    // 3 - Display image picker
    [self presentViewController:mediaLibrary animated:YES completion:NO];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:NO completion:NO];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = [NSString stringWithFormat:@"%@", [[info objectForKey:UIImagePickerControllerMediaURL] path]];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self, nil, nil);
        }
    }
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            imagePicker=[[UIImagePickerController alloc]init];
            imagePicker.delegate=self;
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self dismissViewControllerAnimated:YES completion:nil];
            [self presentViewController:imagePicker animated:YES completion:NULL];
            
        }
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.delegate=self;
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error in Loading Camera" message:@"Device does not support the camera" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
    }
}




/*

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    [captureImage setImage:image];
    [imagePicker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
*/
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
