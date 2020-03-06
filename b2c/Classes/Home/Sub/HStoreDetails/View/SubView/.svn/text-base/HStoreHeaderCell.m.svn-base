//
//  HStoreHeaderCell.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HStoreHeaderCell.h"

@interface HStoreHeaderCell()
@property (nonatomic, strong) UICollectionView *superView;
@end
@implementation HStoreHeaderCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configmentUI];
    }
    return self;
}


- (void)configmentUI{
    UIImageView *storeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, storeImageViewHeight)];
    //店铺店铺的图片
    storeImageView.image = [UIImage imageNamed:@"gwxq_product_header"];
    storeImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:storeImageView];
    //店铺logo
    UIImageView *logoImage = [[UIImageView alloc] init];
    [storeImageView addSubview:logoImage];
    [logoImage sd_setImageWithURL:[NSURL URLWithString:@"http://img02.tooopen.com/images/20160216/tooopen_sy_156324542564.jpg"] placeholderImage:[UIImage imageNamed:@"lottery_withoutChannce"]];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(storeImageView.mas_left).offset(0);
        make.bottom.equalTo(storeImageView.mas_bottom).offset(0);
        make.width.equalTo(@(storeImageViewHeight/5.0*3));
        make.height.equalTo(@(storeImageViewHeight/5.0*3));
    }];
    //店铺名称
    UILabel *storeName = [[UILabel alloc] init];
    [storeImageView addSubview:storeName];
    [storeName sizeToFit];
    storeName.numberOfLines = 0;
    [storeName configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor clearColor] textAligement:1 cornerRadius:0 text:@"北极绒绒专卖店"];
    
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImage.mas_top).offset(0);
        make.left.equalTo(logoImage.mas_right).offset(0);
        make.bottom.equalTo(storeImageView.mas_bottom).offset(0);
        make.width.equalTo(@(100));
        
    }];
    //收藏，咨询，分享
#warning 根据效果重新选择控件
    UIButton *collectionBtn = [[UIButton alloc] init];
    [storeImageView addSubview:collectionBtn];
    [collectionBtn setBackgroundColor:[UIColor blackColor]];
    [collectionBtn addTarget:self action:@selector(collectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectionBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //咨询
    UIButton *referBtn = [[UIButton alloc] init];
    [storeImageView addSubview:referBtn];
    [referBtn setBackgroundColor:[UIColor blackColor]];
    [referBtn addTarget:self action:@selector(regerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [referBtn setTitle:@"咨询" forState:UIControlStateNormal];
    [referBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    referBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //分享
    UIButton *sharBtn = [[UIButton alloc] init];
    [storeImageView addSubview:sharBtn];
    [sharBtn setBackgroundColor:[UIColor blackColor]];
    [sharBtn addTarget:self action:@selector(sharBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sharBtn setTitle:@"分享" forState:UIControlStateNormal];
    [sharBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sharBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //布局三个按钮
    CGFloat size = (screenW - storeImageViewHeight/5.0 * 3 - 100 - 3 *10)/3.0;
    [sharBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(storeImageView.mas_bottom).offset(0);
        make.right.equalTo(storeImageView.mas_right).offset(0);
        make.width.equalTo(@(size));
        make.height.equalTo(@(size));
    }];
    [referBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(storeImageView.mas_bottom).offset(0);
        make.right.equalTo(sharBtn.mas_left).offset(-10);
        make.width.equalTo(@(size));
        make.height.equalTo(@(size));
    }];
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(storeImageView.mas_bottom).offset(0);
        make.right.equalTo(referBtn.mas_left).offset(-10);
        make.width.equalTo(@(size));
        make.height.equalTo(@(size));
    }];
    sharBtn.layer.masksToBounds = YES;
    sharBtn.layer.cornerRadius = size/2.0;
    referBtn.layer.masksToBounds = YES;
    referBtn.layer.cornerRadius = size/2.0;
    collectionBtn.layer.masksToBounds = YES;
    collectionBtn.layer.cornerRadius = size/2.0;
    
}
#warning 添加到收藏中，上传服务器
#pragma mark --  收藏
- (void)collectionBtn:(UIButton *)colBtn{
    colBtn.selected = !colBtn.selected;
    if (colBtn.selected) {
        [colBtn setBackgroundColor:[UIColor redColor]];
        NSString *str =[NSString stringWithFormat:@"收藏成功%@",@"请到关注频道里面查看店铺"];
        ALERTModeCustomView(str, [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SHJ_Collection"]], _superView, 1, NO);
    }else{
        [colBtn setBackgroundColor:[UIColor blackColor]];
        ALERTModeCustomView(@"取消收藏", [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SHJ_NoCollection"]], _superView, 1, NO)
    }
}
#warning 跳转到聊天页面
#pragma mark --  咨询
- (void)regerBtn:(UIButton *)regerBtn{
    regerBtn.selected = !regerBtn.selected;
    if (regerBtn.selected) {
        [regerBtn setBackgroundColor:[UIColor redColor]];
        
    }else{
        [regerBtn setBackgroundColor:[UIColor blackColor]];
        
    }
}
#warning 分享
#pragma mark -- 分享
- (void)sharBtn:(UIButton *)sharBtn{
    sharBtn.selected = !sharBtn.selected;
    if (sharBtn.selected) {
        [sharBtn setBackgroundColor:[UIColor redColor]];
        
    }else{
        [sharBtn setBackgroundColor:[UIColor blackColor]];
        
    }
    LOG(@"%@,%d,%@",[self class], __LINE__,@"分享")
}

#pragma mark  赋值
- (void)setCollectionView:(UICollectionView *)collectionView{
    _superView = collectionView;
}

- (void)setModel:(id)model{
    
}


@end
