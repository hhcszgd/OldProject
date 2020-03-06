//
//  SystemConfig.h
//  IOSCim
//
//  Created by apple apple on 11-6-16.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.h"

@interface SystemConfig : NSObject {

}

+ (void)init;
+ (void)setLoginStatus;
+ (BOOL)getLoginStatus;
+ (void)setAutoLogin;
+ (BOOL)getAutoLogin;
+ (void)setRememberPassword;
+ (void)setRememberPasswordByBOOL:(BOOL)isRemeber;
+ (BOOL)isRememberParssword;
+ (void)setSoundRemind;
+ (BOOL)isSoundRemind;
+ (BOOL)isShockMode;
+ (void)setShockMode;
+ (BOOL)isReceiveGroupMessage;
+ (void)setReceiveGroupMessage;
+ (BOOL)isGuestOnline;
+ (void)setGuestOnline;

+ (void)addLoginUser:(NSString*)loginId password:(NSString*)password;
//获取记忆的登录帐号信息
+ (NSMutableDictionary*)getMemberedLoginData;
+ (NSMutableDictionary*)getLassLoginData;
//删除登录多的用户信息
+ (void)deleteLoginUser:(NSString*)loginId;
+ (BOOL)isRecvGroupMessage:(NSString*)groupId;
+ (void)setRecvGroupMessageSwitch:(NSString*)groupId ;
+ (NSArray*)getLoginIds;
@end
