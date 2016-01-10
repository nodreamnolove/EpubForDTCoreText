//
//  GetXMLArray.h
//  EpubForDTCoreText
//
//  Created by 段瑞权 on 16/1/10.
//  Copyright © 2016年 epub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetXMLObject : NSObject

@property (nonatomic,copy) NSString * xmlFilePath;

@property (nonatomic,strong) NSMutableArray * xmlArr;

-(instancetype)initWithPath:(NSString*)xmlFilePath;
@end
