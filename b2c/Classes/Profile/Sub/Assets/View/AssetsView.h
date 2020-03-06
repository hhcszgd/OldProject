//
//  AssetsView.h
//  b2c
//
//  Created by 0 on 16/4/20.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsView : UIView
/**左边视图的图片*/
@property (nonatomic, strong) UIImage *TitleImage;
/**titleStr*/
@property (nonatomic, copy) NSString *leftTitle;
/**箭头*/
@property (nonatomic, strong) UIImage *rightImage;
@end
