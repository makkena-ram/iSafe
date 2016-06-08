//
//  AddOrCancel.h
//  iSafe
//
//  Created by Ramakrishna Makkena on 11/29/14.
//  Copyright (c) 2014 nwmissouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddOrCancel <NSObject>
@required
-(void)add:(id)sender;
-(void)cancel;
@end
