//
//  AddGaurdiansViewController.h
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/8/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "AddOrCancel.h"
#import "GlobalVariables.h"


@interface NewGaurdianViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *gaurdianName;
@property (weak, nonatomic) IBOutlet UITextField *phNumber;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property id<AddOrCancel> delegate;

@property Contact *aContact;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
