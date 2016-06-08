//
//  AddGaurdiansViewController.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/8/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "NewGaurdianViewController.h"
#import "sqlite3.h"
#import "AppDelegate.h"

@interface NewGaurdianViewController ()
{
    sqlite3 *contactDB;
    NSString *dbPathString;

}

@end
@implementation NewGaurdianViewController


-(void)viewDidLoad
{
//    [self createOrOpenDB];
}
- (IBAction)cancel:(id)sender {
    [self.delegate cancel];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)createOrOpenDB
{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath=[path objectAtIndex:0];
    dbPathString =[docPath stringByAppendingPathComponent:@"contacts.db"];
    
    char *error;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:dbPathString])
    {
        const char* dbPath=[dbPathString UTF8String];
        
        //create table here
        if(sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
        {
            const char* sql_stmt="CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT,PHONENUMBER NUMBER,EMAIL TEXT";
            sqlite3_exec(contactDB, sql_stmt, NULL,NULL, &error);
            sqlite3_close(contactDB);
        }
    }
}




- (IBAction)done:(id)sender {
    
    NSString *name=self.gaurdianName.text;
    NSString *phoneNumber=self.phNumber.text;
    NSString *email=self.email.text;
    self.aContact=[[Contact alloc]initWithName:name phoneNumber:phoneNumber emailId:email];
    
    sqlite3 *database;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSString *mSQLQuery = [NSString stringWithFormat:@"INSERT INTO CONTACTS (NAME,NUMBER,EMAIL) values('%@','%@','%@')",self.aContact.name,self.aContact.phoneNumber,self.aContact.emailId];
    sqlite3_open([[appDelegate getDBPath] UTF8String], &database);
    
    
    if (sqlite3_exec(database, [mSQLQuery  UTF8String],NULL, NULL, NULL) == SQLITE_OK) {
        NSLog(@"Inserted");
    }
    else
        NSLog(@"Failed to open database. Error: %s",sqlite3_errmsg(database));
    
    sqlite3_close(database);
    
//    char *error;
//    if(sqlite3_open([dbPathString UTF8String], &contactDB)==SQLITE_OK)
//    {
//        NSString *insertStmt=[NSString stringWithFormat:@"INSERT INTO CONTACTS (NAME,NUMBER,EMAIL) values('%@','%@','%@')",self.aContact.name,self.aContact.phoneNumber,self.aContact.emailId];
//        const char *insert_stmt=[insertStmt UTF8String];
//        
//        if(sqlite3_exec(contactDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK)
//        {
//            [self.del add:self.aContact];
//            NSLog(@"Contact added");
//            
//        }
//        sqlite3_close(contactDB);
//    }
    
    [aContact addObject:self.aContact];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
