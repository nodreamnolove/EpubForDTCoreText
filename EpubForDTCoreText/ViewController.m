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
#import "downLoadVC.h"
#import "AFNdownLoadVC.h"
//@"shengcai123" 密码
//http://www.100eshu.com/uploads/ebook/b2f9a6fe1b1a4a159dd39fe38b09ac24/mobile/b2f9a6fe1b1a4a159dd39fe38b09ac24.zip
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
    UIBarButtonItem *rightBarBut1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(netClick)];
    UIBarButtonItem *rightBarBut = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goEpub)];
    self.navigationItem.rightBarButtonItems = @[rightBarBut1,rightBarBut];
    
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

-(void)netClick
{
    downLoadVC *DLVC = [downLoadVC new];
    NSLog(@"%s",__FUNCTION__);
    AFNdownLoadVC *afnVC = [AFNdownLoadVC new];
    [self.navigationController pushViewController:DLVC animated:YES];
}


@end
