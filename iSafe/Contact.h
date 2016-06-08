//
//  Contact.h
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/25/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property NSString *name;
@property NSString *phoneNumber;
@property NSString *emailId;
-(id)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber emailId:(NSString *)emailId;
-(NSMutableArray *)getContacts;
@end
