//
//  XHTMLParserTool.m
//  b2c
//
//  Created by wangyuanfei on 16/5/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "XHTMLParserTool.h"

#import "Base64.h"

#import "TFHpple.h"
#import "ChatModel.h"

@interface XHTMLParserTool ()

@property(nonatomic,copy)NSString * currentTxtMessage ;
@property(nonatomic,copy)NSString * currentImgMessage ;
@property(nonatomic,strong)NSMutableString * currentTotalMessage ;
/** 好友ID */
@property(nonatomic,assign)NSInteger ID ;

@end



@implementation XHTMLParserTool


-(void)parserWithXMLStr:(NSString*)XMLStr{
//    LOG(@"_%@_%d_传到解析器中的字符串是------------------------oooooooooooooooooooooo--------------------------\n%@",[self class] , __LINE__,XMLStr);
    
    NSData * xmlData = [XMLStr dataUsingEncoding:NSUTF8StringEncoding];

    TFHpple * paser = [[TFHpple alloc]initWithXMLData:xmlData];
    //Get all the cells of the 2nd row of the 3rd table
    NSArray *elements  = [paser searchWithXPathQuery:@"//cim"];
    
    // Access the first cell
    if (!(elements.count>0)) {
        return;
    }
//    TFHppleElement *element = [elements objectAtIndex:0];
    
    // Get the text within the cell tag
//    LOG(@"转换成解析对象是XXXXXXXX----------XXXXXX--------------XXXXXXX_%@_%d_\n%@",[self class] , __LINE__,elements);
//    [self analysisResultWithXMLdata:elements];

    
    
}
-(void)parserWithHTMLStr:(NSString*)HTMLStr{

    NSData * htmlData = [HTMLStr dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple * paser = [[TFHpple alloc]initWithHTMLData:htmlData];
    //Get all the cells of the 2nd row of the 3rd table
    NSArray *elements  = [paser searchWithXPathQuery:@"//div"];
    
    // Access the first cell
    if (!(elements.count>0)) {
        return;
    }
//    LOG(@"XXXXXXXX-----------------------------XXXXXXXXX---------------------------------XXXXXXXXXXXXXX_%@_%d_%@",[self class] , __LINE__,elements);
    [self analysisResultWithHTMLdata:elements];
    
    

}
-(void)analysisResultWithXMLTFHppleElement:(TFHppleElement* )hppleElement{

//    LOG(@"_%@_%d_XXXXXX------------XXX生成的标签对象XX-------------XXXXXXX\n%@",[self class] , __LINE__,hppleElement);
//    LOG(@"_%@_%d_tagName------%@",[self class] , __LINE__,hppleElement.tagName);
    
    if ([hppleElement.tagName isEqualToString:@"cim"]) {
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,[hppleElement objectForKey:@"client"]);
        

    }else if ([hppleElement.tagName isEqualToString:@"user"]){
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,[hppleElement objectForKey:@"id"]);
        self.ID =[[hppleElement objectForKey:@"id"] integerValue];
    
    }else if ([hppleElement.tagName isEqualToString:@"message"]){
        
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,hppleElement.content);//content是标签之间的内容
        NSData * xmlData  = [[NSData alloc] initWithBase64EncodedString:hppleElement.content options:0];
        NSString * message =[[NSString alloc]initWithData:xmlData encoding:NSUTF8StringEncoding];
        if ([message containsString:@"<div"]) {
//            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"继续进行html解析");

            [self parserWithHTMLStr:message];
        }else{
            //无需解析 , 直接输出 应该是true 和  flase
        }
        
    }else if ([hppleElement.tagName isEqualToString:@"text"]){
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,hppleElement.content);//这个方法是标签里的属性
        
    }

    
    if ([hppleElement hasChildren]) {
        for (TFHppleElement*sub in hppleElement.children) {
            [self analysisResultWithXMLTFHppleElement:sub];
        }
    }
}

-(void)analysisResultWithXMLdata:(id )data//arr || dict
{
    
    for (id sub in data) {
        
        if ([sub isKindOfClass:[TFHppleElement class]]) {
            TFHppleElement * electment  = (TFHppleElement *)sub;
            [self analysisResultWithXMLTFHppleElement:electment];
        }else{
            LOG(@"_%@_%d_不是解析对象 ,另当处理%@",[self class] , __LINE__,sub );
        
        }
    }

}


















-(void)analysisResultWithHTMLTFHppleElement:(TFHppleElement* )hppleElement{
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,hppleElement.tagName);
    if ([hppleElement.tagName isEqualToString:@"div"]){
//        LOG(@"_%@_%d_----文字信息------%@",[self class] , __LINE__,[hppleElement objectForKey:@"style"]);
    }else if ([hppleElement.tagName isEqualToString:@"text"]){
        NSString * currentTxtMessage = hppleElement.content;
//        if (![currentTxtMessage isEqualToString:self.currentTxtMessage]) {
            //执行输出
            self.currentTxtMessage = currentTxtMessage;//每解析一次外面传过来的数据以后当前类对应的对象就会销毁, 不用担心两次发的信息一样导致不会输出
//            LOG(@"_%@_%d_用户所发文本信息是----->%@",[self class] , __LINE__,currentTxtMessage);
            [self returnTheParserResult:currentTxtMessage];

    }else if ([hppleElement.tagName isEqualToString:@"img"]){
        NSString * currentImgMessage = [hppleElement objectForKey:@"src"];
        CGFloat  imgWidth = [[hppleElement objectForKey:@"width"] floatValue];
        CGFloat  imgHeight = [[hppleElement objectForKey:@"height"] floatValue];
        
//        if (![currentImgMessage isEqualToString: self.currentImgMessage]) {
            //执行输出
            self.currentImgMessage = currentImgMessage;
            
            if ([currentImgMessage containsString:@"{$USER_IMAGE_PATH$}"]) {//图片单独处理吧
                LOG(@"_%@_%d_用户自有图片信息是----->%@",[self class] , __LINE__,currentImgMessage);//这个方法是标签里的属性
                LOG(@"_%@_%d_图片的宽是-->%lf ,     高是---->%lf",[self class] , __LINE__,imgWidth,imgHeight);
            }else if ([currentImgMessage containsString:@"{$SYS_IMAGE_PATH$}"]){
//                LOG(@"_%@_%d_软件自带图片信息是----->%@",[self class] , __LINE__,currentImgMessage);//这个方法是标签里的属性
//                LOG(@"_%@_%d_图片的宽是-->%lf ,     高是---->%lf",[self class] , __LINE__,imgWidth,imgHeight);//图片狂傲24 就写死吧
                NSString * temp = [currentImgMessage substringFromIndex:[@"{$SYS_IMAGE_PATH$}" length]];
                NSString * targetImgName = [NSString stringWithFormat:@")]%@([",temp];
                [self returnTheParserResult:targetImgName];

            }
 
//        }
    }
    
    
    if ([hppleElement hasChildren]) {
        for (TFHppleElement*sub in hppleElement.children) {
            [self analysisResultWithHTMLTFHppleElement:sub];
        }
    }
    
}

-(void)returnTheParserResult:(NSString*)result
{
    if ([self.ParserToolDelegate respondsToSelector:@selector(parserResult:fromeUserID:)]) {
        [self.ParserToolDelegate parserResult:result fromeUserID:self.ID];
    }
}

-(void)analysisResultWithHTMLdata:(id )data//arr || dict
{
    
    for (id sub in data) {
        
        if ([sub isKindOfClass:[TFHppleElement class]]) {
            TFHppleElement * electment  = (TFHppleElement *)sub;
            [self analysisResultWithHTMLTFHppleElement:electment];
        }else{
//            LOG(@"_%@_%d_另当处理%@",[self class] , __LINE__,sub );
            
        }
    }

}

@end
