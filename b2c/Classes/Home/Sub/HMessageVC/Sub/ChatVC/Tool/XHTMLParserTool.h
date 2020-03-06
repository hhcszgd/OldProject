//
//  XHTMLParserTool.h
//  b2c
//
//  Created by wangyuanfei on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XHTMLParserToolDelegate <NSObject>

-(void)parserResult:(NSString*)result fromeUserID:(NSInteger)userID;

@end


@interface XHTMLParserTool : NSObject
@property(nonatomic,weak)id  <XHTMLParserToolDelegate> ParserToolDelegate ;
-(void)parserWithXMLStr:(NSString*)XMLStr;
-(void)parserWithHTMLStr:(NSString*)HTMLStr;
@end
