//
//  recordData.m
//  Closeur_withAPI
//
//  Created by Trúc Phương >_< on 02/03/2018.
//  Copyright © 2018 iDev Bao. All rights reserved.
//

#import "recordData.h"

@implementation recordData
+ (instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static recordData *rc = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        rc = [[self alloc] init];
        NSLog(@"ss-----------------------------------------");
        
    });
    
    // returns the same object each time
    return rc;
}

@end
