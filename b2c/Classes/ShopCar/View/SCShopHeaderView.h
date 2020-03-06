//
//  SCShopHeaderView.h
//  b2c
//
//  Created by wangyuanfei on 16/4/19.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCarBaseComposeView.h"
@class SCShopHeaderView;
@protocol SCShopHeaderViewDelegate <NSObject>
 -(void)chooseShopInSCShopHeaderView:(SCShopHeaderView*)shopHeader section:(NSInteger)section;
-(void)ticketButtonClickInSCShopHeaderView:(ShopCarBaseComposeView*)shopHeader section:(NSInteger)section;
//-(void)chooseShopButtonClickInSCShopHeaderView:(ShopCarBaseComposeView*)shopHeader ticketButton:(UIButton*)sender;
-(void)shopNameButtonClickInSCShopHeaderView:(ShopCarBaseComposeView*)shopHeader section:(NSInteger)section;

@end


@class SVCShop;
@interface SCShopHeaderView : ShopCarBaseComposeView
@property(nonatomic,strong)SVCShop * shopModel ;
@property(nonatomic,weak)id <SCShopHeaderViewDelegate> SCShopHeaderHelegate ;
-(instancetype)initWithTableView:(UITableView * ) tableView forSection:(NSInteger)section;

@end
