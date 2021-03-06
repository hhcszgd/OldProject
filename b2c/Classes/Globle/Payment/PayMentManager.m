//
//  PayMentManager.m
//  b2c
//
//  Created by wangyuanfei on 16/5/27.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "PayMentManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
//微信支付
#import "WXApiObject.h"
#import "WXApi.h"



#import "COrderGoodSubModel.h"

@implementation PayMentManager
+ (instancetype)sharManager{
    static dispatch_once_t onceToken;
    static PayMentManager *payManager;
    dispatch_once(&onceToken, ^{
        payManager =[[PayMentManager alloc] init];
    });
    return payManager;
}



-(void)payWithParemete:(id)patamete payMentType:(PayMentType)payMentType {
    LOG(@"_%@_%d_%@",[self class] , __LINE__,patamete);
    if (payMentType==AliPay) {
        [self performAliPayWithParamete:patamete ];
    }else if (payMentType==WeiChatPay){
        [self performWeiChatPayWithParamete:patamete ];
    }else if (payMentType==UnionPay){
        [self performUnionPayWithParamete:patamete ];
    }
    
    
    
}
/** 银联 */
-(void)performUnionPayWithParamete:(id )paramete{

}

/** 微信 */
-(void)performWeiChatPayWithParamete:(id )paramete{
    
    NSDictionary *parametes = paramete;
    NSLog(@"%@, %d ,%@",[self class],__LINE__,parametes);

    [self jumpToBizPayWith:parametes];

    
}
-(void)jumpToBizPayWith:(NSDictionary *)paramete{
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    
    //============================================================

    //判断是否安装微信客户端
    if ([WXApi isWXAppInstalled]) {
        //后台给出的接口。
//        https://api.mch.weixin.qq.com/pay/unifiedorder
        //调用统一下单接口。
        if ([self.delegate respondsToSelector:@selector(notWantUserClickBtnFrequency:)]) {
            [self.delegate notWantUserClickBtnFrequency:NO];
        }
        [[UserInfo shareUserInfo] gotWeiXinUniformOrderWithorder_code:paramete[@"orderID"] Success:^(ResponseObject *responseObject) {
            NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);
            if ([self.delegate respondsToSelector:@selector(notWantUserClickBtnFrequency:)]) {
                [self.delegate notWantUserClickBtnFrequency:YES];
            }
            NSDictionary *dict = responseObject.data;
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                
                //调起微信支付appid,prepayid,partnerid,timestamp,noncestr,package签名
                
                NSMutableString *stamp  = [dict objectForKey:@"timeStamp"];
//                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerId"];
                req.prepayId            = [dict objectForKey:@"prepayId"];
                req.nonceStr            = [dict objectForKey:@"nonceStr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                
            }
            
        } failure:^(NSError *error) {
            if ([self.delegate respondsToSelector:@selector(notWantUserClickBtnFrequency:)]) {
                [self.delegate notWantUserClickBtnFrequency:YES];
            }
//             NSLog(@"_%d_%@",__LINE__,error);
            AlertInSubview(@"支付失败，请重新支付")
        }];
               
    }else{
        AlertInSubview(@"您还没有安装微信")
    }
    
    
    
    
   
}
/**调用统一下单接口*/





/**微信支付回调方法delegate*/
- (void)onResp:(BaseResp *)resp{
    //支付返回的结果
    if ([self.delegate respondsToSelector:@selector(payEndWithPayStatus:)]) {
        [self.delegate performSelector:@selector(payEndWithPayStatus:) withObject:resp];
    }
    
}

-(void)localRSAWithParamete:(id )paramete
{
    NSDictionary * parametes = paramete[@"paramete"];
    
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,parametes);
    //    self.orderID = parametes[@"orderID"];
    //    self.price = ;
    //    self.goodses = parametes[@"goodses"];
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    
//  NSString *partner = @"2088221549550551";////旧id
    NSString *partner = @"2088421981841668";//////正式
    
//  NSString *seller = @"58090191@16lao.com";////旧账户
    NSString *seller = @"tousu@zjlao.com";////正式

//        NSString*privateKey=@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANUMvlxQQw0PaF3cmHu6Oe9IdBzlkmMeKLzQoVSBbzsYPJO4jfSmZUrlxfDmdJLsQHU1bIQ1nHQ2EEmhnhFlVbcgapoT/kQ42LCvjx3/5kyxWKGSGLY6VsnL9N9zbw2s7Xpm707F9no3KtI6cmCSNb6Lf2Nn1pSOm4uj+JIPPHj1AgMBAAECgYEAxxm3tJGVd9kUUdNb9RTeG458ZJzupw6CR6I5gr3Lc1B9HBf3IdF3C/2bdDwKaVu8CU058nwfkEMOCaGuFNe8t0crrhoILPjolAKEIyIsrMH5z2620FY6Xr9kKI/Wyx5Zr415wDRNdoC+cRDhf4ZfmCnl0CIoh1XKpDPteU8bSikCQQD7sltRKouc2H7kQ4JQOkUKcH0ZxNhncijbYl9o/lkYsPzqYL+6q8mEoV0UFLTMzcy0OOObxAouP1Ly79AmNsmfAkEA2LE8AOe9DV5yVcPqG4evrgkIOGZUKOdEKhmiqI8SgRKKnWWUqWApuozLP+LDuOdPsHpc4xWAgrXhK9Cd4Jwc6wJASIk7JeYT/CysTQ5jlMlmMj7+3plLIGzW93qfMnvyo1oGWWlud9agKdfzIiFhhZBdySaH+dECeheHyTlxjEHH0wJAHIjKM/xQItCLEcwoqdNmSO6bjIG9F13M1hZmGvgsIZ8FbdCQkPU+yXf8077SsyiSj9StIqIUOCInMpPYFlm4XQJAGA3La0KFZ4EsnjHXCBHTvjTRC6HNEPt3m6AIWkzhXmqIyBJZ9IQlppbQDdAcwatZja6+my4VSuZzbGYexP21Wg==";////旧私钥
    NSString*privateKey=@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKkUsh3FOnrbZVcxtdK/WSLutCQVCmTHKV4pThbSoz5YeCXSSA2xwDk9k8SMe3Tm12KCgTRwPJB7oAV7o5yhPwvto22GZNmq5PwKQPgVxAco8bZz0HWMOqdJfUS8+sui7aRAL4OeAhyZhZIO9FvJPqvODJevsVmEJrZsTHGuX19JAgMBAAECgYBh4+iHkeOcs58Fj3M8c6owrlC/PytIU4Jg0Ls0PXljpCbTht5Oh2XJ/huqRMdJVEjI8NPLP1vhLqHj6sQ776Mm3CmQLPlA8OZRnQIjVJqq+934sh+bKOVRhxyhYgCnOkKw/otyocFdCqjIIohctRsp4VJAQ3Ez6B92GwIwKU+WHQJBAODY6bgiXVYBIDcVPi5+YuyrNAanRJM5nttg88NrskHm5gzqNMyNzm0TXG1Z5ynPBGkhlUtkwg6IYnvbCtDwXTsCQQDAgc6sUdC6c0n1yM6Cp5OUkQTmBiHV+jIFsYyNkR1ryBNRgDpYtfDxpcVrn9FZkn0RNtyLHH83JVb+ECgdZz1LAkBcAUZ5u04YADPvdjjQi5TtJQ0P3+gWmlBfkmeMwofZoaLnC/r47NnYFkEO2efWWsiCQGS3yg4CJlquNa5SWti7AkEAoBlUsKs6VFYdZHOki7SiYCRbVpIzAaoaf/GxWusc9M5ogpeJ7s0hnVaoYWGA0mWp7e8aa/c/NbWwK4t0UT/TEQJAUFqt8Wx6yeX+UCoJIn7GFV7kE3A2vPTmCrLj9RxRy20T+TGUytQMb0qrBX3bQ4b5/yBm15TTLXMVtR5i0wpnBA==";////正式
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = parametes[@"orderID"]; //订单ID（由商家自行制定）
    NSString * titleStr = [[NSString alloc]init];
    NSString * descripStr = [[NSString alloc]init];
    for (int i = 0; i < [parametes[@"goodses"] count]; i++) {
        id sub = parametes[@"goodses"][i];
        if ([sub isKindOfClass:[COrderGoodSubModel class]]) {
            COrderGoodSubModel * goodsModel = (COrderGoodSubModel*)sub ;
            titleStr=[titleStr stringByAppendingString:goodsModel.short_name];
            descripStr=[descripStr stringByAppendingString:goodsModel.short_name];
        }
    }
    order.subject = titleStr; //商品标题
    order.body = descripStr; //商品描述
    //    order.totalFee = [NSString stringWithFormat:@"%.2f",[parametes[@"price"] floatValue]]; //商品价格
    order.totalFee = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格 //测试期间 暂时设置很低
    
    order.notifyURL = [NSString stringWithFormat:@"%@/Pay/Returnpay/backReceive", MAINDOMAIN]; //回调URL////
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"7d";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.16lao.zjlao";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    
    //    获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    /** 本地加密开始 */
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    /** 本地加密结束 */
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @ "RSA"];
    
            LOG(@"_%@_%d_加密以后并且拼接好的\n%@",[self class] , __LINE__,orderString);
            LOG(@"_%@_%d_需要加密的字符串\n%@",[self class] , __LINE__,orderSpec);
            LOG(@"_%@_%d_本地加密后的字符串\n%@",[self class] , __LINE__,signedString);
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                NSLog(@"_%@_%d_%@",[self class] , __LINE__,resultDic);
                _myCallBack(resultDic);
            }];
        }
    
        LOG(@"_%@_%d_%@\n",[self class] , __LINE__,orderSpec);
    LOG(@"_%@_%d_%@",[self class] , __LINE__,signedString);
    //    将签名成功字符串格式化为订单字符串,请严格按照该格式

}
/** 服务器加密 */
-(void)serverRSAWithParamete:(id )paramete
{
    
    NSDictionary * parametes = paramete[@"paramete"];
    NSString * orderid  = parametes[@"orderID"];
    
    [[UserInfo shareUserInfo] encryptAlipayOrderID:orderid success:^(ResponseObject *responseObject) {
        
        LOG(@"_%@_%d_网络加密后的字符串\n%@",[self class] , __LINE__,responseObject.data);
        
        //如果数据返回成功 , 就开始拼接字符串 , 并向Alipay请求支付
        NSString * signedStr = responseObject.data;
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"com.16lao.zjlao";
        if (signedStr != nil) {
            
            [[AlipaySDK defaultService] payOrder:responseObject.data fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                NSLog(@"_%@_%d_%@",[self class] , __LINE__,resultDic);
                _myCallBack(resultDic);
            }];
            
        }
        
    } failure:^(NSError *error) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error);
        AlertInSubview(@"rsa error")
    }];

}
/** 支付宝 */
-(void)performAliPayWithParamete:(id )paramete
{
//    [self localRSAWithParamete:paramete];//本地加密
    [self serverRSAWithParamete:paramete];//服务器加密
   
}


-(void)testWithParamete:(NSString*)paramete
{
    _myCallBack(paramete);//支付结果返回给调用者
}



@end
