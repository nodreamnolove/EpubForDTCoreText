//
//  DownLoadSession.h
//  EpubForDTCoreText
//
//  Created by hmh on 16/1/13.
//  Copyright © 2016年 epub. All rights reserved.
//
//封装 NSURLSession下载操作
#import <Foundation/Foundation.h>


typedef void (^downloadProgressBlock)(NSProgress * _Nullable downPro);//下载进度条
typedef NSURL* _Nullable (^destionPathBlock)(NSURL * _Nullable targetPath ,NSURLResponse * _Nullable response);//下载路径
typedef void  (^completHandlerBlock)(NSURLResponse * _Nonnull response , NSURL * _Nullable filepath ,NSError * _Nullable error);//下载结束



@protocol DownLoadSessioDelegate <NSObject>
@optional
-(void)startDownLoadSession;//开始
-(void)endDownLoadSeesion;//结束
-(void)pauseDownLoadSession;//暂停
-(void)failureDownLoadSession;//下载失败

@end




@interface DownLoadSession : NSObject<NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>



//创建对象
- (instancetype _Nonnull)initWithSessionConfiguration:(NSURLSessionConfiguration * _Nullable)configuration;

-(NSURLSessionDownloadTask * _Nonnull)downloadTaskResquest:(NSURLRequest * _Nonnull)request;

-(void)startDown;

//创建下载任务
//- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request  progress: downloadProgressBlock  destination: destionPathBlock         completionHandler: completHandlerBlock;



@end
