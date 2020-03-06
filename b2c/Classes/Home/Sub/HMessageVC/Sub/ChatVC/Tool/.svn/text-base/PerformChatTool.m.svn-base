//
//  PerformChatTool.m
//  b2c
//
//  Created by wangyuanfei on 16/5/12.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PerformChatTool.h"
#import "Base64.h"
#import "XHTMLParserTool.h"
#import "ChatModel.h"
@interface PerformChatTool()<XHTMLParserToolDelegate>
@property(nonatomic,copy)NSString * sessionID ;
@property(nonatomic,strong)NSTimer * timer ;
@property(nonatomic,copy)NSString * prefix ;//头一次放回
@property(nonatomic,copy)NSString * suffix ;//二次返回
@property(nonatomic,strong)ChatModel * chatModel ;

@end


@implementation PerformChatTool

#pragma mark 自定义解析代理





-(instancetype)init{
    if (self=[super init]) {

        // 1.1.创建一个客户端的socket对象
//        GCDAsyncSocket *clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
//        self.clientSocket = clientSocket;
//
//        //1.2 发送连接请求
//        NSError *error = nil;
//        [clientSocket connectToHost:@"203.130.41.166" onPort:19998 error:&error];

//        if (!error) {
//            NSLog(@"%@",error);
//        }

    }
    return self;
}
/*
#pragma socket 代理
-(void)socket:(GCDAsyncSocket *)clientSocket didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"与服务器连接成功");
    //链接成功 立即登录
    [self checkHeartBate];
    [self performLogin];
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        //            [self.tableView reloadData];
//        [self removeTimer];
//        [self addTimer];
//    }];

    [clientSocket readDataWithTimeout:-1 tag:0];
    
    
}

// Disconnect 断开连接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"与服务器断开连接 , 错误信息%@",err);
    [sock readDataWithTimeout:-1 tag:0];
    // 1.2 发送连接请求
    NSError *error = nil;
    [sock connectToHost:@"203.130.41.166" onPort:19998 error:&error];
    
    if (!error) {
        NSLog(@"%@",error);
    }
}

// 读取消息k
-(void)socket:(GCDAsyncSocket *)clientSocket didReadData:(NSData *)data withTag:(long)tag{
    
//    TestXMLTool * test = [[TestXMLTool alloc]init];
//    [test parserWithXMLData:data];
    NSString *result  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    LOG(@"_%@_%d_sockect信息%@",[self class] , __LINE__,result);
    
    NSString *str=result.copy;
    

    
    if ( [str containsString:@"</message></cim>"] && [str containsString:@"<cim client='cs' type='recvMessage'>" ] && [str hasPrefix:@"<cim client='cs' type='recvMessage'>"]) {
        NSString * totalStr  = str;
        
//        LOG(@"\n_%@_%d_读取服务器返回信息-----------全------------\n%@",[self class] , __LINE__,str);
        ChatModel * currentModel = [[ChatModel alloc]init];
        self.chatModel = currentModel;
        
        
        XHTMLParserTool * tool = [[XHTMLParserTool alloc]init];
        tool.ParserToolDelegate = self;
        [tool parserWithXMLStr:totalStr];///////////暂注//////////////////
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"解析完毕了 , 返回给调用者");
        NSString * temp = [self.chatModel.message substringWithRange:NSMakeRange(self.chatModel.message.length/2, self.chatModel.message.length/2)];
        self.chatModel.message = temp;
//        LOG(@"_%@_%d_解析完毕了 , 返回给调用者%@",[self class] , __LINE__,self.chatModel.message);

        if ([self.AcceptMessateDelegate respondsToSelector:@selector(messageFromOthers:inChatTool:)] && self.chatModel.message.length>0) {
            [self.AcceptMessateDelegate messageFromOthers:self.chatModel inChatTool:self];
        }
        
        self.chatModel = nil;
    } else if([str containsString:@"<cim client='cs' type='recvMessage'>"] && [str hasPrefix:@"<cim client='cs' type='recvMessage'>"]){
        self.prefix = nil;
        self.prefix = str;
        //        LOG(@"_%@_%d_读取服务器返回信息--前--%@",[self class] , __LINE__,str);
//        LOG(@"_%@_%d___________________________前______________________________\n%@",[self class] , __LINE__, self.prefix);
        
        
    }else if ([str containsString:@"</message></cim>"] ){
        self.suffix = nil;
        
        //用户消息
        self.suffix = str;
        NSString * totalStr = [self.prefix stringByAppendingString:self.suffix];
//        LOG(@"_%@_%d___________________________后______________________________\n%@",[self class] , __LINE__, self.suffix);
//        LOG(@"\n_%@_%d_手动解析得到的数据(用户) ----------------拼接-----------------\n%@",[self class] , __LINE__,totalStr);

        ChatModel * currentModel = [[ChatModel alloc]init];
        self.chatModel = currentModel;
        
        XHTMLParserTool * tool = [[XHTMLParserTool alloc]init];
         tool.ParserToolDelegate = self;
        [tool parserWithXMLStr:totalStr];
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"解析完毕了 , 返回给调用者");
        NSString * temp = [self.chatModel.message substringWithRange:NSMakeRange(self.chatModel.message.length/2, self.chatModel.message.length/2)];
        self.chatModel.message = temp;
//        LOG(@"_%@_%d_解析完毕了 , 返回给调用者%@",[self class] , __LINE__,self.chatModel.message);
        if ([self.AcceptMessateDelegate respondsToSelector:@selector(messageFromOthers:inChatTool:)] && self.chatModel.message.length>0) {
            [self.AcceptMessateDelegate messageFromOthers:self.chatModel inChatTool:self];
        }
        self.chatModel = nil;
    }
    


    
    // 把消息添加到数据源
    if (str) {
//        [self.dataSources addObject:str];
        
        // 刷新表格
#pragma mark 要在主线程
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //            [self.tableView reloadData];
        }];
    }
    // 监听读取数据
    [clientSocket readDataWithTimeout:-1 tag:0];
    
}
-(void)parserResult:(NSString *)result fromeUserID:(NSInteger)userID{
    self.chatModel. fromID = userID;
    if (!self.chatModel.message) {
        self.chatModel.message = [[NSString new] stringByAppendingString:result];
    }else{
        self.chatModel.message = [self.chatModel.message stringByAppendingString:result];

    }

}
//发送数据后的回调
- (void)onSocket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
//    LOG(@"_%@_%d_发送数据后的回调-----%@",[self class] , __LINE__,sock);暂时注释
}
*/
#pragma 执行登录
//自定义登录请求(success)
- (void)performLogin
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * md5Password = [@"123456" md5String];
    NSString * username = @"caohenghui@16lao.com";
    
    
    
    
    NSString *dataUrl =[NSString stringWithFormat:@"http://203.130.41.166:8878/cimls/service/HttpService?function=login&json=true"];

    NSString *param = [NSString stringWithFormat:@"loginId=%@&password=%@", username, md5Password];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/xml", nil];
    [manager POST:dataUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString * result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        [self analysisResposeString:result];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //            [self.tableView reloadData];
//            [self removeTimer];
//            [self addTimer];
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        
    }];
    
    
}
///解析登录返回数据
- (void) analysisResposeString:(NSString*) responseString
{
    // 解析json数据
    NSRange pre = [responseString rangeOfString:@"try{var cimdataXML="];
    NSRange suf = [responseString rangeOfString:@";}catch(ex){};"];
    
    if(pre.length == 0 || suf.length == 0){
        //        return nil;
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据解析失败 , 参数为空 或数据格式不是预期的");
    }
    // 去掉JSONP包装数据
    responseString = [responseString substringWithRange: NSMakeRange(pre.location + pre.length, responseString.length - suf.length - pre.length - pre.location)];
    NSLog(@"json data:\n%@", responseString);
    
    // 1.json -> NSDictionary
    NSError *error;
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding: NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    if (error == nil) {
        //        return reposeDic;
        //        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseDic);
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据解析成功");
        if (responseDic[@"cim"]) {
            NSDictionary * cimDict = responseDic[@"cim"];
            NSDictionary * resultDict = cimDict[@"result"];
//            NSDictionary * userDict = cimDict[@"user"];
            self.sessionID = resultDict[@"sessionid"];
            [self checkHeartBate];
#pragma mark ceshi 
//            [self addTimer];

            LOG(@"_%@_%d_%@",[self class] , __LINE__,self.sessionID);
            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,resultDict);
            //            LOG(@"_%@_%d_%@",[self class] , __LINE__,userDict);
        }
        
        
    }else {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"数据解析成功");
    }
    
}
#pragma 定时器操作
-(void)addTimer{
    NSTimer * timer =[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkHeartBate) userInfo:nil repeats:YES];
    self.timer =timer ;
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    ///////////
    LOG(@"_%d_%@",__LINE__,@"添加了定时器");
}
-(void)removeTimer{
    //    [self.timer invalidate];
    //    self.timer=nil;
    LOG(@"_%d_%@",__LINE__,@"移除了定时器");
}
#pragma 心跳检测
-(void)checkHeartBate
{
    if (self.sessionID.length>0) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"取得sesstionID, 执行心跳检测");
        NSString * content = [NSString stringWithFormat:@"<cim client=\"cs\" type=\"login\" priority=\"%d\"><user sessionId=\"%@\" status=\"%d\"/></cim>", 0, self.sessionID, 10];
        content = [content stringByAppendingString:@"\0"];
//        NSData* sendData = [content dataUsingEncoding: NSUTF8StringEncoding];
//        [self.clientSocket writeData:sendData withTimeout:-1 tag:0];
        
    }else{
        
        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"未取得sesstionID");
    }
    
}

#pragma 执行数据包发送
/**
 发送消息 消息格式 用
 <cim client="cs" type="sendMessage"><userList><user id="2000000001001000002"/></userList><message type="1" groupId="0" userStauts="10">SU9TIOa2iOaBr+adpeS6hg==</message></ cim>
 */
-(void) sendMessage:(NSString *)content usersId:(NSString *)usersId messageType:(int)messageType/**默认传1*/
{
    content =[[content stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"]mutableCopy];
    
    NSLog(@"content:===%@===userId:===%@===",content,usersId);
    
    content=[content stringByReplacingOccurrencesOfString:@"\U0000fffc" withString:@""];
    // [_cimClient sendMessage:content messageType:messageType userId: usersId];
    NSString *userList = [NSString stringWithFormat:@"<user id=\"%@\"/>", usersId];
    
    NSData *messageData = [content dataUsingEncoding: NSUTF8StringEncoding];
    NSString *messageXML = [NSString stringWithFormat:@"<cim client=\"cs\" type=\"sendMessage\" resp=\"10198\"><userList>%@</userList><message type=\"%d\" groupId=\"0\" userStauts=\"10\">%@</message></cim>", userList, messageType, [Base64 encode:messageData]];
    [self send:messageXML];
    
}
//要向服务器发送的字符串消息
- (void)send:(NSString*)content
{
//    if (!self.clientSocket.isConnected)
//    {
//        return;
//    }
    
    
    //    if (self.clientSocket.isShowSendData),,,,,
    //    {
    //        NSLog(@"发送给服务器的数据是:%@", content);
    //    }
    
    //NSLog(@"我发送的消息: %@", content);
    //\0是结束符 必须添加
//    LOG(@"_%@_%d_发送的数据内容%@",[self class] , __LINE__,content);
//    content = [content stringByAppendingString:@"\0"];
//    NSData* sendData = [content dataUsingEncoding: NSUTF8StringEncoding];
//    [self.clientSocket writeData:sendData withTimeout:-1 tag:0];
//    [self.clientSocket readDataWithTimeout:-1 tag:0];
}


// If validation is on, this will report a fatal validation error to the delegate. The parser will stop parsing.

@end
