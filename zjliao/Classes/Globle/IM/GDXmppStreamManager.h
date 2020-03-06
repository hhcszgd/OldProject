//
//  GDXmppManager.h
//  b2c
//
//  Created by wangyuanfei on 16/6/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "XMPPFramework.h"

//@class XMPPReconnect;
//@class XMPPAutoPing;
//@class XMPPRoster;
//@class XMPPMessageArchiving;
@class XMPPvCardTempModule;
//@class XMPPvCardAvatarModule;
#import <XMPPFramework/XMPPFramework.h>
@class XMPPvCardAvatarModule;
@class XMPPAutoPing;
@class XMPPRosterCoreDataStorage;
@class XMPPvCardCoreDataStorage;
@class XMPPRoster;
@class XMPPMessageArchiving;
@class XMPPMessageArchivingCoreDataStorage;
//@class CocoaLumberJack/DDLog;
@class  XMPPSIFileTransfer;
@class XMPPReconnect;

@class XMPPvCardTemp;

@class XMPPIncomingFileTransfer;
@class XMPPOutgoingFileTransfer;

@interface GDXmppStreamManager : NSObject// <XMPPStreamDelegate,XMPPReconnectDelegate>
@property (nonatomic , strong)XMPPStream *XmppStream;

@property (nonatomic , strong)XMPPReconnect *XmppReconnect;

@property (nonatomic , strong)XMPPAutoPing *XmppAutoping;

@property (nonatomic , strong)XMPPRoster *XmppRoster;

@property (nonatomic , strong)XMPPMessageArchiving *XmppMessageArchiving;

@property (nonatomic , strong)XMPPvCardTempModule *xmppvcardtempModule;

@property (nonatomic , strong)XMPPvCardAvatarModule *xmppvcardavatarModule;

@property(nonatomic,strong)XMPPSIFileTransfer * FileTransfer ;

@property(nonatomic,strong) XMPPIncomingFileTransfer  * fileInTransfer ;

@property(nonatomic,strong) XMPPOutgoingFileTransfer  * fileOutTransfer ;
@property (nonatomic ,copy)NSString *password;

/**是否重连*/
@property(nonatomic,assign)BOOL  isNeedReconnect ;

+ (instancetype)ShareXMPPManager;

//登录的方法
- (void)loginWithJID:(XMPPJID *)jid passWord:(NSString *)password;
/** 发送图片 */
- (void)sendImageMessage:(NSData *)imageData toAccount:(NSString *)account;

-(void)xmppLoginout;
//@property(nonatomic,strong)XMPPJID * myjid;

@end
