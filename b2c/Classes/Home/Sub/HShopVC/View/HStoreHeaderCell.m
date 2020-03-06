//
//  HStoreHeaderCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreHeaderCell.h"
#import "LoginNavVC.h"
#import "b2c-Swift.h"

@interface HStoreHeaderCell()
@property (nonatomic, strong) UICollectionView *superView;
@property (nonatomic, strong) UIImageView *backImage;
//@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *shopLogo;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *referBtn;
@property (nonatomic, strong) UIButton *sharBtn;
@property (nonatomic, copy) NSString *save_shop_id;



@end
@implementation HStoreHeaderCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}
//- (UIView *) backView{
//    if (_backView == nil) {
//        _backView = [[UIView alloc] init];
//        [self.contentView addSubview:_backView];
//        _backView.layer.cornerRadius = 7 ;
//        _backView.layer.masksToBounds = YES;
//        _backView.backgroundColor = [[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.5];
//        
//    }
//    return _backView;
//}

- (UIImageView *)backImage{
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc] init];
        _backImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_backImage];
    }
    return _backImage;
}
- (UIImageView *)shopLogo{
    if (_shopLogo == nil) {
        _shopLogo = [[UIImageView alloc] init];
        [self.contentView addSubview:_shopLogo];
        _shopLogo.backgroundColor = [UIColor whiteColor];
       
    }
    return _shopLogo;
}
- (UILabel *)shopName{
    if (_shopName == nil) {
        _shopName = [[UILabel alloc] init];
        [self.contentView addSubview:_shopName];
        [_shopName configmentfont:[UIFont systemFontOfSize:14 * zkqScale] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@""];
        [_shopName sizeToFit];
        
        _shopName.numberOfLines = 2;
    }
    return _shopName;
}
- (UIButton *)collectionBtn{
    if (_collectionBtn == nil) {
        _collectionBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_collectionBtn];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_collection_store_nor"] forState:UIControlStateNormal];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"icon_collection_store_sel"] forState:UIControlStateSelected];
        [_collectionBtn addTarget:self action:@selector(collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _collectionBtn;
}
- (UIButton *)referBtn{
    if (_referBtn == nil) {
        _referBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_referBtn];
        [_referBtn setBackgroundImage:[UIImage imageNamed:@"icon_consultation_store"] forState:UIControlStateNormal];
        [_referBtn addTarget:self action:@selector(regerBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _referBtn;
}

- (UIButton *)sharBtn{
    if (_sharBtn == nil) {
        _sharBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_sharBtn];
        [_sharBtn setBackgroundImage:[UIImage imageNamed:@"icon_share_store"] forState:UIControlStateNormal];
        [_sharBtn addTarget:self action:@selector(sharBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sharBtn;
}




- (void)configmentUI{
    //布局背景图片
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    self.contentView.backgroundColor = [UIColor whiteColor];
    //布局backview
//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
//        make.height.equalTo(@(61 ));
//         make.width.equalTo(@(210 ));
//    }];
    //用户登录之后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgeCollectionBtnStatus:) name:LOGINSUCCESS object:nil];
    //布局店铺logo
    [self.shopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.contentView);
         make.width.equalTo(@(100 * SCALE));
        make.height.equalTo(@(50 * SCALE));
    }];
    //店铺名称的长度
    CGFloat leftShopNmaeWidth = screenW - 100 * SCALE - 3 * 10 * SCALE -10 -5 -38 * 3;
    //布局店铺名称
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopLogo.mas_right).offset(10 * SCALE);
        make.centerY.equalTo(self.shopLogo);
        make.width.equalTo(@(leftShopNmaeWidth));
        
    }];
    
    [self.sharBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@(38));
        make.height.equalTo(@(38));
    }];
    [self.referBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sharBtn.mas_left).offset(-10 * SCALE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@(38));
        make.height.equalTo(@(38));
    }];
    //17,9,22,28
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.referBtn.mas_left).offset(-10 * SCALE);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
         make.width.equalTo(@(38));
        make.height.equalTo(@(38));
    }];
    
}

#pragma mark --  收藏
- (void)collectionBtn:(UIButton *)colBtn{
    if ([UserInfo shareUserInfo].isLogin){
        if (self.save_shop_id) {
            [[UserInfo shareUserInfo] judgeShopIsCollectionWithShopID:self.save_shop_id success:^(ResponseObject *response) {
                LOG(@"%d,%@",__LINE__,response)
                //状态小于0是买家已收藏
                if (response.status < 0) {
                    self.collectionBtn.selected = YES;
                    [self deleteCollectShopID:^{
                        
                    } failure:^{
                        
                    }];
                }else{
                    self.collectionBtn.selected = NO;
                    //状态大于0是买家没有收藏了
                    [self addShopCollectinSuccess:^{
                        
                    } failure:^{
                        
                    }];
                    
                }
            } failure:^(NSError *error) {
                AlertInSubview(@"操作失败请重试")
            }];
        }
        
    }else{
        LoginNavVC *login = [[LoginNavVC alloc] initLoginNavVC];
        [[GDKeyVC share] presentViewController:login animated:YES  completion:nil ];

//        [[KeyVC shareKeyVC] presentViewController:login animated:YES completion:nil];
    }
}
/**取消收藏店铺*/
- (void)deleteCollectShopID:(void(^)())success failure:(void(^)())failure{
    if (self.save_shop_id) {
        [[UserInfo shareUserInfo] deleteShopFavoriteWithShop_id:[@[self.save_shop_id] mj_JSONString] success:^(ResponseStatus response) {
            success();
            if (response > 0) {
                self.collectionBtn.selected = NO;
            }else{
                AlertInSubview(@"取消收藏失败请重试")
                self.collectionBtn.selected = YES;
            }
        } failure:^(NSError *error) {
            failure();
            AlertInSubview(@"取消收藏失败请重试")
            self.collectionBtn.selected = YES;
        }];
    }
    
}

/**添加商品收藏*/
- (void)addShopCollectinSuccess:(void(^)())success failure:(void(^)())failure{
    if (self.save_shop_id) {
        [[UserInfo shareUserInfo] addShopFavoriteWithShop_id:self.save_shop_id Success:^(ResponseObject *response) {
            success();
            if (response.status > 0) {
                self.collectionBtn.selected = YES;
            }else{
                AlertInSubview(response.msg)
                self.collectionBtn.selected = NO;
            }
        } failure:^(NSError *error) {
            //收藏失败
            failure();
            AlertInSubview(@"收藏失败请重试")
            self.collectionBtn.selected = NO;
        }];
    }
    
}

#pragma mark --  咨询
- (void)regerBtn:(UIButton *)regerBtn{
    if ([self.delegate respondsToSelector:@selector(chat)]) {
        [self.delegate performSelector:@selector(chat)];
    }
}

#pragma mark -- 分享
- (void)sharBtn:(UIButton *)sharBtn{
    if ([self.delegate respondsToSelector:@selector(HStoreBaseCellShar)]) {
        [self.delegate performSelector:@selector(HStoreBaseCellShar)];
    }
    
}



-(void)setBaseModel:(HStoreDetailModel *)baseModel{


    NSURL *backurl = ImageUrlWithString(baseModel.img);
    [self.backImage sd_setImageWithURL:backurl placeholderImage:[UIImage imageNamed:@"accountBiiMap"] options:SDWebImageCacheMemoryOnly];

    NSURL *url = ImageUrlWithString(baseModel.shop.img);
    [self.shopLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"accountBiiMap"]options:SDWebImageCacheMemoryOnly];
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:baseModel.shop.shopname];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    shadow.shadowBlurRadius = 3;
    [mutableStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:shadow,NSShadowAttributeName, nil] range:NSMakeRange(0, baseModel.shop.shopname.length)];
    self.shopName.attributedText = mutableStr;
}
- (void)setShop_id:(NSString *)shop_id{
    self.save_shop_id = shop_id;
    [self changCollectionBtn];
}
- (void)changCollectionBtn{
    if ([UserInfo shareUserInfo].isLogin) {
        if (self.save_shop_id) {
            [[UserInfo shareUserInfo] judgeShopIsCollectionWithShopID:self.save_shop_id success:^(ResponseObject *response) {
                if (response.status < 0) {
                    self.collectionBtn.selected = YES;
                }else{
                    self.collectionBtn.selected = NO;
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
        
    }else{
        self.collectionBtn.selected = NO;
    }
    
}
- (void)judgeCollectionBtnStatus:(NSNotification *)notification{
    [self changCollectionBtn];
}

@end
