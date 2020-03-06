//
//  QRCodeScannerVC.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "QRCodeScannerVC.h"

#import <AVFoundation/AVFoundation.h>
#import "CZQRView.h"
#import <WebKit/WebKit.h>



@interface QRCodeScannerVC ()<AVCaptureMetadataOutputObjectsDelegate,CZQRViewDelegate,WKNavigationDelegate>
//@property(nonatomic,strong) AVCaptureMetadataOutput *output  ;
//@property(nonatomic,strong)  AVCaptureDevice *device ;
//@property(nonatomic,strong)  AVCaptureDeviceInput *input  ;
//@property(nonatomic,strong)   AVCaptureSession *session ;
//@property(nonatomic,weak) AVCaptureVideoPreviewLayer *preview ;
//  //////////////////////////////
@property(nonatomic,weak)UIWebView * webView ;
/////////////////////////////
@property(nonatomic,weak)WKWebView * theNewWebview ;
@end

@implementation QRCodeScannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self theRightSetup];
    [self theTrySetup];
    // Do any additional setup after loading the view.
    //    [self setupAboutCamaro];
    
    
    LOG(@"_%@_%d_%lf",[self class] , __LINE__,self.startY)

}
-(void)theTrySetup
{
     CGRect frame = CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
//
    WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc]init];
    
    
    
    WKWebView * theNewWebview = [[WKWebView alloc]initWithFrame:frame configuration:config];
    
    theNewWebview.navigationDelegate = self;
    theNewWebview.allowsBackForwardNavigationGestures = YES;
//    theNewWebview.allowsLinkPreview = YES;
    //    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    self.view.backgroundColor=randomColor;
    //    UIWebView * webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.theNewWebview=theNewWebview;
    //    webview.delegate=self;
    [self.view addSubview:theNewWebview];
    
    
    
    
    CZQRView *view = [[CZQRView alloc] init];
    
    view.frame = frame;
    
    view.delegate = self;
    
    [self.view addSubview:view];

}


////////////////////////

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigationAction.request)
    decisionHandler(YES);
    
}

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    LOG_METHOD
    LOG_METHOD
    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigationResponse.response.URL)
    decisionHandler(YES);
    
}


/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
    
}


/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,navigation)
    
}


/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    LOG_METHOD
    
}


/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
    
}


/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    LOG_METHOD
    
}


/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    LOG_METHOD
    
}


/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler{
//    LOG_METHOD
//    completionHandler(nil,nil);
//}

















////////////////////

-(void)theRightSetup
{
    
    CGRect frame = CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height-self.startY);
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:frame];
    self.webView = webView ;
    [self.view addSubview:webView];
    // /////////////////////////////////
    
    
    
    
    CZQRView *view = [[CZQRView alloc] init];
    
    view.frame = frame;
    
    view.delegate = self;
    
    [self.view addSubview:view];
}
/**
 *  daili
 */
- (void)qrView:(CZQRView *)view didCompletedWithQRValue:(NSString *)qrValue
{
    //    self.valueLabel.text = qrValue;
    NSURL * url  = [[NSURL alloc]initWithString:qrValue];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    NSLog(@"_%d_%@",__LINE__,qrValue);
    [self.theNewWebview loadRequest:request];
//    [self.webView loadRequest:request];
    [view removeFromSuperview];
}
-(void)creatQRCode
{
    //  使用coreImage框架中的滤镜来实现生成的二维码
    //  kCICategoryBuiltIn 内置的过滤器的分类
    //    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    //    NSLog(@"%@",filters);
    
    //  1.创建一个用于生成二维码的滤镜
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //  2.设置默认值
    [qrFilter setDefaults];
    
    //  3.设置输入数据
    //    NSLog(@"%@",qrFilter.inputKeys);
    
    [qrFilter setValue:[@"要生成的字符串内容" dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    
    //  4.生成图片
    CIImage *ciImage = qrFilter.outputImage;
    //  默认生成的ciImage的大小是很小
    //    NSLog(@"%@",ciImage);
    
    //  放大ciImage
    CGAffineTransform scale = CGAffineTransformMakeScale(8, 8);
    ciImage = [ciImage imageByApplyingTransform:scale];
    
    //  5.设置二维码的前景色和背景色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    //  设置默认值
    [colorFilter setDefaults];
    
    //  设置输入的值
    /*
     inputImage,
     inputColor0,
     inputColor1
     
     */
    //    NSLog(@"%@",colorFilter.inputKeys);
    [colorFilter setValue:ciImage forKey:@"inputImage"];
    
    //  设置前景色
    [colorFilter setValue:[CIColor colorWithRed:1 green:0 blue:0] forKey:@"inputColor0"];
    //  设置背景
    [colorFilter setValue:[CIColor colorWithRed:0 green:0 blue:1] forKey:@"inputColor1"];
    //  取出colorFilter中的图片
    ciImage = colorFilter.outputImage;
    
    //  在中心增加一张图片
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    
    //  生成图片
    //  1.开启图片的上下文
    UIGraphicsBeginImageContext(image.size);
    //  2.把二维码的图片划入
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //  3.在中心画其他图片
    UIImage *weiImage = [UIImage imageNamed:@"bg_franchise"];//要插入的图片
    CGFloat weiW = 40;
    CGFloat weiH = 40;
    CGFloat weiX = (image.size.width - weiW) * 0.5;
    CGFloat weiY = (image.size.height - weiH) * 0.5;
    
    [weiImage drawInRect:CGRectMake(weiX, weiY, weiW, weiH)];
    
    //  取出图片
//    UIImage *qrImage =  UIGraphicsGetImageFromCurrentImageContext();
    
    //  结束上下文
    UIGraphicsEndImageContext();
    
    //    self.imageView.image = qrImage;
    
}
























































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
//-(void)setupAboutCamaro
//{
//    //获取一个AVCaptureDevice对象，可以理解为打开摄像头这样的动作
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    self.device = device;
//    //设置闪光灯
//    NSError *error;
//    if (device.hasTorch) {  // 判断设备是否有闪光灯
//        BOOL b = [device lockForConfiguration:&error];
//        if (!b) {
//            if (error) {
//                NSLog(@"lock torch configuration error:%@", error.localizedDescription);
//            }
//            return;
//        }
//        //        device.torchMode = (device.torchMode == AVCaptureTorchModeOff ? AVCaptureTorchModeOn : AVCaptureTorchModeOff);
//        device.torchMode =   AVCaptureTorchModeAuto;
//        [device unlockForConfiguration];
//    }
//    
//    //获取一个AVCaptureDeviceInput对象，将上面的'摄像头'作为输入设备
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
//    self.input = input;
//    //拍完照片以后，需要一个AVCaptureMetadataOutput对象将获取的'图像'输出，以便进行对其解析
//    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
//    self.output=output;
//    //获取输出需要设置代理，在代理方法中获取
//    //    [output setMetadataObjectsDelegate:<#(id<AVCaptureMetadataOutputObjectsDelegate>)#> queue:<#(dispatch_queue_t)#>]
//    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    
//    //设置扫描框
//    
//    //    CGSize size = self.view.bounds.size;
//    //    CGSize transparentAreaSize = CGSizeMake(200,200);
//    //    CGRect cropRect = CGRectMake((size.width - transparentAreaSize.width)/2, (size.height - transparentAreaSize.height)/2, transparentAreaSize.width, transparentAreaSize.height);
//    //    output.rectOfInterest = CGRectMake(cropRect.origin.y/size.width,
//    //                                       cropRect.origin.x/size.height,
//    //                                       cropRect.size.height/size.height,
//    //                                       cropRect.size.width/size.width);
//    //
//    //
//    //设置会话
//    AVCaptureSession *session = [[AVCaptureSession alloc]init];
//    self.session = session;
//    [session setSessionPreset:AVCaptureSessionPresetHigh];//扫描的质量
//    if ([session canAddInput:input]){
//        [session addInput:input];//将输入添加到会话中
//    }
//    if ([session canAddOutput:output]){
//        [session addOutput:output];//将输出添加到会话中
//    }
//    
//    //设置输出类型，如AVMetadataObjectTypeQRCode是二维码类型，下面还增加了条形码。如果扫描的是条形码也能识别
//    //    output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
//    //                                   AVMetadataObjectTypeEAN8Code,
//    //                                   AVMetadataObjectTypeCode128Code,
//    //                                   AVMetadataObjectTypeQRCode];
//    output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
//                                   AVMetadataObjectTypeEAN8Code,
//                                   AVMetadataObjectTypeCode128Code,
//                                   AVMetadataObjectTypeQRCode];
//    
//    AVCaptureVideoPreviewLayer *preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
//    self.preview = preview;
//    preview.videoGravity = AVLayerVideoGravityResize;
//    [preview setFrame:CGRectMake(0,self.startY, self.view.bounds.size.width, self.view.bounds.size.height-self.startY)];//设置取景器的frame
//    [self.view.layer insertSublayer:preview atIndex:0];
//    
//    
//    
//    
//    [session startRunning];
//}
//
//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
//{
//    
//    if (metadataObjects.count > 0) {
//        [self.session stopRunning];//停止会话
//        [self.preview removeFromSuperlayer];//移除取景器
//        AVMetadataMachineReadableCodeObject *obj = metadataObjects.lastObject;
//        NSString *result = obj.stringValue;//这就是扫描的结果
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,result)
//        //对结果进行处理...
//    }else{
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,@"没有扫描到数据")
//    }
//}
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
////从图片中直接读取二维码的功能。主要用到的是读取主要用到CoreImage。
//+ (NSString *)scQRReaderForImage:(UIImage *)qrimage{
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
//    CIImage *image = [CIImage imageWithCGImage:qrimage.CGImage];
//    NSArray *features = [detector featuresInImage:image];
//    CIQRCodeFeature *feature = [features firstObject];
//    NSString *result = feature.messageString;
//    return result;
//}
////从相册获取照片主要用到的是UIImagePickerController，这是苹果给我们分装好的一个相册选取的控制器。实现起来也是很简单的。
//- (void)readerImage{
//    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
//    photoPicker.delegate = self;//遵守协议
//    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    photoPicker.view.backgroundColor = [UIColor whiteColor];
//    [self presentViewController:photoPicker animated:YES completion:NULL];
//}
////获取相册的代理方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    [self dismissViewControllerAnimated:YES completion:^{
//        //code is here ...
//    }];
//    
//    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    NSString *result = [QRCodeScannerVC scQRReaderForImage:srcImage];//调用上面讲过的方法对图片中的二维码进行处理
//    LOG(@"_%@_%d_%@",[self class] , __LINE__,result)
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
////生成二维码和从图片中读取二维码一样要用到CoreImage,具体步骤如下：
//- (UIImage *)makeQRCodeForString:(NSString *)string{
//    NSString *text = string;
//    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
//    //生成
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrFilter setValue:stringData forKey:@"inputMessage"];
//    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
//    //二维码颜色
//    UIColor *onColor = [UIColor redColor];
//    UIColor *offColor = [UIColor blueColor];
//    //上色，如果只要白底黑块的QRCode可以跳过这一步
//    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
//                                       keysAndValues:
//                             @"inputImage",qrFilter.outputImage,
//                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
//                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
//                             nil];
//    //绘制
//    CIImage *qrImage = colorFilter.outputImage;
//    CGSize size = CGSizeMake(300, 300);
//    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage     fromRect:qrImage.extent];
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
//    CGContextScaleCTM(context, 1.0, -1.0);//生成的QRCode就是上下颠倒的,需要翻转一下
//    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
//    //    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGImageRelease(cgImage);
//    
//    return [UIImage imageWithCIImage:qrImage];
//}
@end
