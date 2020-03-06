//
//  AsynImageView.m
//  AsynImage
//
//  Created by administrator on 13-3-5.
//  Copyright (c) 2013年 enuola. All rights reserved.
//

#import "AsynImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AsynImageView

@synthesize imageURL = _imageURL;
@synthesize placeholderImage = _placeholderImage;
@synthesize fileName = _fileName;

//asynCenterType 设置加载图片的居中类型
- (id)initWithFrame:(CGRect)frame asynCenterType:(X9AsynCenterType)asynCenterType {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0;
        self.backgroundColor = [UIColor grayColor];
        //添加默认的loading图标并启动动画
        loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        if (asynCenterType == X9AsynCenterTypePosition) {
            loadingImageView.layer.position = self.layer.position;
        } else {
            loadingImageView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        }
        [self addSubview:loadingImageView];
        [self reloadAnimation:loadingImageView];
        //添加进度百分比label
        progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
         progressLabel.text = @"0";
         if (asynCenterType == X9AsynCenterTypePosition) {
         progressLabel.layer.position = self.layer.position;
         } else {
         progressLabel.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
         }
         progressLabel.textAlignment = NSTextAlignmentCenter;
         progressLabel.textColor = [UIColor whiteColor];
         progressLabel.font = [UIFont systemFontOfSize:9];
         progressLabel.backgroundColor = [UIColor clearColor];
         [self addSubview:progressLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0;
        self.backgroundColor = [UIColor grayColor];
        //添加默认的loading图标并启动动画
        loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
        loadingImageView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self addSubview:loadingImageView];
        [self reloadAnimation:loadingImageView];
        //添加进度百分比label
        progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        progressLabel.text = @"0";
        progressLabel.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        progressLabel.textAlignment = NSTextAlignmentCenter;
        progressLabel.textColor = [UIColor whiteColor];
        progressLabel.font = [UIFont systemFontOfSize:9];
        progressLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:progressLabel];
    }
    return self;
}

//设置边框
-(void)dontShowBorder {
    self.layer.borderWidth = 0;
}
//重写placeholderImage的Setter方法
-(void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;    //指定默认图片
}

//重写imageURL的Setter方法
-(void)setImageURL:(NSString *)imageURL {
    //  //  self.imageURL = imageURL;
    //    if(imageURL != _imageURL)
    //    {
    //
    //        self.image = _placeholderImage;    //指定默认图片
    //      // [_imageURL release];
    //       // _imageURL = [imageURL retain];
    //    }
    _imageURL = imageURL;
    if(_imageURL.length > 0 ) {
        //确定图片的缓存地址
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir=[path objectAtIndex:0];
        NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if(![fm fileExistsAtPath:tmpPath])
        {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //        NSArray *lineArray = [_imageURL componentsSeparatedByString:@"/"];
        
        
        self.fileName = [NSString stringWithFormat:@"%@/%@.%@", tmpPath,[Tool getMD5:[_imageURL stringByDeletingPathExtension]],[_imageURL pathExtension]];
        
        //判断图片是否已经下载过，如果已经下载到本地缓存，则不用重新下载。如果没有，请求网络进行下载。
        if(![[NSFileManager defaultManager] fileExistsAtPath:_fileName])
        {
            //下载图片，保存到本地缓存中
            [self loadImage];
        }
        else
        {
            //本地缓存中已经存在，直接指定请求的网络图片
            if (self.isGrayImage) {
                [super setImage:[Tool grayscale:[UIImage imageWithContentsOfFile:_fileName] type:1]];
            } else {
                [super setImage:[UIImage imageWithContentsOfFile:_fileName]];
            }
            [self imageDone];
        }
    } else {
        //指定默认图片
        if (self.isGrayImage) {
            [super setImage:[Tool grayscale:_placeholderImage type:1]];
        } else {
            [super setImage:_placeholderImage];
        }
        [self imageDone];
    }
}
- (void)setImage:(UIImage *)image {
    if (image) {
        if (self.isGrayImage) {
            [super setImage:[Tool grayscale:image type:1]];
        } else {
            [super setImage:image];
        }
    }
    [self imageDone];
}

//网络请求图片，缓存到本地沙河中
-(void)loadImage
{
    //对路径进行编码
    @try {
        //请求图片的下载路径
        //定义一个缓存cache
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        /*设置缓存大小为1M*/
        [urlCache setMemoryCapacity:1*124*1024];
        
        //设子请求超时时间为30s
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_imageURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        
        //从请求中获取缓存输出
        NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
        if(response != nil)
        {
            //NSLog(@"如果又缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        
        /*创建NSURLConnection*/
        if(!connection)
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        //开启一个runloop，使它始终处于运行状态
        
        UIApplication *app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = YES;
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
    @catch (NSException *exception) {
        //指定默认图片
        if (self.isGrayImage) {
            [super setImage:[Tool grayscale:[UIImage imageWithContentsOfFile:_fileName] type:1]];
        } else {
            [super setImage:_placeholderImage];
        }
        [self imageDone];
    }
}

#pragma mark - NSURLConnection Delegate Methods
//请求成功，且接收数据(每接收一次调用一次函数)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(loadData == nil) {
        loadData=[[NSMutableData alloc]initWithCapacity:2048];
    }
    [loadData appendData:data];
    CGFloat dataLength = loadData.length;
    CGFloat progress = dataLength / imgSize.longLongValue;
    if (progress >= 1) {
        progressLabel.text = @"ok";
    } else {
        progressLabel.text = [NSString stringWithFormat:@"%.f",(progress * 100)];
    }
}

//获取图片文件总大小
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    imgSize = [NSNumber numberWithLongLong:response.expectedContentLength];
}
//将缓存输出
-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}
//即将发送请求
-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    return request;
}
//下载完成，将文件保存到沙河里面
-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    //图片已经成功下载到本地缓存，指定图片
    if([loadData writeToFile:_fileName atomically:YES]) {
        if (self.isGrayImage) {
            [super setImage:[Tool grayscale:[UIImage imageWithContentsOfFile:_fileName] type:1]];
        } else {
            [super setImage:[UIImage imageWithContentsOfFile:_fileName]];
        }
    } else {
        if (self.isGrayImage) {
            [super setImage:[Tool grayscale:_placeholderImage type:1]];
        } else {
            [super setImage:_placeholderImage];
        }
    }
    [self imageDone];
    connection = nil;
    loadData = nil;
}
//网络连接错误或者请求成功但是加载数据异常
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
    //指定默认图片
    if (self.isGrayImage) {
        [super setImage:[Tool grayscale:_placeholderImage type:1]];
    } else {
        [super setImage:_placeholderImage];
    }
    [self imageDone];
}
//loading图片动画效果 (顺时针)
- (void)reloadAnimation:(UIView *)targetView {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI_2];
    rotationAnimation.duration = 0.4;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [targetView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
//图片加载完成时 停止动画,如果有自定义回调方法,则执行
- (void)imageDone {
    [progressLabel removeFromSuperview];
    [loadingImageView removeFromSuperview];
    [loadingImageView.layer removeAllAnimations];
    self.backgroundColor = [UIColor clearColor];
    if (self.loadedAfterFun) {
        self.loadedAfterFun(self);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate) {
        [self.delegate touchBegin:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate) {
        [self.delegate touchMoved:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate) {
        [self.delegate touchEnded:touches withEvent:event];
    }
}
@end
