//
//  Contact.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/25/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "Contact.h"
#import "sqlite3.h"
#import "AppDelegate.h"
#import "GlobalVariables.h"


@implementation Contact

-(id)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber emailId:(NSString *)emailId
{
    self=[super init];
    if(self)
    {
        _name=name;
        _phoneNumber=phoneNumber;
        _emailId=emailId;
    }
    return self;
}
-(NSMutableArray *)getContacts
{
    sqlite3 *database;
    Contact *contact;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    sqlite3_open([[appDelegate getDBPath] UTF8String], &database);
    aContact=[[NSMutableArray alloc] init];
    NSString* mText1 = [[NSString alloc] initWithFormat:  @"SELECT NAME, NUMBER, EMAIL FROM CONTACTS"];
    sqlite3_stmt *statement;
    
    if ( sqlite3_prepare_v2(database, [mText1 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW)	{
            
            contact = [[Contact alloc] initWithName:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)] phoneNumber:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] emailId:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
            [aContact addObject:contact];
            
        }
    }
    else{
        //error
        NSLog(@"Failed to open database. Error: %s",sqlite3_errmsg(database));
    }
    
    sqlite3_reset(statement);
    sqlite3_finalize(statement);
    statement = nil;
    sqlite3_close(database);
    return  aContact;

}

@end
