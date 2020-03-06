//
//  GDPicturnPreview.h
//  b2c
//
//  Created by WY on 17/2/15.
//  Copyright © 2017年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDPicturnPreview : UIView
@property(nonatomic,strong)NSArray <UIImage*>* images ;
@property(nonatomic,copy)NSString * filePath ;

-(void)showInView:(UIView*)view ;
+(void)show;

@end
