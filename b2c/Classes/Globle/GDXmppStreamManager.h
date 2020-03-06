//
//  GDXmppManager.h
//  b2c
//
//  Created by wangyuanfei on 16/6/3.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMPPFrameWork.h"
//#import "XMPPFramework.h"

//@class XMPPReconnect;
//@class XMPPAutoPing;
//@class XMPPRoster;
//@class XMPPMessageArchiving;
//@class XMPPvCardTempModule;
//@class XMPPvCardAvatarModule;

#import "XMPPvCardAvatarModule.h"
//@class XMPPvCardAvatarModule;
#import "XMPPAutoPing.h"
//@class XMPPAutoPing;
#import "XMPPRosterCoreDataStorage.h"
//@class XMPPRosterCoreDataStorage;
#import "XMPPvCardCoreDataStorage.h"
//@class XMPPvCardCoreDataStorage;
#import "XMPPRoster.h"
//@class XMPPRoster;
#import "XMPPMessageArchiving.h"
//@class XMPPMessageArchiving;
#import "XMPPMessageArchivingCoreDataStorage.h"
//@class XMPPMessageArchivingCoreDataStorage;
#import "CocoaLumberJack/DDLog.h"
//@class PodsDummy_CocoaLumberjack;
@class  XMPPSIFileTransfer;
#import "XMPPReconnect.h"
//@class XMPPReconnect;
#import "XMPPAutoTime.h"

#import "XMPPvCardTemp.h"
//@class XMPPvCardTemp;
#import "XMPPIncomingFileTransfer.h"
//@class XMPPIncomingFileTransfer;
#import "XMPPOutgoingFileTransfer.h"
//@class XMPPOutgoingFileTransfer;
#import "XMPPMessageDeliveryReceipts.h"//消息回执
//@class XMPPMessageDeliveryReceipts;

//@class XMPPReconnectDelegate;
//@class XMPPStreamDelegate;

@interface GDXmppStreamManager : NSObject
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

@property(nonatomic,strong)XMPPMessageDeliveryReceipts * msgDeliveryReceipts ;
@property(nonatomic,strong)XMPPAutoTime * timeMoudle ;
@property(nonatomic,strong)  XMPPTime * time ;
/**是否重新登录*/
@property(nonatomic,assign)BOOL  isNeedReconnect ;
//@property(nonatomic,strong)GDStorgeManager * dbMgr ;

+ (instancetype)ShareXMPPManager;

//登录的方法
- (void)loginWithJID:(XMPPJID *)jid passWord:(NSString *)password;
/** xmpp自带发送图片 */
- (void)sendImageMessage:(NSData *)imageData toAccount:(NSString *)account;
/** 自定义发送图片 */
- (void)sendImgData:(UIImage *)image toAccount:(NSString *)account;
/**自定义处理接收图片的方法(走自己的图片接口) , 只需要传个消息对象就行了*/
- (UIImage *)reciveImgWithMessage:(XMPPMessage *)incomingMessage;
@property (nonatomic ,copy)NSString *password;
-(void)xmppLoginout;

//@property(nonatomic,strong)XMPPJID * myjid;

@end
