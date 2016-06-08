//
//  AddGaurdiansViewController.h
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/8/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Contact.h"
#import "AddOrCancel.h"
#import "GlobalVariables.h"
#import "AppDelegate.h"

@import AddressBook;


@interface AddGaurdiansViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AddOrCancel>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addFromContacts:(id)sender;
- (IBAction)addNewContact:(id)sender;


@end
