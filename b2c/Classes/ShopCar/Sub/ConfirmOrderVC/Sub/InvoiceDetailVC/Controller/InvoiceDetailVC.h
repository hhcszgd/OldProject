//
//  InvoiceDetailVC.h
//  b2c
//
//  Created by wangyuanfei on 16/5/17.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "SecondBaseVC.h"
@protocol InvoiceDetailVCDelegate <NSObject>

-(void)setInvoiceOrNot:(BOOL)setIvnoice;

@end

@interface InvoiceDetailVC : SecondBaseVC
@property(nonatomic,weak)id <InvoiceDetailVCDelegate> InvoiceDetailDelegate ;
@end
