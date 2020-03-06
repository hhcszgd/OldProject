//
//  CIMShowImage.m
//  IOSCim
//
//  Created by apple apple on 11-9-7.
//  Copyright 2011 CIMForIOS. All rights reserved.
//

#import "CIMShowImage.h"
#import "Tool.h"

//缩放时的速率
#define scaleToBig 1.018
#define scaleToSmall .982
//最大放大倍数
#define maxScale 2.5
//可超出显示最大倍率
#define maxOverScale 2.5
//可超出显示最小倍率
#define minOverScale .7

@implementation CIMShowImage
@synthesize imageView, imageSrc;


- (void)viewWillAppear:(BOOL)animated
{
    [self setImage:imageSrc];
}



- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    self.view.userInteractionEnabled = YES;
    //背景点击关闭
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMe:)]];
    imageView.userInteractionEnabled = YES;
    //图片点击关闭
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMe:)]];
    [self setImage:imageSrc];
    //图片缩放
    [imageView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imageResize:)]];
    
}
- (void)closeMe:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setImage:(NSString*)imageSrcc
{
    
    NSURL *url = [NSURL URLWithString:imageSrcc];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //设置外框
    CGSize imageSize = img.size;
    mainRect = [Tool screenRect];
    imageBoxView = [[UIScrollView alloc] initWithFrame:mainRect];
    imageBoxView.contentSize = mainRect.size;
    [self.view addSubview:imageBoxView];
    [imageView removeFromSuperview];
    [imageBoxView addSubview:imageView];
    //调整图片大小
    float widthR = imageSize.width / mainRect.size.width;
    float heightR = imageSize.height / mainRect.size.height;
    if (widthR > heightR && widthR > 1) {
        float resultWidth = mainRect.size.width;
        float resultHeight = imageSize.height / widthR;
        imageView.frame = CGRectMake(0, (mainRect.size.height - resultHeight) / 2, resultWidth, resultHeight);
    } else if (heightR <= widthR && heightR > 1) {
        float resultWidth = imageSize.width / heightR;
        float resultHeight = mainRect.size.height;
        imageView.frame = CGRectMake((mainRect.size.width - resultWidth) / 2, 0, resultWidth, resultHeight);
    } else {
        imageView.frame = CGRectMake((mainRect.size.width - imageSize.width) / 2, (mainRect.size.height - imageSize.height) / 2, imageSize.width, imageSize.height);
    }
    imageOrigiRect = imageView.frame;
    [imageView setImage:img];
}
//缩放图片
- (void)imageResize:(UIPinchGestureRecognizer *)gr {
    CGFloat scale = gr.scale;
    //缩放倍率固定时可避免激增骤减的bug
    if(scale > 1) {
        scale = scaleToBig;
    } else if(scale < 1) {
        scale = scaleToSmall;
    }
    
    //事件开始计算出当前页码
    if (gr.state == UIGestureRecognizerStateBegan) {
        //获取视图放大前的大小
        curViewSize = imageBoxView.contentSize;
        //获取视图缩放前的x,y边距在视图中的比例
        CGPoint curBoxPoint = imageBoxView.contentOffset;
        xSetRa = (curBoxPoint.x ) / imageBoxView.contentSize.width;
        ySetRa = (curBoxPoint.y ) / imageBoxView.contentSize.height;
        //事件过程缩放视图大小
    } else if(gr.state == UIGestureRecognizerStateChanged || gr.state == UIGestureRecognizerStateEnded){
        CGRect imageViewRect = imageView.bounds;
        imageViewRect.size.width *= scale;
        imageViewRect.size.height *= scale;
        //当前视图大小小于原始大小时,则在事件结束时 缩放回原始大小 / 当大于原始大小maxScale倍时 则至显示maxScale倍大小
        if (gr.state == UIGestureRecognizerStateEnded) {
            if (imageViewRect.size.width < imageOrigiRect.size.width) {
                imageViewRect.size.width = imageOrigiRect.size.width;
            } else if(imageViewRect.size.width > imageOrigiRect.size.width * maxScale) {
                imageViewRect.size.width = imageOrigiRect.size.width * maxScale;
            }
            if (imageViewRect.size.height < imageOrigiRect.size.height) {
                imageViewRect.size.height = imageOrigiRect.size.height;
            } else if(imageViewRect.size.height > imageOrigiRect.size.height * maxScale) {
                imageViewRect.size.height = imageOrigiRect.size.height * maxScale;
            }
        } else {
            if (imageViewRect.size.width < imageOrigiRect.size.width * minOverScale) {
                imageViewRect.size.width = imageOrigiRect.size.width * minOverScale;
            } else if(imageViewRect.size.width > imageOrigiRect.size.width * maxOverScale) {
                imageViewRect.size.width = imageOrigiRect.size.width * maxOverScale;
            }
            if (imageViewRect.size.height < imageOrigiRect.size.height * minOverScale) {
                imageViewRect.size.height = imageOrigiRect.size.height * minOverScale;
            } else if(imageViewRect.size.height > imageOrigiRect.size.height * maxOverScale) {
                imageViewRect.size.height = imageOrigiRect.size.height * maxOverScale;
            }
        }
        //设置视图外层scrollView视图的contentSize
        CGSize boxSize = imageBoxView.frame.size;
        if (boxSize.width < imageViewRect.size.width) {
            boxSize.width = imageViewRect.size.width;
            imageViewRect.origin.x = 0;
        } else {
            imageViewRect.origin.x = mainRect.size.width / 2 - imageViewRect.size.width / 2;
        }
        if (boxSize.height < imageViewRect.size.height) {
            boxSize.height = imageViewRect.size.height;
            imageViewRect.origin.y = 0;
        } else {
            imageViewRect.origin.y = mainRect.size.height / 2 - imageViewRect.size.height / 2;
        }
        imageBoxView.contentSize = boxSize;
        //计算主观视角中心点,只计算放大时的效果即可
        if (scale > 1) {
            imageBoxView.contentOffset = CGPointMake(boxSize.width * xSetRa + ((boxSize.width - curViewSize.width) / 2), boxSize.height * ySetRa + ((boxSize.height - curViewSize.height) / 2));
        }
        imageView.frame = imageViewRect;
    }
    
}

@end
