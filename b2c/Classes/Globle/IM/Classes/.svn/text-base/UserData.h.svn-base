//
//  UserData.h
//  IOSCim
//
//  Created by apple apple on 11-5-30.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserChatData.h"

enum UserStatusType {
	UserStatusOnline = 10,
	UserStatusBusy = 20,
	UserStatusLeave = 30,
	UserStatusStealth = 40,
	UserStatusOffline = 50
};

typedef enum UserStatusType UserStatusType;

@interface UserData : NSObject {
	NSString *userId;  //用户编号
	NSString *loginId; //登录帐号
	NSString *nickname; //用户昵称
	NSString *idiograph; //个性签名
	NSString *deptId; //企业部门编号
	NSString *kindId; //好友分组编号
	NSString *userInfo; //自我介绍
	NSString *friendVerifyType; //加好友验证方式  0 不需要 1 需要 2 拒绝任何人加他
	NSInteger status; //状态
	NSInteger oldStatus; //旧状态
	NSMutableArray *userChatLog; //聊天消息
	BOOL isUnReadMessage; //是否有未读消息
	NSInteger unReadAmount; //未读消息的数量
	NSString *guestCode; //访客编号
	NSString *lastAcessTime; //最后访问时间
	NSString *lastAcessPage; //最后访问页面
	NSString *userType; //用户类型  nil:正常/tempGuest:临时访客/tempUser:临时用户
    NSString *groupUserType;
    NSString *faceIndex;
}

@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *loginId;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *idiograph;
@property (nonatomic, retain) NSString *deptId;
@property (nonatomic, retain) NSString *kindId;
@property (nonatomic, retain) NSString *userInfo;
@property (nonatomic, retain) NSString *friendVerifyType;
@property (assign) NSInteger oldStatus;
@property (assign) BOOL isUnReadMessage;
@property (assign) NSInteger unReadAmount;
@property (nonatomic, retain) NSString *guestCode;
@property (nonatomic, retain) NSString *lastAcessTime;
@property (nonatomic, retain) NSString *lastAcessPage;
@property (nonatomic, retain) NSString *groupUserType;
@property (nonatomic, retain) NSString *faceIndex;

@property (nonatomic, retain) NSString *userType;



- (void)addMessage:(UserChatData*)chatData;
- (NSMutableArray*)getMessage;
- (NSString*)getUserName;
- (NSString*)getLoginId;
- (int)getStatus;
- (NSInteger)getUnReadAmount;
- (void)setStatus:(NSString*)userStatus;
- (BOOL)isChangeStatus;
- (void)clearMessage;
//获取用户头像
- (NSString *)getHeadImage;
- (void)clearMessage;
- (void)addImageMessage:(NSString*)imageId downloadId:(NSString*)downloadId messageType:(int)messageType;
@end
