//
//  HFactorySellVC.m
//  b2c
//
//  Created by 0 on 16/5/1.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HFactorySellVC.h"
#import "HFactoryBaseCell.h"
/**baner*/
#import "FactorySellCell.h"
/**组头*/
#import "ReusableViewHeader.h"
/**热门品牌*/
#import "HFSHotBrandCell.h"
/**超值特卖*/
#import "HFSOverflowSellCell.h"
/**优质厂家推荐*/
#import "HFSHighSellerCommentCell.h"
/**优惠券*/
#import "HFSCouponCell.h"
#import "HFactoryBaseModel.h"
#import "HFactorySellModel.h"
#import "CustomCollectionModel.h"

/**商品*/
#import "HFGuessYouLikeCell.h"
@interface HFactorySellVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *col;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**临时数组存放cell*/
@property (nonatomic, strong) NSArray *cellArray;
/**优惠券的宽度*/
@property (nonatomic, assign) CGFloat w;
/**优惠券的高度*/
@property (nonatomic, assign) CGFloat h;




@end

@implementation HFactorySellVC
/**懒加载*/
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY , screenW, screenH - self.startY ) collectionViewLayout:self.flowLayout];
        _col.delegate = self;
        _col.dataSource = self;
#warning 告诉楚天修改key值。
        
        
        [_col registerClass:[FactorySellCell class] forCellWithReuseIdentifier:@"FactorySellCell"];
        [_col registerClass:[HFSHotBrandCell class] forCellWithReuseIdentifier:@"HFSHotBrandCell"];
        [_col registerClass:[HFSOverflowSellCell class] forCellWithReuseIdentifier:@"HFSOverflowSellCell"];
        [_col registerClass:[HFSHighSellerCommentCell class] forCellWithReuseIdentifier:@"HFSHighSellerCommentCell"];
        [_col registerClass:[HFSCouponCell class] forCellWithReuseIdentifier:@"HFSCouponCell"];
        [_col registerClass:[HFGuessYouLikeCell class] forCellWithReuseIdentifier:@"HFGuessYouLikeCell"];
        [_col registerClass:[ReusableViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader"];
        [self.view addSubview:_col];
    }
    return _col;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    _cellArray = @[@"FactorySellCell",@"HFSHotBrandCell",@"HFSOverflowSellCell",@"HFSHighSellerCommentCell",@"HFSCouponCell",@"HFGuessYouLikeCell"];
    [[UserInfo shareUserInfo] gotFactorySellsuccess:^(ResponseObject *response) {
        LOG(@"%@,%d,%@",[self class], __LINE__,response.data)
        for (NSDictionary *dic in response.data) {
            HFactoryBaseModel *factoryModel = [HFactoryBaseModel mj_objectWithKeyValues:dic];
           
            [self.dataArray addObject:factoryModel];
            
        }
       [self.col reloadData];
        
        
        
    } failure:^(NSError *error) {
        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
    }];
    
    
    CGFloat width = (screenW- 1)/2.0;
    _w = width;
    CGFloat height = width * 151/374;
    _h = height;
    
    [self configmentUI];
    
}
- (void)configmentNavigation{
    //导航栏颜色
    self.navigationBarColor = customColor(253, 253, 253, 1);
    
    //右边搜索按钮
    //    UIImageView *searchBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 28)];
    //    searchBtn.image  =[UIImage imageNamed:@"shop_main_category"];
    //    searchBtn.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(search:)];
    //    [searchBtn addGestureRecognizer:searchTap];
    //右边消息按钮
    UIImageView *messageBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    messageBtn.image  =[UIImage imageNamed:@"shop_iconfont-message"];
    messageBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(message:)];
    [messageBtn addGestureRecognizer:messageTap];
    self.navigationBarRightActionViews = @[messageBtn];
    
    
    
}




- (void)configmentMidleView{
    self.naviTitle = @"厂家直销";
    
}

#pragma maek -- 右边消息按钮
- (void)message:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"消息")
}
#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
}



#pragma mark --  底层主视图
- (void)configmentUI{
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.col setScrollEnabled: YES];
    [self.col setShowsVerticalScrollIndicator:NO];
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([_cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]) {
        HFactoryBaseModel *model = self.dataArray[section];
        return model.items.count;
    }
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HFactoryBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellArray[indexPath.section] forIndexPath:indexPath];
    if ([_cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
        HFactoryBaseModel *model = self.dataArray[indexPath.section];
        cell.customModel = model.items[indexPath.row];
        
    }else{
        cell.factoryModel = self.dataArray[indexPath.section];
    }
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([_cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]) {
        
        return 10;
    }
    return 0;
}
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if ([_cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]) {
        
        return 10;
    }
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([_cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]) {
        
        return UIEdgeInsetsMake(0, 5, 5, 5);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cellArray[indexPath.section] isEqualToString:@"FactorySellCell"]) {
        return CGSizeMake(screenW, screenW * 0.6);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HFSHotBrandCell"]) {
        return CGSizeMake(screenW, screenW * 0.5);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HFSOverflowSellCell"]) {
        return CGSizeMake(screenW, screenW * 0.35);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HFSHighSellerCommentCell"]) {
        return CGSizeMake(screenW, 0.5 * screenW);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HFSCouponCell"]) {
        
        HFactoryBaseModel *model = self.dataArray[indexPath.section];
        NSInteger row = 0;
        if (model.items.count%2 == 0) {
            row = model.items.count/2;
        }else{
            row = (model.items.count + 1)/2;
        }
        return CGSizeMake(screenW, _h * row);
    }
    
    if ([_cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
        return CGSizeMake((screenW - 3*10)/2.0, 234 );
    }
    
    return CGSizeMake(0, 0);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ReusableViewHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader" forIndexPath:indexPath];
        if ([_cellArray[indexPath.section] isEqualToString:@"HFSHotBrandCell"]) {
            header.title = @"热门品牌";
        }
        
        if ([_cellArray[indexPath.section] isEqualToString:@"HFSOverflowSellCell"]) {
            header.title = @"超值特卖";
        }
        if ([_cellArray[indexPath.section] isEqualToString:@"HFSHighSellerCommentCell"]) {
            header.title = @"优质厂家推荐";
        }
        if ([_cellArray[indexPath.section] isEqualToString:@"HFSCouponCell"]) {
            header.title = @"优惠券";
        }
        if ([_cellArray[indexPath.section] isEqualToString:@"HFGuessYouLikeCell"]) {
            header.title = @"猜你喜欢";
        }
        reusableView = header;
    }else{
        //        <#CollectionReusableViewFooter#> *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"<#CollectionReusableViewFooter#>" forIndexPath:indexPath];
        //        footer.backgroundColor = [UIColor lightGrayColor];
        //        reusableView = footer;
    }
    return  reusableView;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(<#screenW#>, <#40#>);
//}
//
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 0);
    if ([_cellArray[section] isEqualToString:@"HFSHotBrandCell"]) {
        size = CGSizeMake(screenW, 40);
    }
    if ([_cellArray[section] isEqualToString:@"HFSOverflowSellCell"]) {
        size = CGSizeMake(screenW, 40);
    }
    if ([_cellArray[section] isEqualToString:@"HFSHighSellerCommentCell"]) {
        size = CGSizeMake(screenW, 40);
    }
    if ([_cellArray[section] isEqualToString:@"HFSCouponCell"]) {
        
        size = CGSizeMake(screenW, 40);
    }
    if ([_cellArray[section] isEqualToString:@"HFGuessYouLikeCell"]) {
        
        size = CGSizeMake(screenW, 40);
    }
    return size;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end