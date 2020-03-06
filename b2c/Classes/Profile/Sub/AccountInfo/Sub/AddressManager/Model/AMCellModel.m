//
//  AMCellModel.m
//  TTmall
//
//  Created by wangyuanfei on 3/3/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "AMCellModel.h"

@implementation AMCellModel
-(instancetype)initWithdictionary:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(NSString *)totalAddress{
    return [NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.area,self.address];
}


-(void)setValue:(id)value forKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        return;
    }
    if ([key isEqualToString:@"default"]) {
        self.isDefaultAddress = [value boolValue];
        return;
    }
    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
-(id)copyWithZone:(NSZone *)zone{
    AMCellModel * model = [[AMCellModel alloc]init];
    model.province = self.province;
    model.city = self.city;
    model.country = self.country;
    model.mobile = self.mobile;
    model.id_number = self.id_number;
    model.area_id = self.area_id;
    model.area = self.area;
    model.ID = self.ID;
    model.username = self.username;
    model.telephone = self.telephone;
    model.address = self.address;
    model.isDefaultAddress = self.isDefaultAddress;
    model.methodType = self.methodType;
    return model;
}
@end
