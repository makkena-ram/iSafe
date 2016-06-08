//
//  ContactsTableViewController.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 12/4/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "ContactsTableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Contact.h"
#import "GlobalVariables.h"
#import "AddGaurdiansViewController.h"

@interface ContactsTableViewController ()
{
    NSMutableArray *contatcs;
    NSMutableArray *dummyArray;
}

@end
@implementation ContactsTableViewController

-(void)viewDidLoad
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // We are on iOS 6
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(semaphore);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    else { // We are on iOS 5 or Older
        accessGranted = YES;
        [self getContactsWithAddressBook:addressBook];
    }
    
    if (accessGranted) {
        [self getContactsWithAddressBook:addressBook];
    }

    
}


- (void)getContactsWithAddressBook:(ABAddressBookRef )addressBook {
    
    contatcs = [[NSMutableArray alloc] init];
    dummyArray =[[NSMutableArray alloc]init];
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        
        [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
                break ;
            }
            
        }
        [contatcs addObject:dOfPerson];
        
    }
    
    NSLog(@"contatcs : %@", contatcs);
    for(int i=0;i<contatcs.count;i++)
    {
        Contact *contact=[[Contact alloc]initWithName:[contatcs[i] valueForKey:@"name"] phoneNumber:[contatcs[i] valueForKey:@"Phone"] emailId:[contatcs[i] valueForKey:@"email"]];
       
        [dummyArray addObject:contact];

    }
    
    NSLog(@"dummyArray : %@", dummyArray);
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dummyArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"Contacts";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Contact *contact=[dummyArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[contact name];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[contact phoneNumber]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Contact *contact=[dummyArray objectAtIndex:indexPath.row];
    sqlite3 *database;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSString *mSQLQuery = [NSString stringWithFormat:@"INSERT INTO CONTACTS (NAME,NUMBER,EMAIL) values('%@','%@','%@')",contact.name,contact.phoneNumber,contact.emailId];
    sqlite3_open([[appDelegate getDBPath] UTF8String], &database);
    sqlite3_exec(database, [mSQLQuery  UTF8String],NULL, NULL, NULL);
    sqlite3_close(database);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

