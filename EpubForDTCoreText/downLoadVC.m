//
//  downLoadVC.m
//  EpubForDTCoreText
//
//  Created by 段瑞权 on 16/1/12.
//  Copyright © 2016年 epub. All rights reserved.
//

#import "downLoadVC.h"
static NSString *session_id = @"test";
@interface downLoadVC ()<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>
{
    NSURLSession *downsess;
    NSURLSessionDownloadTask *downTask;
    NSData *partDownload;
}


@end

@implementation downLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *startBtn =[[ UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    startBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:startBtn];
    startBtn.center = self.view.center ;
    [startBtn addTarget:self action:@selector(startDownLoad) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)startDownLoad
{
    
        
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"test"];
//        
//        downsess = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        NSString *str1 = @"http://www.100eshu.com/uploads/ebook/b2f9a6fe1b1a4a159dd39fe38b09ac24/mobile/b2f9a6fe1b1a4a159dd39fe38b09ac24.zip";
        NSString *str2 = @"http://fujian.86516.com/forum/201209/28/16042484m9y9izwbrwuixj.jpg";
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str1] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
        if(!downTask){
            downTask = [self.backgroundSession downloadTaskWithRequest:request];
            [downTask resume];
        }
        
    
    
}

- (NSURLSession *)backgroundSession
{
    static NSURLSession *backgroundSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.shinobicontrolsn"];
        config.timeoutIntervalForRequest = 23;
        backgroundSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    });
    return backgroundSession;
}


-(void)downfile
{
    
    NSURL *url = [NSURL URLWithString:@"http://www.100eshu.com/uploads/ebook/b2f9a6fe1b1a4a159dd39fe38b09ac24/mobile/b2f9a6fe1b1a4a159dd39fe38b09ac24.zip"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration backgroundSessionConfiguration:@"test"];
    
    configure.discretionary = YES;
    configure.allowsCellularAccess = YES;
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:nil];
       
    [session downloadTaskWithRequest:request];
}
#pragma mark NSURLSessionDelegate
//session 发生一个系统错误
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
    NSLog(@"%s",__func__);
}

/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
//该代理用于连接阶段的身份验证
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"%s",__func__);
}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
//进入后台操作
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0)
{
    NSLog(@"%s",__func__);
}

#pragma mark NSURLSessionTaskDelegate
//http重定向
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler
{
    NSLog(@"%s",__func__);
}

/* The task has received a request specific authentication challenge.
 * If this delegate is not implemented, the session specific authentication challenge
 * will *NOT* be called and the behavior will be the same as using the default handling
 * disposition.
 */
//接收特定的授权
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"%s",__func__);
}

/* Sent if a task requires a new, unopened body stream.  This may be
 * necessary when authentication has failed for any request that
 * involves a body stream.
 */
//新的流
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * __nullable bodyStream))completionHandler
{
    NSLog(@"%s",__func__);
}

/* Sent periodically to notify the delegate of upload progress.  This
 * information is also available as properties of the task.
 */
//上传进度
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%s",__func__);
}

/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 */
//发生错误时
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    NSLog(@"%s   -- %@",__func__,error);
}

#pragma mark NSURLSessionDownloadDelegate
//必须实现   下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"%s",__func__);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLs[0];
    
    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
    NSError *error;
    
    // Make sure we overwrite anything that's already there
    [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    if (success) {
        NSLog(@"图片转移成功");
    }
}


/* Sent periodically to notify the delegate of download progress. */
//发送 周期通知下载进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double curpro = totalBytesWritten/(double)totalBytesExpectedToWrite;
    NSLog(@"当前下载了：%f%%",curpro*100);
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
//
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__func__);
}

@end
