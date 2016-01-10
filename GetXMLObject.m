//
//  GetXMLArray.m
//  EpubForDTCoreText
//
//  Created by 段瑞权 on 16/1/10.
//  Copyright © 2016年 epub. All rights reserved.
//

#import "GetXMLObject.h"
#import "TouchXML.h"
#import "gDataXMLNode.h"

@interface GetXMLObject()

@property (nonatomic,strong) NSArray * navPointArr;

@end

@implementation GetXMLObject


-(instancetype)init
{
    self = [super init];
    if (self.xmlFilePath.length>1) {
        return [self initWithPath:self.xmlFilePath];
    }
    return nil;
}

-(instancetype)initWithPath:(NSString *)xmlFilePath
{
    self = [super init];
    if (self) {
        self.xmlFilePath = xmlFilePath;
        if ([[NSFileManager defaultManager]fileExistsAtPath:xmlFilePath]) {
            NSData *xmlData = [NSData dataWithContentsOfFile:xmlFilePath];
            NSError *err;
            GDataXMLDocument *gXML = [[GDataXMLDocument alloc]initWithData:xmlData error:&err];
            CXMLDocument *tXML = [[CXMLDocument alloc]initWithData:xmlData options:0 error:&err];
            /*
             一旦文档中出现未封闭标签，GDataXMLDocument无法得到正常的内容
             Entity: line 25: parser error : Opening and ending tag mismatch: hello line 23 and package
             </package>
             Entity: line 25: parser error : Premature end of data in tag package line 2
             </package>
             CXMLDocument则可以返回正常部分内容
             */
            [self getXmlArr:tXML];
            NSLog(@"%@----%@",gXML,tXML);
        }
    }
    return self;
}

//解析document
-(void)getXmlArr:(id)xmldocument
{
    if ([xmldocument isKindOfClass:[CXMLDocument class]]) {
        NSArray *nodeArr = [xmldocument nodesForXPath:@"//opf:item" namespaceMappings:[NSDictionary dictionaryWithObject:@"http://www.idpf.org/2007/opf" forKey:@"opf"] error:nil];
        CXMLElement *root = [xmldocument rootElement];
       
        NSString *dirName;
        //章节文件
        for (CXMLElement *ele in nodeArr) {
            if ([[[ele attributeForName:@"media-type"] stringValue] isEqualToString:@"application/x-dtbncx+xml"]) {
                dirName = [[ele attributeForName:@"href"]stringValue];
                break ;
            }
        }
        NSError *err;
        NSMutableDictionary *titleDictionary;
        NSString *ncxPath = [[self.xmlFilePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:dirName];
        CXMLDocument *ncxDoc = [[CXMLDocument alloc]initWithContentsOfURL:[NSURL fileURLWithPath:ncxPath] options:0 error:&err];
        for (CXMLElement *ele in nodeArr) {
            
            NSString *href = [[ele attributeForName:@"href"] stringValue];
            
            if ([href rangeOfString:@"ncx"].location != NSNotFound) {
                
                NSArray *navPoints = [ncxDoc nodesForXPath:@"//ncx:navMap" namespaceMappings:[NSDictionary dictionaryWithObject:@"http://www.daisy.org/z3986/2005/ncx/" forKey:@"ncx"] error:nil];
                if (navPoints.count != 0) {
                    CXMLElement *titleElement = [navPoints objectAtIndex:0];
                    [titleDictionary setValue:[titleElement stringValue] forKey:href];
                    self.navPointArr = [titleElement elementsForName:@"navPoint"];
                    break;
                }
            }
        }
        
        NSMutableArray *pathList = [NSMutableArray array];
        for (CXMLElement *ele in self.navPointArr) {
            CXMLElement *contentEle = [[ele elementsForName:@"content"] objectAtIndex:0];
            NSString *charHref = [[[contentEle attributes] objectAtIndex:0]stringValue];
            CXMLElement *navLabel = [[ele elementsForName:@"navLabel"]objectAtIndex:0];
            CXMLElement *textNode = [[navLabel elementsForName:@"text"]objectAtIndex:0];
            NSString *titleText = [textNode stringValue];
            NSString *bookHref;
            bookHref = [NSString stringWithFormat:@"%@%@",[self.xmlFilePath stringByDeletingLastPathComponent],charHref];
            NSDictionary *chapterData = @{
                                          @"chapterPath":bookHref,
                                          @"chapterName":titleText
                                          };
            if ([pathList containsObject:bookHref]) {
                [self.xmlArr addObject:chapterData];
            }
            [pathList addObject:bookHref];
            
        }
    }
}

@end
