//
//  PTableCellModel.m
//  b2c
//
//  Created by wangyuanfei on 3/30/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "PTableCellModel.h"

@implementation PTableCellModel
-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    self.title = leftTitle ; 

}
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"channel"]) {
        self.title  =  value;
        self.leftTitle = value;
        return;
    }

    
    [super setValue:value forKey:key];
}


@end
