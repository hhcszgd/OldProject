//
//  XMLParserTool.h
//  b2c
//
//  Created by wangyuanfei on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMLParserToolDelegate <NSObject>

-(void)contentInElement:(id)content;//应该是个字典
-(void)contentBetweenElement:(NSString*)content;//应该是个字符串,后续换成一个 消息模型


@end


@interface XMLParserTool : NSObject
@property(nonatomic,weak)id  <XMLParserToolDelegate> XMLParserDelegate ;

//+(instancetype)manager;

-(void)parserWithXMLStr:(NSString*)XMLStr;
@end
