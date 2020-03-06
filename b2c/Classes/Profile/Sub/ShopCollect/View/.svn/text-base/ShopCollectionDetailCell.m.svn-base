//
//  ShopCollectionDetailCell.m
//  TTmall
//
//  Created by 0 on 16/3/20.
//  Copyright © 2016年 Footway tech. All rights reserved.
//

#import "ShopCollectionDetailCell.h"
#import "ShopColDetCollectionCell.h"
#import "SCCellSubModel.h"

@interface ShopCollectionDetailCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) UICollectionViewFlowLayout *layout;
@property (nonatomic, copy) UICollectionView *col;
@property (nonatomic, copy) NSMutableArray *dataArray;

@end


@implementation ShopCollectionDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(screenW));
            make.height.equalTo(@(140));
        }];
       
        [self configmentCol];
    }
    return self;
}
- (UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}

- (UICollectionView *)col{
    if (_col == nil) {
         _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) collectionViewLayout:self.layout];
        [self.contentView addSubview:_col];
    }
    return _col;
}




- (void)configmentCol{
    
   
    [self.col mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
         make.width.equalTo(@(screenW));
        make.height.equalTo(@(140));
    }];
    [self.layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.col.backgroundColor = customColor(234, 234, 234, 1);
    self.col.delegate = self;
    self.col.dataSource = self;
    [self.col registerClass:[ShopColDetCollectionCell class] forCellWithReuseIdentifier:@"ShopColDetCollectionCell"];
   
    [self.col setShowsHorizontalScrollIndicator:NO];
    
    
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopColDetCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopColDetCollectionCell" forIndexPath:indexPath];
   
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.contentView.bounds.size.height- 20 )/1.2, self.contentView.bounds.size.height-20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SCCellSubModel *model = self.dataArray[indexPath.row];
#pragma mark  跳转到商品详情页面
    if (_shopCollectionDetailBlock) {
        _shopCollectionDetailBlock(model);
    }
    
}

- (void)setData:(NSArray *)data{
    
    self.dataArray = [data mutableCopy];
    [self.col reloadData];
    [self.col setContentOffset:CGPointMake(0, 0)];
}

-(void)dealloc{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"dealloc")
}
@end
