//
//  recordData.h
//  Closeur_withAPI
//
//  Created by Trúc Phương >_< on 02/03/2018.
//  Copyright © 2018 iDev Bao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface recordData : NSObject
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) UIImage *appImg;
@property (nonatomic, strong) NSString *imageURL;

@property (strong, nonatomic) NSString *abc;
+ (instancetype)sharedInstance;
@end
