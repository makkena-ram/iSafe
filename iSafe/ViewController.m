
//
//  ViewController.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/8/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "ViewController.h"
#import "GlobalVariables.h"
#import "AppDelegate.h"
#import "sqlite3.h"
#import "Contact.h"

@interface ViewController ()

@property CLLocationManager *coreLocation;
@property CLLocation *location;
@property (strong,nonatomic) Contact *contact;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreLocation=[[CLLocationManager alloc]init];
    self.coreLocation.delegate = self;
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                               message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
    }
    
    [self.coreLocation requestAlwaysAuthorization];
    [self.coreLocation requestWhenInUseAuthorization];
    self.coreLocation.distanceFilter = kCLDistanceFilterNone;
    self.coreLocation.desiredAccuracy = kCLLocationAccuracyBest;
    [self.coreLocation startUpdatingLocation];
    self.location=[self.coreLocation location];
    //[self locationManager:self.coreLocation didUpdateLocations:(NSArray *)]
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@",[locations lastObject]);
    self.location =[locations lastObject];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addGaurdians:(id)sender {
    
}

- (IBAction)sOS:(id)sender
{
    MFMessageComposeViewController *controller =[[MFMessageComposeViewController alloc] init];
    
   // NSString *locCoordinates=[NSString stringWithFormat:@"%0.8f,%0.8f",self.coreLocation.location.coordinate.latitude,self.location.coordinate.longitude];
    NSString* addr = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%0.8f,%0.8f",self.location.coordinate.latitude,self.location.coordinate.longitude];
    NSURL *url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.contact=[[Contact alloc] initWithName:nil phoneNumber:nil emailId:nil];
    aContact=[self.contact getContacts];
    //[[UIApplication sharedApplication] openURL:url];
    if([MFMessageComposeViewController canSendText])
    {
        NSString *str= [NSString stringWithFormat:@"Attention:I triggered my safety alarm and need assistance.Anew message will follow this message determining my location\nSOS! I have triggered my safety alarm and need help now.My location is: \n%@", [url absoluteString]];
        controller.body = str;
        controller.recipients = [NSArray arrayWithObjects:[[aContact objectAtIndex:0] valueForKey:@"phoneNumber"], nil];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        //[self presentModalViewController:controller animated:YES];
    }

    
}


- (void)messageComposeViewController:
(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Failed");
            break;
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    
}


- (IBAction)fakeCall:(id)sender {
//    NSURL *phoneURL=[[NSURL alloc] initWithString:@"telprompt://619-618-8321"];
//    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (IBAction)videoCall:(id)sender {
}

- (IBAction)firstAid:(id)sender {
}

- (IBAction)instructions:(id)sender {
}
@end
