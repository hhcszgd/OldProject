//
//  GDXmppManager.m
//  b2c
//
//  Created by wangyuanfei on 16/6/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GDXmppStreamManager.h"
#import "XMPPPresence+XEP_0172.h"
#import "zjlao-Swift.h"
#import "XMPPFramework.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPAutoPing.h"
#import "GDMessage.h"
//这三个类可以答应连接过程的日志
//#import "DDLog.h"
//#import "DDTTYLogger.h"
//#import "XMPPLogging.h"
//#import "XMPPvCardAvatarModule.h"
//#import "XMPPAutoPing.h"
//#import "XMPPRosterCoreDataStorage.h"
//#import "XMPPvCardCoreDataStorage.h"
//#import "XMPPRoster.h"
//#import "XMPPMessageArchiving.h"
//#import "XMPPMessageArchivingCoreDataStorage.h"
//#import "CocoaLumberJack/DDLog.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPAutoPing.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPTransports.h"

/*
 - (XMPPResourceCoreDataStorageObject *)resourceForJID:(XMPPJID *)jid
 xmppStream:(XMPPStream *)stream
 managedObjectContext:(NSManagedObjectContext *)moc;
 */
#import "XMPPvCardCoreDataStorage.h"
#import "XMPPRoster.h"
#import "XMPPMessageArchiving.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "CocoaLumberJack/DDLog.h"
@class  XMPPSIFileTransfer;
#import "XMPPReconnect.h"

#import "XMPPvCardTemp.h"

#import "XMPPIncomingFileTransfer.h"
#import "XMPPOutgoingFileTransfer.h"

@interface GDXmppStreamManager () <XMPPIncomingFileTransferDelegate,XMPPStreamDelegate,XMPPReconnectDelegate> 

@property(nonatomic,strong)XMPPJID * myJid ;

@property(nonatomic,strong)XMPPTransports * transports ;
/** 联系人查询控制器 */
@property (nonatomic , strong)NSFetchedResultsController * contactFetchedresultsController;
/** 单个联系人的消息查询控制器 */
@property (nonatomic , strong)NSFetchedResultsController * messageFetchedresultsController;
/**铃声播放器*/
@property(nonatomic,strong)AVAudioPlayer  * player ;
@end


@implementation GDXmppStreamManager




static GDXmppStreamManager *share;

/** 临时更改密码 */

-(NSString *)password{

    
    //    if ([_myJid.user isEqualToString:@"fuckfuck"]) {
    //        return [UserInfo shareUserInfo].password; //密码验证好使
    //    }else{
    //         return _password;//token认证
    //    }
    if (!_password) { // 使用密码认证
        _password = [[NSUserDefaults standardUserDefaults] stringForKey:@"IMPASSWORD"];
    }
    NSLog(@"im密码密码密码密码_%d_%@",__LINE__,_password);
    return _password;//token认证
//    return @"7c9f7874cb09f74f36664d75df070ffe";
//    return  @"123456";
}
-(void)setupTransports{
    if (!self.transports) {
        self.transports = [[XMPPTransports alloc] initWithStream:self.XmppStream];
        
    }
    //    [self.transports queryGatewayDiscoveryIdentityForLegacyService:@"jabber.zjlao.com"];
    //    [self.transports queryGatewayAgentInfo];
    [self.transports registerLegacyService:@"jabber.zjlao.com" username:Account.shareAccount.name password:self.password];
}
//创建一个单例
+(instancetype)ShareXMPPManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [GDXmppStreamManager new];
        
    });
    return share;
}

//懒加载
-(XMPPStream *)XmppStream
{
    if (_XmppStream == nil) {
        self.isNeedReconnect = YES ;
        _XmppStream = [[XMPPStream alloc]init];
        //连接openfire服务器
        //        _XmppStream.hostName = @"172.16.2.209";
        
//                _XmppStream.hostName = @"192.168.4.111";
        _XmppStream.hostName = @"jabber.zjlao.com";//待改回
        //还需要一个端口号
        _XmppStream.hostPort = 5222;
        [_XmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
        //        [_XmppStream connectWithTimeout:-1 error:0];
        //        [DDLog addLogger:[DDTTYLogger sharedInstance] withLogLevel:XMPP_LOG_FLAG_SEND_RECV ];
        //        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        _XmppStream.enableBackgroundingOnSocket = YES ;
    }
    return _XmppStream;
}
//自动重连
-(XMPPReconnect *)XmppReconnect
{
    if (_XmppReconnect == nil) {
        //2. 创建对象
        _XmppReconnect = [[XMPPReconnect alloc]initWithDispatchQueue:dispatch_get_global_queue(0, 0)];
        //3.设置代理,参数
        [_XmppReconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        _XmppReconnect.autoReconnect = NO ;
        
        //时间间隔
//        _XmppReconnect.reconnectTimerInterval = 1;
        
    }
    return _XmppReconnect;
}
//心跳检测
-(XMPPAutoPing *)XmppAutoping
{
    if (_XmppAutoping == nil) {
        //2.创建对象
        _XmppAutoping = [[XMPPAutoPing alloc]initWithDispatchQueue:dispatch_get_global_queue(0, 0)];
        //3.设置代理,参数
        [_XmppAutoping addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //ping间隔
        _XmppAutoping.pingInterval = 10;//默认60秒
        
    }
    return _XmppAutoping;
}

//创建通讯录对象
-(XMPPRoster *)XmppRoster
{
    if (_XmppRoster == nil) {
        //2.创建对象
        _XmppRoster = [[XMPPRoster alloc]initWithRosterStorage:[XMPPRosterCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_main_queue()];
        
        //3.设置代理,参数
        
        _XmppRoster.autoFetchRoster = YES;//自动查找通讯录
        
        _XmppRoster.autoClearAllUsersAndResources = NO;//下线是否删除好友.
        
        _XmppRoster.autoAcceptKnownPresenceSubscriptionRequests = NO;//xmpp中有一个自动实现的方法
    }
    return _XmppRoster;
}

//播放器

-(AVAudioPlayer * )player{
    if(_player==nil){
//        NSString * path = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
//        NSBundle * subBundel = [NSBundle bundleWithPath:path];
//        NSString * soundPath = [subBundel pathForResource:@"twitter" ofType:@"mp3" inDirectory:@"Sound"];
//        NSURL * u = [[NSURL alloc]initFileURLWithPath:soundPath];
//        NSError * error = [[NSError alloc]init];
//        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:u error:&error];
//        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
        NSBundle * subBundel = [NSBundle bundleWithPath:path];
        NSString * soundPath = [subBundel pathForResource:@"twitter" ofType:@"mp3" inDirectory:@"Sound"];
        NSData *data = [[NSData data]initWithContentsOfFile:soundPath];
        NSError * error = [[NSError alloc]init];
        _player =[[AVAudioPlayer alloc]initWithData:data error: &error];
    
    }
    return _player;
}

/**文件传出*/
-(XMPPOutgoingFileTransfer * )fileOutTransfer{
    if(_fileOutTransfer==nil){
        _fileOutTransfer = [[XMPPOutgoingFileTransfer alloc]init];
         [_fileOutTransfer addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _fileOutTransfer;
}
/**文件传入*/
-(XMPPIncomingFileTransfer * )fileInTransfer{
    if(_fileInTransfer==nil){
        _fileInTransfer = [[XMPPIncomingFileTransfer alloc]init];
         [_fileInTransfer addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_fileInTransfer setAutoAcceptFileTransfers:YES];
    }
    return _fileInTransfer;
}
- (void)xmppAutoPingDidReceivePong:(XMPPAutoPing *)sender{
//    LOG(@"_%@_%d_服务器响应的心跳检测 %@",[self class] , __LINE__,sender);
}
- (void)xmppAutoPingDidTimeout:(XMPPAutoPing *)sender{
//    LOG(@"_%@_%d_心跳检测超时%@",[self class] , __LINE__,sender);
}
//消息
-(XMPPMessageArchiving *)XmppMessageArchiving
{
    if (_XmppMessageArchiving == nil) {
        //创建模块
        _XmppMessageArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:[XMPPMessageArchivingCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_main_queue()];
        
        //设置代理,和参数
    }
    return _XmppMessageArchiving;
}
//个人资料
-(XMPPvCardTempModule *)xmppvcardtempModule
{
    if (_xmppvcardtempModule == nil) {
        _xmppvcardtempModule = [[XMPPvCardTempModule alloc]initWithvCardStorage:[XMPPvCardCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_main_queue()
                                ];
        
        
    }
    return _xmppvcardtempModule;
}
//头像
-(XMPPvCardAvatarModule *)xmppvcardavatarModule
{
    if (_xmppvcardavatarModule == nil) {
        _xmppvcardavatarModule = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_xmppvcardtempModule dispatchQueue:dispatch_get_main_queue()];
    }
    return _xmppvcardavatarModule;
}

//实现登录
-(void)loginWithJID:(XMPPJID *)jid passWord:(NSString *)password
{
    
    NSString * prefix = @"z~";
    if (![Account shareAccount].name) {
        return;
    }
    NSString * realUsername = [prefix stringByAppendingString:Account.shareAccount.name];
     NSLog(@"\n\n\n_%d_%@",__LINE__,realUsername);
    XMPPJID * tempJid = [XMPPJID jidWithUser:realUsername domain:@"jabber.zjlao.com" resource:@"iOS"];
    [self.XmppStream setMyJID:tempJid];
    self.myJid = tempJid;//这儿的im用户名需要拼zzzzzzz吗
    //拿到密码
//    self.password = password.copy;
    
    NSError *error = nil;
    
    BOOL connectResult = [self.XmppStream connectWithTimeout:-1 error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    
#pragma mark 激活模块
    [self activeFunction];
    
}

- (void)activeFunction
{
    //激活自动重连
//    [self.XmppReconnect activate:self.XmppStream];
    
    //激活心跳检测
    [self.XmppAutoping activate:self.XmppStream];
    
    //激活好友模块
    [self.XmppRoster activate:self.XmppStream];
    
    //激活消息模块
    [self.XmppMessageArchiving activate:self.XmppStream];
    
    //激活个人资料
    [self.xmppvcardtempModule activate:self.XmppStream];
    
    //头像激活
    [self.xmppvcardavatarModule activate:self.XmppStream];
    //图片传输模块
    //文件传入
    [self.fileInTransfer activate:self.XmppStream];
    //文件传出
    [self.fileOutTransfer activate:self.XmppStream];
}
/** 代理接收图片 */
- (void)receivedImage:(NSData*)image from:(XMPPJID*)from{
}
/** 发送图片 */
- (void)sendImageMessage:(NSData *)imageData toAccount:(NSString *)account{
    
    ////    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@", account, @"jabber.zjlao.com", [[self.XmppStream myJID] resource]]];
    //    XMPPJID *  jid = [XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"];
    //
    
    //
    //
    //    [self.FileTransfer initiateFileTransferTo:jid withData:imageData];
    
    
    XMPPJID *  senderFullID = [XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"iOS"];
    
    
    XMPPJID *jid =senderFullID;
    //    sifiletransfer=[[XMPPSIFileTransfer alloc]init];
    //    senderFullID.
    
    //    TURNSocket *socket1 = [[TURNSocket alloc] initWithStream:self.XmppStream toJID:jid];
    // [turnSockets addObject:turnSocket];
    //    [socket1 startWithDelegate:self.FileTransfer delegateQueue:dispatch_get_main_queue()];
    //    [self.FileTransfer initiateFileTransferTo:jid withData:imageData file:@"fileName" passedsid:myFileTransferID];
    //
    //    if ([jid.domain isEqualToString:[self.XmppStream myJID].domain]) {
    //        [TURNSocket setProxyCandidates:[NSArray arrayWithObjects:jid.domain,@"jabber.org", nil]];
    //    } else {
    //        [TURNSocket setProxyCandidates:[NSArray arrayWithObjects:jid.domain,[self.XmppStream myJID].domain, @"jabber.org",nil]];
    //    }
    //    TURNSocket *socket = [[TURNSocket alloc]initWithStream:self.XmppStream toJID:jid];
    ////    TURNSocket *socket = [[TURNSocket alloc] initWithStream:xmppStream toJID:jid sid:myFileTransferID];
    //    // [socket setDataToSend:fileData];
    //
    //    [socket startWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    
}
//- (void)receivedImage:(NSData*)image from:(XMPPJID*)from{}

//- (void)sendToOtherDevice:(NSData *)fileData receiverJid:(NSString *)receiverJid {
//    XMPPJID *  jid = [XMPPJID jidWithUser:@"zhangkaiqiang" domain:@"jabber.zjlao.com" resource:@"fuck"];
//    if ([jid.domain isEqualToString:self.XmppStream.myJID.domain]) {
//        [TURNSocket setProxyCandidates:[NSArray arrayWithObjects:jid.domain, nil]];
//    } else {
//        [TURNSocket setProxyCandidates:[NSArray arrayWithObjects:jid.domain, self.XmppStream.myJID.domain, nil]];
//    }
//    TURNSocket *socket = [[TURNSocket alloc]initWithStream:self.XmppStream toJID:jid];
//
//    [socket setDataToSend:fileData];
//    [socket startWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//}
//
- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket{
    //    [socket writeData:photoData withTimeout:60.0f tag:0];
    //    [socket disconnectAfterWriting];
    //    XMPPSIFileTransfer * ssss = [XMPPSIFileTransfer new];
}

- (void)turnSocketDidFail:(TURNSocket *)sender{
//    LOG(@"_%@_%d_文件传输相关 fail%@",[self class] , __LINE__,sender);
    
}
//- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
//{
//    
//    //**************** Handling the file transfer task *****************//
////    NSLog(@"_%@_%d_%@",[self class], __LINE__,@"---------- Check if this IQ is for a File Transfer ----------");
//    //    NSString *myFileTransferID = YOUR_SESSION_ID_GET_FROM_XEP--0096//[xmppFileTransfer xmppFileTransferResponse:(XMPPIQ *)iq];
//    
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,iq.from);
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,iq.to);
//    NSString *myFileTransferID =  self.FileTransfer.sid;
//    
//    if ([myFileTransferID length]>0) {
//        // Get the file size
//        
//        NSXMLElement *si = [iq elementForName:@"si"];
//        NSXMLElement *file = [si elementForName:@"file"];
//        if (file) {
//            
//            //All are the attribute of file while creating section Id you need to take car for that
//            //            int  filesize = [file attributeUInt32ValueForName:@"size"];///
//            //            NSString * received_FileOwner = [iq fromStr];///
//            //            NSString * received_FileType = [si attributeStringValueForName:@"mime-type"];///
//            //            NSString * received_FileName = [file attributeStringValueForName:@"name"];///
//        }
//    }
//    if([myFileTransferID length] > 0 && [[iq type] isEqualToString:@"result"]) {
//        //  Create bytestream socket for File Transfer via XEP-0065
//        TURNSocket *turnSocket =  [[TURNSocket alloc]initWithStream:self.XmppStream toJID:[iq from]];
//        //        TURNSocket *turnSocket = [[TURNSocket alloc] initWithStream:self.XmppStream toJID:[iq from] fileTransferSID:myFileTransferID];
//        //        [turnSockets addObject:turnSocket];
//        [turnSocket startWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    else if([myFileTransferID length] > 0 && [[iq type] isEqualToString:@"set"]) {
//        
//        if ([TURNSocket isNewStartTURNRequest:iq]) {
//            NSLog(@"TURN Connectio started:: to establish:: incoming file transfer request..");
//            TURNSocket *turnSocket =  [[TURNSocket alloc]initWithStream:self.XmppStream incomingTURNRequest:iq];
//            //            TURNSocket *turnSocket = [[TURNSocket alloc]initWithStream:sender incomingTURNRequest:iq withSessionID:myFileTransferID];
//            [turnSocket startWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//            //            [turnSockets addObject:turnSocket];
//        }
//    }
//    return YES;
//}
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"_%@_%d_%@",[self class] , __LINE__,@"链接成功,马上开始认证");
    //账户认证
    //    NSError * error  = [NSError new];
    //    [self.XmppStream authenticateWithPassword:self.password error:nil];
    
    BOOL authenticateResult =  [self.XmppStream authenticateWithPassword:self.password error:nil];
    if (authenticateResult) {//认证成功动态执行删除聊天记录
         [self performDeleteMessageCache];
    }
//    NSLog(@"_%@_%d 认证结果%d",[self class] , __LINE__,authenticateResult);
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
    //匿名认证
    //    [self.XmppStream authenticateAnonymously:nil];
    
    //
    
    NSLog(@"连接服务器成功的方法");//
    
    
}
//连接服务器失败的方法
-(void)xmppStreamConnectDidTimeout:(XMPPStream* )sender{
    NSLog(@"连接服务器失败的方法，请检查网络是否正常");
    
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"_%d_%@",__LINE__,@"认证成功");
    //告诉我们的服务器我 是个什么状态
    XMPPPresence *presence = [XMPPPresence presence];
    [presence addChild:[DDXMLElement elementWithName:@"show" stringValue:@"chat"]];
    [presence addChild:[DDXMLElement elementWithName:@"status" stringValue:@"online"]];
    [presence addChild:[DDXMLElement elementWithName:@"nick" stringValue:@"这是nick" ] ];
    [presence addChild:[DDXMLElement elementWithName:@"nickname" stringValue:@"这是nickname" ] ];
    [presence addChild:[DDXMLElement elementWithName:@"type" stringValue:@"available" ] ];
    [self.XmppStream sendElement:presence];
    
} 

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"_%d_\n认证失败\n 失败信息 : %@",__LINE__,error);
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    NSLog(@"_%d_\n消息发送成功 \n内容 :%@",__LINE__,message.body);
}
- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence{
    
    NSLog(@"_%d_\n出席状态发送成功 \n内容 :%@",__LINE__,presence.name);
}

/**
 * These methods are called after failing to send the respective XML elements over the stream.
 * This occurs when the stream gets disconnected before the element can get sent out.
 **/
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error{
    NSLog(@"_%d_\n消息发送失败 \n内容 :%@  \n错误信息 : %@",__LINE__,message.body , error);
}
- (void)xmppStream:(XMPPStream *)sender didFailToSendPresence:(XMPPPresence *)presence error:(NSError *)error{
    NSLog(@"_%d_\n出席状态发送失败 \n内容 :%@  \n错误信息 : %@",__LINE__,presence.name , error);
}

-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
     NSLog(@"_%d_%@",__LINE__,message.type);
     NSLog(@"_%d_%d",__LINE__,message.isErrorMessage);
    
    if (message.body.length>0) {
        BOOL  soundEnable = [[NSUserDefaults standardUserDefaults] boolForKey:@"SoundEnable"];
        if (soundEnable) {
//            if (!self.player.isPlaying) {
                [self.player prepareToPlay];
                [self.player play];
//                [self.player  pause];
//            }
        }
        
        NSString * fromAccount = message.from.user;
        if ([fromAccount hasPrefix:@"z~"]) {
            fromAccount = [fromAccount stringByReplacingOccurrencesOfString:@"z~" withString:@""];
        }
        if ([fromAccount hasPrefix:@"Z~"]) {
            fromAccount = [fromAccount stringByReplacingOccurrencesOfString:@"Z~" withString:@""];
        }
//        NSString * fullMsgXML = message.description;
//        NSString * otherAccount = message.from.user;
//        NSString * myAccount = self.XmppStream.myJID.user;
//        NSString * stamp = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
//        //        NSString * localID = nil;
//        NSString * fromAccount = message.from.user;
        NSString * toAccount = message.to.user;
        if ([toAccount hasPrefix:@"z~"]) {
            toAccount = [toAccount stringByReplacingOccurrencesOfString:@"z~" withString:@""];
        }else  if ([toAccount hasPrefix:@"Z~"]) {
            toAccount = [toAccount stringByReplacingOccurrencesOfString:@"Z~" withString:@""];
        }
//        NSString * body = message.body;
//        NSString * serverID = message.elementID;
        
//        NSString * insertQuery = [NSString stringWithFormat:@"insert into message (full_message_xml, other_account ,my_account, time_stamp , body , server_id , from_account ,to_account ) values ('%@' ,'%@' ,'%@' ,'%@' ,'%@' ,'%@' ,'%@','%@')" , fullMsgXML,otherAccount,myAccount,stamp,body,serverID ,fromAccount , toAccount];
        
        //        NSString * insertQuery = [NSString stringWithFormat:@"insert into message (full_message_xml, other_account ,my_account, time_stamp , body , server_id , from_account ,to_account ) values ('%@' ,'%@' ,'%@' ,'%@' ,'%@' ,'%@' ,'%@','%@')" , fullMsgXML,otherAccount,myAccount,stamp,body,serverID ,fromAccount , toAccount];, 发消息的时候fromAccount 写自己的用户名
        //        [self.dbMgr executeQueryWithSQLStr:insertQuery dbQueue:self.dbMgr.xmppQueue];
        [[GDStorgeManager share] insertMessageToDatabaseWithMessage:message isMax:@"max" from:message.from.user to:message.to.user callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr) {
            if (resultCode == 0) {
//                GDlog(@"对方消息插入失败:%@",resultStr)
            }else{
//                GDlog(@"对方消息插入成功:%@",resultStr)
            }
        }];
//        GDMessage *  gdmessage = [[GDMessage alloc]init];
//        gdmessage.fromAccount = fromAccount;
//        gdmessage.toAccount = toAccount;
//        gdmessage.body = message.body;
//        NSArray * elementArrTemp =  [message  elementsForName:@"archived"]  ;
//        NSString *  serverIDForSave = @"0";
//        
//        for (DDXMLElement * element in elementArrTemp){
//            //                DDXMLElement
//            NSString *   serverIDOption =  [element  attributeStringValueForName:@"id"];//element.attributeStringValue(forName: "id")
//            serverIDForSave = serverIDOption;
//        }
//        gdmessage.serverID = serverIDForSave;
//        [[GDStorgeManager share] saveRecentContactWithMessage:gdmessage callBack:^(NSInteger resultCode, NSString * _Nonnull resultStr) {
//        }];
        
    
        
        
        NSLog(@"******************%@*************",message.body);

        [[NSNotificationCenter defaultCenter] postNotificationName:@"MESSAGECOUNTCHANGED" object:nil];

        [[NSNotificationCenter defaultCenter] postNotificationName:fromAccount object:nil];
        //设置参数
        //    [not setAlertTitle:message.body];
        
#pragma mark 本地通知的时候需要使用body
        

    }else{
        
    }
    
}

/** 登录成功后返回自己的出席状态 */
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
//    LOG(@"_%@_%d_自己的昵称%@",[self class] , __LINE__,presence.nick);
//    LOG(@"_%@_%d_自己的登录状态%@",[self class] , __LINE__,presence.status);
//    LOG(@"_%@_%d_自己的显示状态%@",[self class] , __LINE__,presence.show);
//    LOG(@"_%@_%d_自己的出席类型%@",[self class] , __LINE__,presence.type);
    
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"_%@_%d_链接断开  , 断开的原因是  :  %@",[self class] , __LINE__,error);
    if ([Account shareAccount].isLogin && self.isNeedReconnect  /*&&NetWorkingStatus >0*/) {
         [self loginWithJID:self.myJid passWord:self.password];
    }
}

/**
 * This method is only used in P2P mode when the connectTo:withAddress: method was used.
 *
 * It allows the delegate to read the <stream:features/> element if/when they arrive.
 * Recall that the XEP specifies that <stream:features/> SHOULD be sent.
 **/
- (void)xmppStream:(XMPPStream *)sender didReceiveP2PFeatures:(NSXMLElement *)streamFeatures{
    NSLog(@"_%@_%d_未知方法  收到的信息是streamFeatures-> : %@",[self class] , __LINE__,streamFeatures);
    
}


- (void)xmppStream:(XMPPStream *)sender didSendCustomElement:(NSXMLElement *)element{
    NSLog(@"_%@_%d_发送自定义xml标签的代理%@",[self class] , __LINE__,element);
    
}
- (void)xmppStream:(XMPPStream *)sender didReceiveCustomElement:(NSXMLElement *)element{
    NSLog(@"_%@_%d_接收自定义xml标签的代理%@",[self class] , __LINE__,element);
    
}


//MARK:关于断开连接的代理方法
- (void)xmppStreamWasToldToDisconnect:(XMPPStream *)sender{
    NSLog(@"_%d_%@",__LINE__,@"被断开连接了");
}

/**
 * This method is called after the stream has sent the closing </stream:stream> stanza.
 * This signifies a "clean" disconnect.
 *
 * Note: A disconnect may be either "clean" or "dirty".
 * A "clean" disconnect is when the stream sends the closing </stream:stream> stanza before disconnecting.
 * A "dirty" disconnect is when the stream simply closes its TCP socket.
 * In most cases it makes no difference how the disconnect occurs,
 * but there are a few contexts in which the difference has various protocol implications.
 **/
- (void)xmppStreamDidSendClosingStreamStanza:(XMPPStream *)sender{
    NSLog(@"_%d_%@",__LINE__,@"被断开连接了");
}


- (void)xmppStream:(XMPPStream *)sender didReceiveError:(NSXMLElement *)error{
    NSLog(@"🍣接收到了错误信息_%d_%@",__LINE__,error);
    DDXMLNode * errorNode = (DDXMLNode*)error;
    for (DDXMLNode * node  in errorNode.children) {
        if ([node.name isEqualToString:@"conflict"]) {
            self.isNeedReconnect = NO ;
            
                
                [self performLoginOutByRemote];
            
             NSLog(@"_%d_%@",__LINE__,@"掉线拉");
//            UIAlertController * vc = [UIAlertController alertControllerWithTitle:@"警告" message:@"账户在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
//            GDAlertView
            [self xmppLoginout];
        }
    }
    
}


-(void)performLoginOutByRemote{
    if ([Account shareAccount].isLogin) {
        [[NetworkManager shareManager] loginOut:^(OriginalNetDataModel * data) {
            UIAlertController * vc = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LoginVC * loginvc = [[LoginVC alloc] init];
                UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:loginvc];
                navi.navigationBar.hidden = YES ;
                [KeyVC.share presentViewController:navi animated:YES completion:^{
                    
                }];
                
            }];
            [vc addAction:action];
            [[KeyVC share] presentViewController:vc animated:YES completion:^{ }];
//            [GDAlertView alert:@"用户在其他设备登录" image:nil  time:3 complateBlock:^{
//                LoginVC * loginvc = [[LoginVC alloc] init];
//                UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:loginvc];
//                navi.navigationBar.hidden = YES ;
//                [KeyVC.share presentViewController:navi animated:YES completion:^{
//                    
//                }];
//            }];
        } failure:^(NSError * error) {
            UIAlertController * vc = [UIAlertController alertControllerWithTitle:@"警告" message:@"用户在其他设备登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LoginVC * loginvc = [[LoginVC alloc] init];
                UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:loginvc];
                navi.navigationBar.hidden = YES ;
                [KeyVC.share presentViewController:navi animated:YES completion:^{
                    
                }];

            }];
            [vc addAction:action];
            [[KeyVC share] presentViewController:vc animated:YES completion:^{ }];
//            [GDAlertView alert:@"用户在其他设备登录" image:nil  time:3 complateBlock:^{
//                LoginVC * loginvc = [[LoginVC alloc] init];
//                UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:loginvc];
//                navi.navigationBar.hidden = YES ;
//                [KeyVC.share presentViewController:navi animated:YES completion:^{
//                    
//                }];
//            }];
        }];
    }else{
        [GDAlertView alert:@"未登录" image:nil time:3 complateBlock:nil];
    }


}


//func performLoginOut() {
//    mylog("退出登录")
//    if Account.shareAccount.isLogin {
//        NetworkManager.shareManager.loginOut({ (result) in
//            mylog(result.description)
//            
//            GDAlertView.alert("退出成功", image: nil, time: 2, complateBlock: {
//                //                     _ = self.navigationController?.popViewController(animated: true)
//                let loginVC = LoginVC(vcType: VCType.withoutBackButton)
//                //                    loginVC.loginDelegate = self
//                let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
//                loginNaviVC.navigationBar.isHidden = true
//                self.present(loginNaviVC, animated: true, completion: nil)
//            })
//            
//        }) { (error) in
//            
//            GDAlertView.alert("退出成功", image: nil, time: 2, complateBlock: {
//                //                    _ = self.navigationController?.popViewController(animated: true)
//                let loginVC = LoginVC(vcType: VCType.withBackButton)
//                //                    loginVC.loginDelegate = self
//                let loginNaviVC = UINavigationController.init(rootViewController: loginVC)
//                loginNaviVC.navigationBar.isHidden = true
//                self.present(loginNaviVC, animated: true, completion: nil)
//                
//            })
//            
//            mylog(error)
//        }
//    }else{
//        GDAlertView.alert("未 登 录", image: nil, time: 2, complateBlock: nil)
//    }
//    
//}

//MARK: 文件传入代理方法

/**
 * Implement this method to receive notifications of a failed incoming file
 * transfer.
 *
 * @param sender XMPPIncomingFileTransfer object invoking this delegate method.
 * @param error NSError containing more details of the failure.
 */
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender
                didFailWithError:(NSError *)error{
     NSLog(@"_%d_文件接收失败%@",__LINE__,error);
}

/**
 * Implement this method to receive notification of an incoming Stream
 * Initiation offer. Keep in mind that if you haven't set
 * autoAcceptFileTransfers to YES, then it will be your responsibility to call
 * acceptSIOffer: using the sender and offer provided to you.
 *
 * @param sender XMPPIncomingFileTransfer object invoking this delegate method.
 * @param offer IQ stanza containing a Stream Initiation offer.
 */
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender
               didReceiveSIOffer:(XMPPIQ *)offer{
    
    [self.fileInTransfer acceptSIOffer:offer];
     NSLog(@"_%d_手动打印xmppIncomingFileTransfer:didReceiveSIOffer%@",__LINE__,offer);
}

/**
 * Implement this method to receive notifications of a successful incoming file
 * transfer. It will only be invoked if all of the data is received
 * successfully.
 *
 * @param sender XMPPIncomingFileTransfer object invoking this delegate method.
 * @param data NSData for you to handle (probably save this or display it).
 * @param named Name of the file you just received.
 */
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender
              didSucceedWithData:(NSData *)data
                           named:(NSString *)name{
    
//    XMPPJID *jid = [sender.senderJID copy];
//    NSLog(@"%s",__FUNCTION__);
//    //在这个方法里面，我们通过带外来传输的文件
//    //因此我们的消息同步器，不会帮我们自动生成Message,因此我们需要手动存储message
//    //根据文件后缀名，判断文件我们是否能够处理，如果不能处理则直接显示。
//    //图片 音频 （.wav,.mp3,.mp4)
//    NSString *extension = [name pathExtension];
//    if (![@"wav" isEqualToString:extension]) {
//        return;
//    }
//    //创建一个XMPPMessage对象,message必须要有from
//    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:jid];
//    //<span class="s1" style="font-family: 'Comic Sans MS';">给</span><span class="s2" style="font-family: 'Comic Sans MS';">Message</span><span class="s1" style="font-family: 'Comic Sans MS';">添加</span><span class="s2" style="font-family: 'Comic Sans MS';">from</span>
//    [message addAttributeWithName:@"from" stringValue:sender.senderJID.bare];
//    [message addSubject:@"audio"];
//    
//    //保存data
//    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    path = [path stringByAppendingPathComponent:[XMPPStream generateUUID]];
//    path = [path stringByAppendingPathExtension:@"wav"];
//    [data writeToFile:path atomically:YES];
//    
//    [message addBody:path.lastPathComponent];
////     [self.xmppMessageArchivingCoreDataStorage archiveMessage:message outgoing:NO xmppStream:self.xmppStream]; 
//    [self.XmppMessageArchiving.xmppMessageArchivingStorage archiveMessage:message outgoing:NO xmppStream:self.XmppStream];
     NSLog(@"_%d_文件传输成功文件名是%@ ,%@",__LINE__,name,data);
}
//MARK: 文件传出代理方法


/**
 * Implement this method when calling startFileTransfer: or sendData:(variants).
 * It will be invoked if the file transfer fails to execute properly. More
 * information will be given in the error.
 *
 * @param sender XMPPOutgoingFileTransfer object invoking this delegate method.
 * @param error NSError containing more details of the failure.
 */
- (void)xmppOutgoingFileTransfer:(XMPPOutgoingFileTransfer *)sender
                didFailWithError:(NSError *)error{
     NSLog(@"_%d_%@",__LINE__,@"文件发送失败");
}

/**
 * Implement this method when calling startFileTransfer: or sendData:(variants).
 * It will be invoked if the outgoing file transfer was completed successfully.
 *
 * @param sender XMPPOutgoingFileTransfer object invoking this delegate method.
 */
- (void)xmppOutgoingFileTransferDidSucceed:(XMPPOutgoingFileTransfer *)sender{
     NSLog(@"_%d_%@",__LINE__,@"文件发送成功");
}

/**
 * Not really sure why you would want this information, but hey, when I get
 * information, I'm happy to share.
 */
- (void)xmppOutgoingFileTransferIBBClosed:(XMPPOutgoingFileTransfer *)sender{
    NSLog(@"_%d_%@",__LINE__,@"手动打印Not really sure why you would want this information, but hey, when I get information, I\'m happy to share.");
}
-(void)xmppLoginout{
    /** 有网状态下删除服务器的token达到退出 */

//        [[NSNotificationCenter defaultCenter] postNotificationName:LOGINOUTSUCCESS object:nil];
        [[GDXmppStreamManager ShareXMPPManager].XmppStream disconnectAfterSending];
//        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    
//            [self performDeleteMessageCache];
//        });


}

//////


-(void)performDeleteMessageCache//动态删除聊天记录 , 如果本次与上次账户相同 , 则return , 否则就执行删除
{
    NSString * lastUser = [[NSUserDefaults standardUserDefaults]  objectForKey:@"IMUser"];
     NSLog(@"_%d_%@",__LINE__,lastUser);
     NSLog(@"_%d_%@",__LINE__,Account.shareAccount.name);
    if ([lastUser isEqualToString:Account.shareAccount.name]) {
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setObject:Account.shareAccount.name forKey:@"IMUser"];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [NSFetchedResultsController deleteCacheWithName:@"Recently"];
        [self.contactFetchedresultsController performFetch:nil];
        NSArray * arr  =  self.contactFetchedresultsController.fetchedObjects;
        for (XMPPMessageArchiving_Contact_CoreDataObject *contact  in arr) {
            [self clearMessageHistoryWithContact:contact];
            
            [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deleteObject:contact];
        }
        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];
        
    });
    
    
    
    
    
}

-(NSFetchedResultsController *)contactFetchedresultsController
{
    if (_contactFetchedresultsController == nil) {
        //查询请求
        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
        //实体描述
        
        NSEntityDescription *entitys =  [NSEntityDescription entityForName:@"XMPPMessageArchiving_Contact_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
        
        fetchrequest.entity = entitys;
        
#pragma mark 查询请求控制器需要一个排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mostRecentMessageTimestamp" ascending:YES];
        fetchrequest.sortDescriptors = @[sort];
        
        //创建懒加载对象(查询请求控制器)
        _contactFetchedresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Recently"];
        
        //        _fetchedresultsController.delegate = self;
    }
    return _contactFetchedresultsController;
}



-(void)clearMessageHistoryWithContact:(XMPPMessageArchiving_Contact_CoreDataObject*)contact
{
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
    //        [fetchrequest setFetchLimit:20];
    //从游离态中获取实体描述
    NSEntityDescription *entitys = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
    //设置实体描述
    fetchrequest.entity = entitys;
    
    
    //设置谓词(条件筛选)
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",contact.bareJid.bare];
    fetchrequest.predicate = pre;
    //
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    fetchrequest.sortDescriptors = @[sort];
    
    NSFetchedResultsController* messageFetchedresultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Message"];
    
    
    
    /////
    //执行查询控制器
    [NSFetchedResultsController deleteCacheWithName:@"Message"];
    
    /** 原来(始) */
    [messageFetchedresultsController performFetch:nil];
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"先执行");
    NSArray * messages = messageFetchedresultsController.fetchedObjects;
    for (XMPPMessageArchiving_Message_CoreDataObject * message in messages) {
        [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext deleteObject:message];
    }
    [[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext save:nil];
    
    
}



@end
