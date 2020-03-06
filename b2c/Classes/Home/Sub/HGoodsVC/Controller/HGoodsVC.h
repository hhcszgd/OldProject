//
//  HGoodsVC.h
//  b2c
//
//  Created by wangyuanfei on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//导航栏上面的购物车按钮

#pragma mark -- 商品详情
#import "HGDetailBaseVC.h"
#import "HGoodsSubGFocusModel.h"
#import "HGoodsSubGinfoModel.h"
#import "HGoodsSubGPromotModel.h"

#import "HGTopSubGoodsEvaluateModel.h"
#import "HGTopSubGoodsShopModel.h"
#import "HGoodsBottomModel.h"
#pragma mark -- 商品详情

#import "HGoodsBottomModel.h"
#import "HGoodsBottomSubModel.h"
#pragma mark -- 评价
#import "HGTopSubEModel.h"
#import "HGTopSubGoodsESubModel.h"
#import "SVCGoods.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"

#import "UMSocialSnsPlatformManager.h"
#import "ConfirmOrderVC.h"

@interface HGoodsVC : HGDetailBaseVC<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UMSocialUIDelegate>





@end
