//
//  ResponseObject.m
//  TTmall
//
//  Created by wangyuanfei on 3/13/16.
//  Copyright © 2016 Footway tech. All rights reserved.
//

#import "ResponseObject.h"

//#import "b2c-Swift.h"
//#import "GDNetworkManager.swift"

@implementation ResponseObject

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {

        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

-(void)save {
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"homeData.data"];
//    [NSKeyedArchiver setClassName:@"ResponseObject" forClass:[ResponseObject class]];
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}
+(instancetype )read{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"homeData.data"];
    
//    [NSKeyedUnarchiver setClass:[ResponseObject class] forClassName:@"ResponseObject"];

    ResponseObject * homeDataObj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return homeDataObj ;
}


+ (NSArray *)mj_allowedCodingPropertyNames{
    return @[@"status",@"msg",@"data", @"modify_time"] ;
    
}

#pragma NSCoping
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [self mj_encode:aCoder];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        [self mj_decode:aDecoder];
        
    }
    return self;
}

@end
