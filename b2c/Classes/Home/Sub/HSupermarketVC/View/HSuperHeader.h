//
//  HSuperHeader.h
//  b2c
//
//  Created by 0 on 16/5/5.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSuperBaseModel.h"
@interface HSuperHeader : UICollectionReusableView
@property (nonatomic, strong) HSuperBaseModel *baseModel;
/**厂家直销*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *channelLabel;
@end
