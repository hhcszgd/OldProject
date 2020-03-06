//
//  TestXMLTool.m
//  b2c
//
//  Created by wangyuanfei on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "TestXMLTool.h"

#import "TFHpple.h"

@interface TestXMLTool ()



@end

@implementation TestXMLTool

-(void)parserWithXMLData:(NSData*)XMLData{
    TFHpple * paser = [[TFHpple alloc]initWithXMLData:XMLData];
    //Get all the cells of the 2nd row of the 3rd table
    NSArray *elements  = [paser searchWithXPathQuery:@"//cim"];
    
    // Access the first cell
    if (!(elements.count>0)) {
        return;
    }
//    TFHppleElement *element = [elements objectAtIndex:0];
    
    // Get the text within the cell tag
//    NSString *content = [element content];
//    LOG(@"XXXXXXXX-----------------------------XXXXXXXXX---------------------------------XXXXXXXXXXXXXX_%@_%d_%@",[self class] , __LINE__,elements);
    
    
}
@end
