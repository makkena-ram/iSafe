//
//  FirstAidTVC.m
//  iSafe
//
//  Created by Ramakrishna Makkena on 12/5/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import "FirstAidTVC.h"

@interface FirstAidTVC ()
{
    NSDictionary *dic;
    NSArray *arr;
}

@end
@implementation FirstAidTVC

-(void)viewDidLoad
{
    NSError *error;
    NSURL *link=[NSURL URLWithString:@"http://www.json-generator.com/api/json/get/cnsFFxiSle?indent=2"];
    NSURLRequest *request=[NSURLRequest requestWithURL:link];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    arr=[dic valueForKey:@"First aid for a heart attack"];
    
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstAid"];
    if(!cell)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"firstAid" forIndexPath:indexPath];
    }
    // Configure the cell...
    cell.textLabel.text=[arr objectAtIndex:indexPath.row];
    return cell;

}

@end
