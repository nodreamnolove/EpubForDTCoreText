//
//  EpubMainViewController.m
//  EpubForDTCoreText
//
//  Created by mac on 16/1/8.
//  Copyright © 2016年 epub. All rights reserved.
//

#import "EpubMainViewController.h"
#import "TouchXML.h"
#import "GetXMLObject.h"

@interface EpubMainViewController ()

@end

@implementation EpubMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self getXMLContent];
}

#pragma mark 解析 xml
-(void)getXMLContent
{
    NSDirectoryEnumerator *dirEnu = [[NSFileManager defaultManager] enumeratorAtPath:self.filePath];
    NSString *fileName;
    while (fileName = [dirEnu nextObject]) {
        if ([[fileName lastPathComponent] isEqualToString:@"content.opf"]) {
            break;
        }
    }
    NSString *opfPath = [self.filePath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:opfPath]) {
        
        NSError *err;
//        CXMLDocument *getXML = [[CXMLDocument alloc]initWithContentsOfURL:[NSURL fileURLWithPath:opfPath] options:0 error:&err];
       
        GetXMLObject *xmlFile = [[GetXMLObject alloc]initWithPath:opfPath];
     
//        NSLog(@"%@",getXML);
        
    }
}

@end
