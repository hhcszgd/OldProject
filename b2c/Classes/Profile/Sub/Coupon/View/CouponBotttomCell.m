//
//  CouponBotttomCell.m
//  b2c
//
//  Created by 0 on 16/4/21.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//
#import "CouponBotttomCell.h"
#import "CouponUnUseCell.h"
@interface CouponBotttomCell()
/**没有数据时候的view*/
@property (nonatomic, strong) UIView *noDataView;
/**有数据的collectionView*/
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end
@implementation CouponBotttomCell
- (UIView *)noDataView{
    if (_noDataView == nil) {
        _noDataView = [[UIView alloc] init];
        
        [self.contentView addSubview:_noDataView];
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
        UIImageView *image = [[UIImageView alloc] init];
        [_noDataView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataView);
            make.top.equalTo(_noDataView.mas_top).offset(100);
             make.width.equalTo(@(screenW/1.2));
            make.height.equalTo(image.mas_width);
        }];
        image.image = [UIImage imageNamed:@"zhekouqu"];
        UILabel *label = [[UILabel alloc] init];
        [_noDataView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_bottom).offset(20);
            make.centerX.equalTo(image);
        }];
        [label sizeToFit];
        [label configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor lightGrayColor] backColor:[UIColor clearColor] textAligement:0 cornerRadius:0 text:@"没有券"];
        
        
        UIButton *seeBtn = [[UIButton alloc] init];
        [_noDataView addSubview:seeBtn];
        [seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_noDataView);
            make.top.equalTo(label.mas_bottom).offset(50);
             make.width.equalTo(@(100));
            make.height.equalTo(@(30));
        }];
//        seeBtn.backgroundColor = randomColor;
        
    }
    return _noDataView;
}
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) collectionViewLayout:self.flowLayout];
        [self.contentView addSubview:_col];
        _col.delegate = self;
        _col.dataSource = self;
        [_col registerClass:[CouponUnUseCell class] forCellWithReuseIdentifier:@"CouponUnUseCell"];

        [_col setShowsVerticalScrollIndicator:NO];
        
    }
    return _col;
}






- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.noDataView.backgroundColor = [UIColor clearColor];
        self.col.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CouponUnUseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouponUnUseCell" forIndexPath:indexPath];
//    cell.backgroundColor = randomColor;
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width, 100);
}


- (void)setIsOrNo:(BOOL)isOrNo{
    
    if (isOrNo) {
        self.noDataView.hidden = YES;
        self.col.hidden = NO;
    }else{
        self.noDataView.hidden = NO;
        self.col.hidden = YES;
    }
}

@end
