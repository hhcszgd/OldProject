//
//  SCCell.m
//  b2c
//
//  Created by 0 on 16/4/8.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//


#import "SCCell.h"
#import "SCCellSubCell.h"
@interface SCCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**图片*/
@property (nonatomic, strong) UIImageView *scImageView;
/**介绍*/
@property (nonatomic, strong) UILabel *scTitleLabel;
/**价格*/
//@property (nonatomic, strong) UILabel *scPriceLabel;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@end
@implementation SCCell
- (UIImageView *)scImageView{
    if (_scImageView == nil) {
        _scImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_scImageView];
    }
    return _scImageView;
}
- (UILabel *)scTitleLabel{
    if (_scTitleLabel == nil) {
        _scTitleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_scTitleLabel];
    }
    return _scTitleLabel;
}
//- (UILabel *)scPriceLabel{
//    if (_scPriceLabel == nil) {
//        _scPriceLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:_scPriceLabel];
//    }
//    return _scPriceLabel;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configmentUI];
    }
    return self;
}

- (void)configmentUI{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.lessThanOrEqualTo(@(screenW));
    }];
    [self.scImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
         make.width.equalTo(@(60));
        make.height.equalTo(self.scImageView.mas_width);
    }];
    
    [self.scTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scImageView.mas_centerY);
        make.left.equalTo(self.scImageView.mas_right).offset(20);
    }];
    [self.scTitleLabel sizeToFit];
    
    self.scImageView.image = [UIImage imageNamed:@"lottery_withoutChannce"];
//    self.scImageView.backgroundColor = randomColor;
    
    [self.col mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scImageView.mas_bottom).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
         make.width.equalTo(@(screenW));
        make.height.equalTo(@(100));
    }];
    self.col.backgroundColor = [UIColor whiteColor];
    
    UIView *bottomView = [[UIView alloc] init];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.col.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.height.equalTo(@(20));
    }];
    bottomView.backgroundColor = BackgroundGray;
    [self configmentCol];
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW, 80) collectionViewLayout:self.flowLayout];
        [self.contentView addSubview:_col];
    }
    return _col;
}





- (void)configmentCol{
    
    
    self.col.backgroundColor = [UIColor whiteColor];
    self.col.delegate = self;
    self.col.dataSource = self;
    [self.col registerClass:[SCCellSubCell class] forCellWithReuseIdentifier:@"SCCellSubCell"];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.col setShowsHorizontalScrollIndicator:NO];
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SCCellSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SCCellSubCell" forIndexPath:indexPath];
    cell.scSubModel = [[SCCellSubModel alloc] init];
//    cell.backgroundColor = randomColor;
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 100);
}

- (void)setScModel:(SCModel *)scModel{
    _scModel = scModel;
    [self.scTitleLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"旺仔小馒头"];
}





@end
