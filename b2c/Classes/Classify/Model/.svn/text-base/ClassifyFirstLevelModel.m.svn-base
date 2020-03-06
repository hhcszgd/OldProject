//
//  ClassifyFirstLevelModel.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ClassifyFirstLevelModel.h"

@implementation ClassifyFirstLevelModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}


+ (NSDictionary *)objectClassInArray{
    return @{
             @"classone":@"ClassifyFirstLevelModel"
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"归档")
    [aCoder encodeObject:self.channel forKey:@"channel"];
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.classone forKey:@"classone"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.classify_name forKey:@"classify_name"];
    [aCoder encodeObject:self.actionkey forKey:@"actionkey"];

}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.channel = [aDecoder decodeObjectForKey:@"channel"];
        self.key = [aDecoder decodeObjectForKey:@"key"];
        self.classone = [aDecoder decodeObjectForKey:@"ID"];
        self.classify_name = [aDecoder decodeObjectForKey:@"classify_name"];
        self.actionkey = [aDecoder decodeObjectForKey:@"actionkey"];
    }
    return self;
}


@end
