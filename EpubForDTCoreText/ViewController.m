//
//  ViewController.m
//  EpubForDTCoreText
//
//  Created by 段瑞权 on 15/12/29.
//  Copyright © 2015年 epub. All rights reserved.
//

#import "ViewController.h"
#import "EpubMainViewController.h"
#import "ZipArchive.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIButton *goEpubBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    goEpubBtn.center = self.view.center;
//    [goEpubBtn setTitle:@"开始阅读" forState:UIControlStateNormal];
//    [goEpubBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [goEpubBtn addTarget:self action:@selector(goEpub) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:goEpubBtn];
//    self.view.backgroundColor = [UIColor redColor];
    UIBarButtonItem *rightBarBut = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goEpub)];
    self.navigationItem.rightBarButtonItem = rightBarBut;
    
}
-(void)goEpub
{
 
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"iOS应用逆向工程"];
    NSString *sourceFile = [[NSBundle mainBundle]pathForResource:@"iOS应用逆向工程" ofType:@"epub"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:sourceFile]) {
        ZipArchive *zip = [[ZipArchive alloc]init];
        if([zip UnzipOpenFile:sourceFile]){
        
            [zip UnzipFileTo:filepath overWrite:NO];
        }
        [zip UnzipCloseFile];
    }
    BOOL isDirectory;
    if ([[NSFileManager defaultManager]fileExistsAtPath:filepath isDirectory:&isDirectory]) {
        EpubMainViewController *epubVC = [[EpubMainViewController alloc]init];
        epubVC.filePath = filepath;
        [self.navigationController pushViewController:epubVC animated:YES];
    }
    
}


@end
