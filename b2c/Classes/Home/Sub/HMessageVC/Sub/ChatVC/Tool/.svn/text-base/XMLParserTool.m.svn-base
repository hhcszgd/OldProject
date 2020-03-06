//
//  XMLParserTool.m
//  b2c
//
//  Created by wangyuanfei on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "XMLParserTool.h"
#import "Base64.h"
@interface XMLParserTool ()<NSXMLParserDelegate>
@property(nonatomic,strong)NSXMLParser * parser ;
@end


@implementation XMLParserTool
//  XMLParserTool * _parserTool = nil;
//+(instancetype)manager{
//    
//    if (_parserTool==nil) {
//        _parserTool = [[XMLParserTool alloc]init];
//    }
//    return _parserTool;
//    
//}


-(void)parserWithXMLStr:(NSString*)XMLStr{
    self.parser = nil ;
    NSData * xmlData=[XMLStr dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser * parser = [[NSXMLParser alloc]initWithData:xmlData] ;
    self.parser = parser;
    parser.delegate = self;
    [parser parse];


}


#pragma mark xml代理
// Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser;{
    //    LOG_METHOD
    //    LOG(@"_%@_%d_开始解析%@",[self class] , __LINE__,parser);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict;{
    //    LOG_METHOD
    //    LOG(@"_%@_%d_开始elementName:%@ , 值:%@",[self class] , __LINE__,elementName,attributeDict);
    if ([self.XMLParserDelegate respondsToSelector:@selector(contentInElement:)]) {
        [self.XMLParserDelegate contentInElement:attributeDict];
    }
    
}
// sent when the parser finds an element start tag.
// In the case of the cvslog tag, the following is what the delegate receives:
//   elementName == cvslog, namespaceURI == http://xml.apple.com/cvslog, qualifiedName == cvslog
// In the case of the radar tag, the following is what's passed in:
//    elementName == radar, namespaceURI == http://xml.apple.com/radar, qualifiedName == radar:radar
// If namespace processing >isn't< on, the xmlns:radar="http://xml.apple.com/radar" is returned as an attribute pair, the elementName is 'radar:radar' and there is no qualifiedName.

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName;{
    //    LOG_METHOD
    //    LOG(@"_%@_%d_结束elementName:%@ ",[self class] , __LINE__,elementName);
}

// sent when the parser begins parsing of the document.
- (void)parserDidEndDocument:(NSXMLParser *)parser;{
    //    LOG_METHOD
    //    LOG(@"_%@_%d_结束解析%@",[self class] , __LINE__,parser);
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

{
    
    //一对标签之内的内容
    NSData * xmlData  = [Base64 decode:string];
    NSString * resultXML =[[NSString alloc]initWithData:xmlData encoding:NSUTF8StringEncoding];
    //    LOG(@"_%@_%d_元素内容%@",[self class] , __LINE__,resultXML);
    NSRange headerRange = [resultXML rangeOfString:@"><div>"];
    NSRange footerRange = [resultXML rangeOfString:@"</div></div>"];
    ;
    
    if ([resultXML containsString:@"<div"] && [resultXML containsString:@"</div>"]) {
        LOG(@"_%@_%d_headerRange-->%@ , footerRange--->%@",[self class] , __LINE__,NSStringFromRange(headerRange),NSStringFromRange(footerRange));
        NSString * targetStr = [resultXML substringWithRange:NSMakeRange(headerRange.location + headerRange.length , footerRange.location-headerRange.location - headerRange.length)];
        if ([targetStr containsString:@"{$USER_IMAGE_PATH$}"]) {//用户图片
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"~~~~~~~~~~~~~~~~~~~~~~~~~~用户图片");
//            if ([self.XMLParserDelegate respondsToSelector:@selector(contentBetweenElement:)]) {
//                [self.XMLParserDelegate contentBetweenElement:targetStr];
//            }
            
        }else if ([targetStr containsString:@"{$SYS_IMAGE_PATH$}"]){
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"~~~~~~~~~~~~~~~~~~~~~~~~~~系统图片");
        }else{
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"~~~~~~~~~~~~~~~~~~~~~~~~~~文本信息");
            
            if ([self.XMLParserDelegate respondsToSelector:@selector(contentBetweenElement:)]) {
                [self.XMLParserDelegate contentBetweenElement:targetStr];
            }
//            if ([self.AcceptMessateDelegate respondsToSelector:@selector(messageFromOthers:inChatTool:)]) {
//                [self.AcceptMessateDelegate messageFromOthers:targetStr inChatTool:self];
//            }
            
        }
        /**
         targetStr有三种形式
         1 , 用户图片
         <img name="{4B504B2A64DEB05F03542B58FF54C4F}" Width="148" Height="39" hspace=1 vspace=1 src="{$USER_IMAGE_PATH$}{4B504B2A64DEB05F03542B58FF54C4F}.jpg,4">
         2 , 系统图片
         <img name="" Width="24" Height="24" hspace=1 vspace=1 src="{$SYS_IMAGE_PATH$}52.gif">
         3 , 正常的文本信息
         
         */
        
        
        
        
        LOG(@"_%@_%d_%@\n元数据是%@\n解析出来的发送的数据是%@",[self class] , __LINE__,@"html数据格式合格 , 可以解析",resultXML,targetStr);
        
    }else{
        LOG(@"_%@_%d_%@\n%@",[self class] , __LINE__,@"html数据格式 不 合格 , 不  可以解析",resultXML);
    }
    
    
    //    [self analysisXMLStr:resultXML];
    
}

- (NSString *)findHyperLinkWithString:(NSString *)rawString{
    if (rawString.length <= 0) {
        return @"";
    }
    NSError *error;
    NSRegularExpression *orderNumRegExp;
    
    //    NSString *orderNumRegExpStr = @"\\[.*:.*\\]"; //正则匹配表达式
    
    NSString *orderNumRegExpStr = @"^[>][<][d][i][v][>]{+}   </div></div>"; //正则匹配表达式
    
    orderNumRegExp = [NSRegularExpression regularExpressionWithPattern:orderNumRegExpStr
                                                               options:0 error:&error];
    if (!error) {
        
        NSTextCheckingResult *matchResult = [orderNumRegExp firstMatchInString:rawString options:0 range:NSMakeRange(0, rawString.length)];
        
        if (matchResult) {
            NSString* matchedString = [rawString substringWithRange:matchResult.range];
            //            NSRange range = [matchedString rangeOfString:@":"];
            
            return matchedString;
        }
    }
    return nil;
}

/*
 
 
 // sent when the parser has completed parsing. If this is encountered, the parse was successful.
 
 // DTD handling methods for various declarations.
 - (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,name);
 }
 
 - (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID notationName:(nullable NSString *)notationName;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,name);
 }
 
 - (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(nullable NSString *)type defaultValue:(nullable NSString *)defaultValue;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,elementName);
 }
 
 - (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,elementName);
 }
 
 - (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(nullable NSString *)value;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,name);
 }
 
 - (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)name publicID:(nullable NSString *)publicID systemID:(nullable NSString *)systemID;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 
 // sent when an end tag is encountered. The various parameters are supplied as above.
 
 - (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // sent when the parser first sees a namespace attribute.
 // In the case of the cvslog tag, before the didStartElement:, you'd get one of these with prefix == @"" and namespaceURI == @"http://xml.apple.com/cvslog" (i.e. the default namespace)
 // In the case of the radar:radar tag, before the didStartElement: you'd get one of these with prefix == @"radar" and namespaceURI == @"http://xml.apple.com/radar"
 
 - (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // sent when the namespace prefix in question goes out of scope.
 
 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // This returns the string of the characters encountered thus far. You may not necessarily get the longest character run. The parser reserves the right to hand these to the delegate as potentially many calls in a row to -parser:foundCharacters:
 
 - (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // The parser reports ignorable whitespace in the same way as characters it's found.
 
 - (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(nullable NSString *)data;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // The parser reports a processing instruction to you using this method. In the case above, target == @"xml-stylesheet" and data == @"type='text/css' href='cvslog.css'"
 
 - (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // A comment (Text in a <!-- --> block) is reported to the delegate as a single string
 
 - (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // this reports a CDATA block to the delegate as an NSData.
 
 //- (nullable NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)name systemID:(nullable NSString *)systemID;{
 //    LOG_METHOD
 //    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 //}
 // this gives the delegate an opportunity to resolve an external entity itself and reply with the resulting data.
 
 - (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 // ...and this reports a fatal error to the delegate. The parser will stop parsing.
 
 - (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError;{
 LOG_METHOD
 LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调用了上面这个方法");
 }
 */

@end
