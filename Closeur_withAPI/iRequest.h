//
//  iRequest.h
//  Closeur_withAPI
//
//  Created by Trúc Phương >_< on 02/03/2018.
//  Copyright © 2018 iDev Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iRequest : NSObject


+(void)requestPath:(NSString *)path
      onCompletion:(void(^)(NSData*,NSError*))complete;
@end
