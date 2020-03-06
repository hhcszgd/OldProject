//
//  HBRecomentGoodShopCell.m
//  b2c
//
//  Created by 0 on 16/4/7.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HBRecomentGoodShopCell.h"
//#import "HBRecommentGoodSubCell.h"
//
//@interface HBRecomentGoodShopCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
///**布局类*/
//@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
///**滑动collectionview*/
//@property (nonatomic, strong) UICollectionView *col;
///**数据源数组*/
//@property (nonatomic, strong) NSMutableArray *dataArray;
///***/
//@property (nonatomic, strong) UIPageControl *page;
//@end
//@implementation HBRecomentGoodShopCell
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        [self configmentUI];
//    }
//    return self;
//}
///**懒加载*/
//- (UICollectionViewFlowLayout *)flowLayout{
//    if (_flowLayout == nil) {
//        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    }
//    return _flowLayout;
//}
//- (UICollectionView *)col{
//    if (_col == nil) {
//        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.contentView.bounds.size.width, self.contentView.bounds.size.height- 20) collectionViewLayout:self.flowLayout];
//        _col.delegate = self;
//        _col.dataSource = self;
//        [_col registerClass:[HBRecommentGoodSubCell class] forCellWithReuseIdentifier:@"HBRecommentGoodSubCell"];
//        _col.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:_col];
//    }
//    return _col;
//}
//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
//- (UIPageControl *)page{
//    if (_page == nil) {
//        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//        [self.contentView addSubview:_page];
//    }
//    return _page;
//}
//- (void)configmentUI{
//    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    [self.col setShowsHorizontalScrollIndicator:NO];
//    [self.col setShowsVerticalScrollIndicator:NO];
//    [self.col setScrollEnabled:YES];
//    [self.col setPagingEnabled:YES];
//    
//    
//#pragma mark -- 设置page
//    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
//        make.width.equalTo(@(100));
//        make.height.equalTo(@(20));
//    }];
//    self.page.numberOfPages = 3;
//    self.page.currentPageIndicatorTintColor = [UIColor lightGrayColor];
//    self.page.pageIndicatorTintColor = [UIColor whiteColor];
//}
//
//
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 3;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    HBRecommentGoodSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HBRecommentGoodSubCell" forIndexPath:indexPath];
//    cell.model = [NSObject new];
//    return cell;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 10;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return CGSizeMake(screenW, self.col.frame.size.height);
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger index = scrollView.contentOffset.x/screenW;
//    self.page.currentPage = index;
//}
//- (void)setModel:(id)model{
//    [self.col reloadData];
//}
@interface HBRecomentGoodShopCell()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *count;

@end
@implementation HBRecomentGoodShopCell




- (UIImageView *)img{
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
    }
    return _img;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_title configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"333333"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@""];

        [_title sizeToFit];
    }
    return _title;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price configmentfont:[UIFont systemFontOfSize:11 * SCALE] textColor:[UIColor colorWithHexString:@"ff3a30"] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_price sizeToFit];
    }
    return _price;
}
- (UILabel *)count{
    if (_count == nil) {
        _count = [[UILabel alloc] init];
        [self.contentView addSubview:_count];
        [_count configmentfont:[UIFont systemFontOfSize:10] textColor:[UIColor whiteColor] backColor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@""];
        [_count sizeToFit];
    }
    return _count;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.equalTo(@(140 * SCALE));
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.img.mas_bottom).offset(0);
        }];
        
    }
    return self;
}


- (void)setCustomModel:(CustomCollectionModel *)customModel{
    if ([customModel.img isEqualToString:@"xxxxxx"]) {
        self.img.image = [UIImage imageNamed:@"zhekouqu"];
    }else{
        NSURL *url = ImageUrlWithString(customModel.img);
        [self.img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"me"]];
    }
//    NSString *title = [NSString stringWithFormat:@"[热销]%@",customModel.full_name];
//    NSMutableAttributedString *full_name = [[NSMutableAttributedString alloc] initWithString:title];
//    [full_name addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11 * SCALE],NSFontAttributeName,[UIColor colorWithHexString:@"ff3a30"], nil] range:NSMakeRange(0, 4)];
//    [full_name addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11 * SCALE],NSFontAttributeName,[UIColor colorWithHexString:@"333333"],NSBackgroundColorAttributeName, nil], nil] range:NSMakeRange(4 , title.length - 4)];
    self.title.text = customModel.full_name;
    self.price.text = customModel.price;
    
}


@end
