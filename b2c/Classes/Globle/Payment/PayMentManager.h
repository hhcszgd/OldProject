//
//  PayMentManager.h
//  b2c
//
//  Created by wangyuanfei on 16/5/27.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol PayMentManagerDelegate <NSObject>
/**返回支付结果后调用的相应的代理方法*/
- (void)payEndWithPayStatus:(BaseResp *)resp;
/**避免重复点击*/
- (void)notWantUserClickBtnFrequency:(BOOL)bl;




@end


typedef enum : NSUInteger {
    WeiChatPay,
    AliPay,
    UnionPay
} PayMentType;

@interface PayMentManager : NSObject<WXApiDelegate>
@property(nonatomic,copy)  void(^myCallBack)(id paramete)  ;
/**单例*/
+ (instancetype)sharManager;
-(void)payWithParemete:(id)patamete payMentType:(PayMentType)payMentType ;
-(void)testWithParamete:(NSString*)paramete ;
/**支付的代理*/
@property (nonatomic, weak) id<PayMentManagerDelegate>delegate;
@end
