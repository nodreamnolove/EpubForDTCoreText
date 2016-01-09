//
//  ViewController.m
//  EpubForDTCoreText
//
//  Created by 段瑞权 on 15/12/29.
//  Copyright © 2015年 epub. All rights reserved.
//

#import "ViewController.h"
#import "EpubMainViewController.h"
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
    EpubMainViewController *epubVC = [[EpubMainViewController alloc]init];
    [self.navigationController pushViewController:epubVC animated:YES];
}


@end
