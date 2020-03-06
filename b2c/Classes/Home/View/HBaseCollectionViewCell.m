//
//  HBaseCollectionViewCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/14.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBaseCollectionViewCell.h"
/**
 @class HCellComposeModel;
 @class HCellBaseComposeView;
 */
#import "HCellComposeModel.h"
#import "HCellBaseComposeView.h"
@implementation HBaseCollectionViewCell



-(void)composeClick:(HCellBaseComposeView*)sender
{
    if (sender.composeModel) {
        
        if (sender.composeModel.link.length>0) {
            
            sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.link};
        }else if (sender.composeModel.url.length>0){
         sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.url};
        }
        if ([sender.composeModel.actionKey isEqualToString:@"BaseWebVC"]) {
            sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.value};
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调网页");
        }else if ([sender.composeModel.actionKey isEqualToString:@"HShopVC"]){
            /**   model.keyParamete=@{@"paramete":model.shop_id}; */
            sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.value};
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"调店铺");
        }else if ([sender.composeModel.actionKey isEqualToString:@"HGoodsVC"]){
            sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.value};
            
        } else if ([sender.composeModel.actionKey isEqualToString:@"HSearchgoodsListVC"]){
            sender.composeModel.keyParamete=@{@"paramete":sender.composeModel.value};
            
        }
        
        
        NSDictionary * pragma = @{
                                  @"HCellComposeViewModel":sender.composeModel
                                  };
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
    }
//        LOG(@"_%@_%d_%@",[self class] , __LINE__,self.composeModel.actionKey)
}


@end
