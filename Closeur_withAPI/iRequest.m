//
//  iRequest.m
//  Closeur_withAPI
//
//  Created by Trúc Phương >_< on 02/03/2018.
//  Copyright © 2018 iDev Bao. All rights reserved.
//

#import "iRequest.h"

@implementation iRequest

+(void)requestPath:(NSString *)path onCompletion:(void(^)(NSData*,NSError*))complete
{
    NSURLSession *session = [NSURLSession sharedSession]; // tao
    [[session dataTaskWithURL:[NSURL URLWithString:path] // trueyn vao dia chi
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                //completionHandler la 1 block : completionHandler dc truyen tham so tu viec phan tich thang url no nem Data vao bien data de lay ra xu dung
                
                if (complete) complete(data, error); // lay Data do lam gia tri cho block complete
            }] resume];
}@end
