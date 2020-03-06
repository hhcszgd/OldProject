//
//  Tool.m
//  jzg
//
//  Created by apple on 13-9-27.
//  Copyright (c) 2013年 bzwzdsoft. All rights reserved.
//

#import "Tool.h"

#define DEFAULT_VOID_COLOR [UIColor whiteColor]
@implementation Tool
static long long pk = 0;
+(id) init {
    pk = [[NSDate date] timeIntervalSince1970]*1000;
    return self;
}
+(long long) getPK {
    if (pk ==0) {
         pk = [[NSDate date] timeIntervalSince1970];
    }
    pk ++;
    return pk;
}
//字符串转颜色
+(UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
//获取屏幕大小
+ (CGRect)screenRect {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    screenRect.size.height += screenRect.origin.y;
    screenRect.origin.y = 0;
    screenRect.origin.x = 0;
    return screenRect;
}
+ (NSString *)getImagePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *voiceDirectory = [[documentsDirectory stringByAppendingPathComponent:@"userImage"] stringByAppendingPathComponent:@"image"];
    if ( ! [[NSFileManager defaultManager] fileExistsAtPath:voiceDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:voiceDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return [voiceDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
}
+ (NSString *)getMD5:(NSString *)str {
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
//    CC_MD5( cStr, strlen(cStr), result );
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}
//图片灰度反色处理 type 1:灰度 2:深棕色 3:反色
+ (UIImage*)grayscale:(UIImage*)anImage type:(char)type {
    @try {
        CGImageRef  imageRef;
        imageRef = anImage.CGImage;
        
        size_t width  = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
        
        // 获取构成像素的RGB各个要素使用多少bits构成的
        size_t                  bitsPerComponent;
        bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
        
        // 获取全部像素是由多少bits构成的
        size_t                  bitsPerPixel;
        bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
        
        // 图片一横线的数据由多少byte构成的
        size_t                  bytesPerRow;
        bytesPerRow = CGImageGetBytesPerRow(imageRef);
        
        // 图像的色域
        CGColorSpaceRef         colorSpace;
        colorSpace = CGImageGetColorSpace(imageRef);
        
        // 图片的bitmap信息
        CGBitmapInfo            bitmapInfo;
        bitmapInfo = CGImageGetBitmapInfo(imageRef);
        
        // 图片中像素间隔是否补完
        bool                    shouldInterpolate;
        shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
        
        // 是否接受了来自显示器的补正
        CGColorRenderingIntent  intent;
        intent = CGImageGetRenderingIntent(imageRef);
        
        // 获取图片的dataProvider
        CGDataProviderRef   dataProvider;
        dataProvider = CGImageGetDataProvider(imageRef);
        
        //  通过dataProvider获取图片的bitmap原数据
        CFDataRef   data;
        UInt8*      buffer;
        data = CGDataProviderCopyData(dataProvider);
        buffer = (UInt8*)CFDataGetBytePtr(data);
        
        // 一像素一像素的处理图片
        NSUInteger  x, y;
        for (y = 0; y < height; y++) {
            for (x = 0; x < width; x++) {
                UInt8*  tmp;
                tmp = buffer + y * bytesPerRow + x * 4; // 由于有RGBA4个值所以每一像素之间有*4的偏移 RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
                
                // RGB値を取得
                UInt8 red,green,blue;
                red = *(tmp + 0);
                green = *(tmp + 1);
                blue = *(tmp + 2);
                
                UInt8 brightness;
                
                switch (type) {
                    case 1://灰度
                        // 輝度計算
                        brightness = (77 * red + 28 * green + 151 * blue) / 256;
                        *(tmp + 0) = brightness;
                        *(tmp + 1) = brightness;
                        *(tmp + 2) = brightness;
                        break;
                        
                    case 2://深棕色
                        *(tmp + 0) = red;
                        *(tmp + 1) = green * 0.7;
                        *(tmp + 2) = blue * 0.4;
                        break;
                        
                    case 3://反色
                        *(tmp + 0) = 255 - red;
                        *(tmp + 1) = 255 - green;
                        *(tmp + 2) = 255 - blue;
                        break;
                        
                    default:
                        *(tmp + 0) = red;
                        *(tmp + 1) = green;
                        *(tmp + 2) = blue;
                        break;
                }
                
            }
        }
        
        // 生成赋予了效果的数据
        CFDataRef   effectedData;
        effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
        
        // 生成赋予了效果的dataProvider
        CGDataProviderRef   effectedDataProvider;
        effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
        
        // 生成图片
        CGImageRef  effectedCgImage;
        UIImage*    effectedImage;
        effectedCgImage = CGImageCreate(
                                        width, height,
                                        bitsPerComponent, bitsPerPixel, bytesPerRow,
                                        colorSpace, bitmapInfo, effectedDataProvider,
                                        NULL, shouldInterpolate, intent);
        effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
        
        // 释放图片
        CGImageRelease(effectedCgImage);
        CFRelease(effectedDataProvider);
        CFRelease(effectedData);
        CFRelease(data);
        
        return effectedImage;
    }
    @catch (NSException *exception) {
        return anImage;
    }
}
@end
