//
//  CommViewController.m
//  jzg
//
//  Created by apple on 13-10-27.
//  Copyright (c) 2013年 bzwzdsoft. All rights reserved.
//

#import "CommViewController.h"
#import "Tool.h"
#import "SystemVariable.h"


#define Title_Font [UIFont boldSystemFontOfSize:18] //描述字体
#define Title_Color [UIColor whiteColor]
#define Button_Text_Font        [UIFont systemFontOfSize:16];

@interface CommViewController ()

@end

@implementation CommViewController

-(void) viewWillAppear:(BOOL)animated {
       [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
    screenWidth = screenBounds.size.width;
    screenHeight =  screenBounds.size.height;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = title;
    
    if(IS_GTE_IOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[Tool colorWithHexString:@"FFFFFF"],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextShadowColor:[UIColor clearColor], UITextAttributeFont:[UIFont fontWithName:@"Helvetica" size:16], UITextAttributeTextColor:[Tool colorWithHexString:@"FFFFFF"]}];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    
    if (isShowBackButton) {
        [self leftButton];
    }
    if (isHideNavBar) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    [super viewDidLoad];
}
////隐藏状态栏(IOS7下生效)
- (BOOL)prefersStatusBarHidden {
    if (isHideStatusBar) {
        return YES;
    }
    return NO;
}

- (void)leftButton {
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"prevIco.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"prevIco.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
   
    
    if (IS_GTE_IOS7) {
        negativeSpacer.width = -10;
    } else {
        negativeSpacer.width = 0;
    }
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBtn, nil];

}
- (UIButton *) headeButton:(NSString *)name image:(UIImage *)image highLightImage:(UIImage *)highImage withSize:(CGSize)size {
    UIButton * headeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (name !=nil) {
        [headeButton setTitle:name forState:UIControlStateNormal];
        headeButton.titleLabel.font=Button_Text_Font;
        headeButton.titleLabel.textColor = Title_Color;
    }
    if (image != nil) {
        [headeButton setImage:image forState:UIControlStateNormal];
        if (highImage) {
            [headeButton setImage:highImage forState:UIControlStateHighlighted];
        }
    }
    return  headeButton;
}
- (UIButton *) headeButton:(NSString *)name image:(UIImage *)image
{
    UIButton * headeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    if (name !=nil) {
        [headeButton setTitle:name forState:UIControlStateNormal];
        headeButton.titleLabel.font=Button_Text_Font;
        headeButton.titleLabel.textColor = Title_Color;
    }
    if (image != nil) {
        image = [self scaleToSize:image size:CGSizeMake(20, 20)];
        [headeButton setImage:image forState:UIControlStateNormal];
    }
    return  headeButton;
    
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIButton *) headeButton:(UIImage *)image  {
    
    UIButton * headeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 32)];
    headeButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [headeButton setBackgroundImage:[UIImage imageNamed:@"wb_btn_normal.png"] forState:UIControlStateNormal];
    [headeButton setBackgroundImage:[UIImage imageNamed:@"wb_btn_pressed.png"] forState:UIControlStateHighlighted];
    
    [headeButton setImage:image forState:UIControlStateNormal];
    return  headeButton;
    
}


-(UIButton *) backButton
{
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 48)];
   // [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [backButton setBackgroundImage:[UIImage imageNamed:@"wb_back_btn_normal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"wb_back_btn_pressed.png"] forState:UIControlStateHighlighted];
    return backButton;
}

-(UIButton *) backButton:(NSString *)name {
    
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 48)];
    // [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [backButton setBackgroundImage:[UIImage imageNamed:@"wb_back_btn_normal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"wb_back_btn_pressed.png"] forState:UIControlStateHighlighted];
    return backButton;
}

- (void) back:(id)send {
    if (isClickBack) {
        return;
    }
    isClickBack = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)upDataTitle
{
   self.navigationItem.title = title;
}

@end
