//
//  HOMEViewController.m
//  Closeur_withAPI
//
//  Created by Trúc Phương >_< on 02/03/2018.
//  Copyright © 2018 iDev Bao. All rights reserved.
//

#import "HOMEViewController.h"
#import "nsOperation.h"
#import "recordData.h"
#import "iRequest.h"
@interface HOMEViewController ()
@property (nonatomic,strong) nsOperation* parse;
@property (nonatomic,weak)NSArray * arr;
@property (nonatomic,strong)NSOperationQueue* queue;
@end

@implementation HOMEViewController
UITableView *tableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [recordData sharedInstance].abc = @"sss";
    NSLog(@"%@",[recordData sharedInstance].abc);
    
    
    _queue = [NSOperationQueue new];
    tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource =self;
    
    
    [iRequest requestPath:@"https://rss.itunes.apple.com/api/v1/vn/apple-music/hot-tracks/all/10/non-explicit.atom"
             onCompletion:^(NSData *data, NSError *error) { /*tu block lay giai tri no xu ly mang ra dung tra ve 1 block
                 // KI THUAT CALLBACK
                  if(onCompletion){
                                                             xu ly data xong nem ra block 
                    onCompletion(data,error);
                                                             
             }
                                                             */
                 NSLog(@"%@",data);
                 self.parse = [[nsOperation alloc] initWithData:data];
                 
                 // parse la NSOperation
                 self.parse.completionBlock =^(void){
                     if (self.parse.recordDataList != nil) {
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             _arr = _parse.recordDataList;     // ko khoi tao gan luon va
                             
                             [tableview reloadData];
                         });
                     }
                 };
                 [_queue  addOperation:_parse];
             }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int count = (int)_arr.count;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {// vung ton bo nho
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
    }
    // va kiem tra da ton tai chua
    cell.imageView.image = [UIImage imageNamed:@"12.png"];
    if (count  > 0) {
        
        recordData * save = (self.arr)[indexPath.row];
        cell.textLabel.text = save.appName;
        
        if (!save.appImg)
        {
            
            [iRequest requestPath:save.imageURL onCompletion:^(NSData *data, NSError *error) {
                
                
                save.appImg = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        cell.imageView.image = nil;
                    }if (data) {
                        cell.imageView.image = save.appImg;
//                         [tableview reloadData];
                    }
                    
                });
            }];
            
            
        }
        else
        {
            cell.imageView.image = save.appImg;
        }
    }
    
    
    
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (int)_arr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}


@end
