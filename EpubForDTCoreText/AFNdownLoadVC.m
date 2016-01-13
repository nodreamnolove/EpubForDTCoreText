//
//  AFNdownLoadVC.m
//  EpubForDTCoreText
//
//  Created by 段瑞权 on 16/1/13.
//  Copyright © 2016年 epub. All rights reserved.
//

#import "AFNdownLoadVC.h"
#import "AFNetworking.h"
#import "DownLoadSession.h"
@interface AFNdownLoadVC ()
@property (nonatomic,strong) NSURLSessionDownloadTask * downtask;
@end

@implementation AFNdownLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [startBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:startBtn];
    startBtn.center = self.view.center;
    [startBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)BtnClick
{
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"AFNTest"];
//    AFURLSessionManager *downsess = [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
//    
//    NSURLSessionDownloadTask *downTask = [downsess downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        
//        
//        
//        return [NSURL URLWithString:@""];
//    }
//    completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        
//    }];
//    
//    [downTask resume];
    
    DownLoadSession *downsession = [[DownLoadSession alloc]initWithSessionConfiguration:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.100eshu.com/uploads/ebook/b2f9a6fe1b1a4a159dd39fe38b09ac24/mobile/b2f9a6fe1b1a4a159dd39fe38b09ac24.zip"]];
    
   [downsession downloadTaskResquest:request];
    
    [downsession startDown];
    
}


@end
