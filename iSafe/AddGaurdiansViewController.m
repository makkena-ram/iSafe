//
//  AddGaurdiansViewController.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/8/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "AddGaurdiansViewController.h"
#import "NewGaurdianViewController.h"

@interface AddGaurdiansViewController ()
@property (nonatomic,strong) Contact *contact;
@end

@implementation AddGaurdiansViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDelegate:self];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.contact=[[Contact alloc] initWithName:nil phoneNumber:nil emailId:nil];
    aContact=[self.contact getContacts];
    
    [self.tableView reloadData];
    
}


- (IBAction)addFromContacts:(id)sender {
    
}

- (IBAction)addNewContact:(id)sender {
    
}


-(void)add:(id)sender
{
    [aContact addObject:sender];
    [self.tableView reloadData];
    
}

-(void)cancel
{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aContact.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"AddGaurdians";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Contact *contact=[aContact objectAtIndex:indexPath.row];
    cell.textLabel.text=[contact name];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[contact phoneNumber]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [aContact removeObjectAtIndex:indexPath.row];
    sqlite3 *database;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    sqlite3_open([[appDelegate getDBPath] UTF8String], &database);

    
    
            NSString *sql_str=[NSString stringWithFormat:@"DELETE FROM contacts where id=%d",indexPath.row];
            const char *sql = [sql_str UTF8String];
            sqlite3_stmt *deleteStmt;
            sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL);
                    if(sqlite3_step(deleteStmt) != SQLITE_DONE )
                    {
                        NSLog( @"Error: %s", sqlite3_errmsg(database) );
                    }
                    else
                    {
                        //  NSLog( @"row id = %d", (sqlite3_last_insert_rowid(database)+1));
                        NSLog(@"No Error");
                    }
                sqlite3_finalize(deleteStmt);
    
            sqlite3_close(database);
    
    [tableView reloadData];
}
@end
