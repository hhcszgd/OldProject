//
//  HGTopFocusMapView.m
//  b2c
//
//  Created by 0 on 16/4/29.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HGTopFocusMapView.h"
#import "CustomCollectionCell.h"
@interface HGTopFocusMapView()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) NSArray *data;


@end

@implementation HGTopFocusMapView
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout = flow;
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height) collectionViewLayout:self.flowLayout];
        [self addSubview:_col];
        [_col setShowsVerticalScrollIndicator:NO];
        [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _col.delegate = self;
        _col.dataSource = self;
        _col.pagingEnabled = YES;
        _col.bounces = NO;
        [_col registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CustomCollectionCell"];
        
        
    }
    return _col;
}



- (instancetype)initWithFrame:(CGRect)frame withdataArr:(NSArray *)dataArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.data = dataArr;
        self.col.backgroundColor = BackgroundGray;
        self.col.showsHorizontalScrollIndicator = NO;
        [self configmentUI];
    }
    return self;
}
- (void)configmentUI{
    
    
    
    self.numLabel = [[UILabel alloc] init];
    [self addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
         make.width.equalTo(@(35 * SCALE));
        make.height.equalTo(@(20 * SCALE));
    }];
     [self.numLabel configmentfont:[UIFont systemFontOfSize:12 * SCALE] textColor:[UIColor colorWithHexString:@"ffffff"] backColor:customColor(0, 0, 0, 0.3) textAligement:1 cornerRadius:(20 * SCALE)/2.0 text:[NSString stringWithFormat:@"1/%ld",self.data.count]];
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCell" forIndexPath:indexPath];
    cell.GoodsSubFocusModel = self.data[indexPath.item];
    
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
    
    return CGSizeMake(screenW, collectionView.frame.size.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%ld",[self class], __LINE__,indexPath.row)
    if (_myBlock) {
        _myBlock(indexPath.row);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/screenW;
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",index + 1,self.data.count];
}
- (void)setDataArr:(NSArray *)dataArr{
    self.numLabel.text = [NSString stringWithFormat:@"1/%ld",dataArr.count];
    
    self.data = dataArr;
    [self.col reloadData];
}



@end
