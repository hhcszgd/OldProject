//
//  Tool.h
//  jzg
//
//  Created by apple on 13-9-27.
//  Copyright (c) 2013年 bzwzdsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject {
    
}
+ (long long)getPK;
+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
+ (CGRect)screenRect;
+ (NSString *)getImagePath:(NSString *)fileName;
+ (NSString *)getMD5:(NSString *)str;
+ (UIImage*)grayscale:(UIImage*)anImage type:(char)type;
@end
