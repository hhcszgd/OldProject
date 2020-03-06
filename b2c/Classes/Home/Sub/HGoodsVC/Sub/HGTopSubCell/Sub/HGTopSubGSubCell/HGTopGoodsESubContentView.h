//
//  HGTopGoodsESubContentView.h
//  b2c
//
//  Created by 0 on 16/5/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGTopSubGoodsESubModel.h"
@interface HGTopGoodsESubContentView : UIView
/**头像*/
@property (nonatomic, strong) UIImageView *nikeImage;
/**昵称*/
@property (nonatomic, strong) UILabel *nikeLabel;
/**content*/
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) HGTopSubGoodsESubModel *subModel;

@end
