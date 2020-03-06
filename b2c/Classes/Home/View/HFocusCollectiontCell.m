//
//  HFocusCollectiontCell.m
//  b2c
//
//  Created by wangyuanfei on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFocusCollectiontCell.h"
#import "HCellComposeModel.h"
#import "HCellBaseComposeView.h"
@interface HFocusCollectiontCell()
@property(nonatomic,weak)HCellBaseComposeView * image ;
@end


@implementation HFocusCollectiontCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        HCellBaseComposeView * imgView = [[HCellBaseComposeView alloc]init];
        [imgView addTarget:self action:@selector(composeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.image = imgView;
        [self.contentView  addSubview:self.image];
//        self.titleLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:self.titleLabel];
//        self.titleLabel.frame = CGRectMake(0, 0, 200, 200);
//        self.titleLabel.font = [UIFont systemFontOfSize:30];
//        self.titleLabel.textColor = [UIColor blackColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.image.frame = self.bounds;
//    self.image.backImageURLStr=self.composeModel.imgStr;
}

-(void)setComposeModel:(HCellComposeModel *)composeModel{
//    _composeModel = composeModel;
    [super setComposeModel:composeModel];
//     self.image.backImageURLStr=self.composeModel.imgStr;
    NSURL *url;
    if ([composeModel.imgStr hasPrefix:@"http"]) {
        url = [NSURL URLWithString:composeModel.imgStr];
    } else {
        url = ImageUrlWithString(composeModel.imgStr);
    }
    
    
    if (composeModel.isRefreshImageCached) {
        
        [self.image.privateImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRefreshCached];
        composeModel.isRefreshImageCached = NO;
    }else{
        [self.image.privateImage sd_setImageWithURL:url placeholderImage:placeImage options:SDWebImageRetryFailed];
    }
    
    self.image.composeModel = composeModel;

}

-(void)composeClick:(HCellBaseComposeView*)sender
{
    NSLog(@"%@, %d ,%@",[self class],__LINE__,sender.composeModel);

    if (sender.composeModel) {
        if (sender.composeModel.value.length==0) {
            return;
        }
//        sender.composeModel.actionKey=@"BaseWebVC";
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
        
        LOG(@"_%@_%d_首页轮播图的actionKey是 --> %@",[self class] , __LINE__,sender.composeModel.actionKey);

        NSDictionary * pragma = @{
                                  @"HCellComposeViewModel":sender.composeModel
                                  };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
    }
    //    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.composeModel.actionKey)
}
//
//-(void)composeClick:(HCellBaseComposeView*)sender
//{
//    if (sender.composeModel) {
//        
//        NSDictionary * pragma = @{
//                                  @"HCellComposeViewModel":sender.composeModel
//                                  };
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"HCellComposeViewClick" object:nil userInfo:pragma];
//    }
////    LOG(@"_%@_%d_%@",[self class] , __LINE__,self.composeModel.actionKey)
//}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
