//
//  HCellModel.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HCellModel.h"

@implementation HCellModel
-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key{

    if ([key isEqualToString:@"img"]) {
        self.imgStr = value;
        return;
    }
    
    
    if ([key isEqualToString:@"key"]) {
            NSString * classKey = value;
        if ([classKey containsString:@"singleads"]) {
            NSString *classKey = @"singleads";
            NSString *preficUpper = [classKey customFirstCharUpper];
            NSMutableString *mutableStr = [NSMutableString string];
            
            NSString * classNameStr = [mutableStr stringByAppendingFormat:@"H%@Cell",preficUpper];
            self.classKey = classNameStr;
            return;
            
        }
        
        if ([classKey containsString:@"bestCargo"]) {
            NSString *classKey = @"bestCargo";
            NSString *preficUpper = [classKey customFirstCharUpper];
            NSMutableString *mutableStr = [NSMutableString string];
            
            NSString * classNameStr = [mutableStr stringByAppendingFormat:@"H%@Cell",preficUpper];
            self.classKey = classNameStr;
            return;
        }
        
        
        
            NSString * prefixUpper = [classKey customFirstCharUpper];
             NSMutableString *mutableStr = [NSMutableString string];
            
            NSString * classNameStr = [mutableStr stringByAppendingFormat:@"H%@Cell",prefixUpper];

            self.classKey = classNameStr;
            
            
            return;
        }

    
    if ([key isEqualToString:@"actionkey"]) {
        
        NSString * temp =value;
        NSString * action = [temp customFirstCharUpper] ;
        NSString * classActionStr = [NSString stringWithFormat:@"H%@VC",action];//直接把对应的actionKey转换成相应的控制器类名
        self.actionKey = classActionStr;
        return;
        }
    
    
    

    [super setValue:value forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSMutableArray * )items{
    if(_items==nil){
        _items = [[NSMutableArray alloc]init];
    }
    return _items;
}
@end
