//
//  CouponsDetailModel.m
//  b2c
//
//  Created by wangyuanfei on 16/5/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CouponsDetailModel.h"

@implementation CouponsDetailModel
-(instancetype)init{
    if (self=[super init]) {
        /** 图片链接 */
          self.img=@"http://pic32.nipic.com/20130829/12906030_124355855000_2.png" ;
        /** 优惠券额度 */
          self.discount_price = @"9.9"   ;
        /** 店铺名 */
          self.shop_name =@"卖火柴的小女孩";
        /** 满多少可用 */
          self.full_price = @"100" ;
        /** 优惠券生效时间 */
          self.start_time = @"2016.5.1" ;
        /** 优惠券失效时间 */
          self.end_time =@"2016.6.1";
        /** 已领取的人数 */
          self.number_rec =@"44" ;
        /** 剩余数量 */
          self.leftCount =@"134";
        /** 优惠券使用说明 */
        self.discription =@[
                            @"本优惠券仅限于购买碧根果" ,
                            @"每个账号只可领取一次1.不同的代金券面值、有效期和使用限制不尽相同，使用前请认真核对一个订单只能使用一张代金券.秒杀，抽奖类商品不允许使用代金券进行支付代金券作为一种优惠手段，无法获得对应的积分一个订单中的代金券部分不能退款或折现，使用代金券购买的订单发生退款后不能返还代金券代金券绑定订单且付款后，将无法退回；如取消订单，订单中所使用的代金券将无法再单金额，则需由用户支付差额；代金券不可兑现，且不开发票代金券只限于普通用户使，如发现有商户使用代金券，窝窝团有权立即取消订单并做相关处理所有代金券严禁出售或转让，如经发现并证实的，将予以作废处理。",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次",
                            @"每个账号只可领取一次"
                            ];
    }
    return self;
}





-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"start_time"]) {
        NSString * startTime =  [value stringByReplacingOccurrencesOfString:@"-" withString:@"."];
//            NSString * endTime = [self.composeModel.end_time  stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if ([startTime containsString:@"00:00:00"]) {
            startTime = [startTime stringByReplacingOccurrencesOfString:@"00:00:00" withString:@""];
        }

        self.start_time = startTime;
        return;
    }else if ([key isEqualToString:@"end_time"]){
        NSString * endTime =  [value stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        if ([endTime containsString:@"00:00:00"]) {
            endTime = [endTime stringByReplacingOccurrencesOfString:@"00:00:00" withString:@""];
        }
        self.end_time = endTime;
        return;
    }
    
    
    
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(NSString *)leftCount{
    return [NSString stringWithFormat: @"%lu",[self.number integerValue] - [self.number_rec integerValue]];

}


@end
