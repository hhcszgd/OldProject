//
//  HStoreDetailsVC.m
//  b2c
//
//  Created by 0 on 16/3/28.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//



#define storeImageViewHeight screenW/3.0
#define buttonViewHeight screenW/8.0
#define headerHeight 40
#import "UICollectionViewCell+Extension.h"
/**店铺详情页面*/
#import "HStoreDetailsVC.h"
///**全部商品*/
//#import "HAllGoodsCell.h"
///**全部分类*/
//#import "HAllClassCell.h"
///**店铺故事*/
//#import "HStoreStoryCell.h"
///**店铺介绍*/
//#import "HStoreRecommentCell.h"
///**店铺资质*/
//#import "HGloryAptitudeCell.h"
/**店铺头*/
#import "HStoreHeaderCell.h"
/**五个模块*/
#import "HStoreFiveModuleCell.h"
/**店铺活动*/
#import "HStoreActiveCell.h"
/**优惠券*/
#import "HStoreCouponCell.h"
/**分类排序*/
#import "HStoreSorterHeader.h"
/**商品*/
#import "GoodsCell.h"

@interface HStoreDetailsVC ()

/**布局类*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**滑动collectionview*/
@property (nonatomic, strong) UICollectionView *storeCol;
/**数据源数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**临时数组存放cell*/
@property (nonatomic, strong) NSArray *cellArray;
/**表头*/
@property (nonatomic, strong) UICollectionReusableView *header;
/**组头*/
@property (nonatomic, strong) UIView *headerView;
/**判断是否是第一次执行，防止_headerView重复添加*/
@property (nonatomic, assign) BOOL isFirst;
/**四个按钮中之前被选中的按钮*/
@property (nonatomic, strong) UIButton *selectButton;
/**记录被选中的按钮的下标*/
@property (nonatomic, assign) NSInteger index;

@end

@implementation HStoreDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    /**注册五个功能模块的点击方法*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fiveModuleAction:) name:@"HStoreFiveModuleCell" object:nil];
    /**四个分类排序*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fourModuleAction:) name:@"HStoreSorterHeader" object:nil];
    //初始化index
    _index = -1;

    /**创建一个view，用来放，推荐，销量，价格，评价，四个按钮*/
    [self configmentHeaderView];
    //添加数据源
    _cellArray = @[@"HStoreHeaderCell",@"HStoreFiveModuleCell",@"HStoreActiveCell",@"HStoreCouponCell",@"GoodsCell"];
    
    
    
    //背景颜色(白色)
    self.view.backgroundColor = [UIColor whiteColor];
    
    //布局UI
    [self configmentUI];
    
    
    // Do any additional setup after loading the view.
}

#pragma  mark --  创建一个view，用来放，推荐，销量，价格，评价，四个按钮
- (void)configmentHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, headerHeight)];
    _headerView.backgroundColor = [UIColor whiteColor];
    
    //排除在滚动中多次创建添加_headerView
    _isFirst = YES;
}


#pragma maek -- 右边消息按钮
- (void)message:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"消息")
}
#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
}

#pragma  mark  -- 布局UI
- (void)configmentUI{
    
    //布局collectionview
    self.storeCol.showsHorizontalScrollIndicator = NO;
    self.storeCol.showsVerticalScrollIndicator = NO;

    self.storeCol.scrollEnabled = YES;
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    

    
}



/**懒加载*/
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}
- (UICollectionView *)storeCol{
    if (_storeCol == nil) {
        _storeCol = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY , screenW, screenH - self.startY ) collectionViewLayout:self.flowLayout];
        _storeCol.delegate = self;
        _storeCol.dataSource = self;
        [_storeCol registerClass:[HStoreHeaderCell class] forCellWithReuseIdentifier:@"HStoreHeaderCell"];
        [_storeCol registerClass:[HStoreFiveModuleCell class] forCellWithReuseIdentifier:@"HStoreFiveModuleCell"];
        [_storeCol registerClass:[HStoreActiveCell class] forCellWithReuseIdentifier:@"HStoreActiveCell"];
        [_storeCol registerClass:[HStoreCouponCell class] forCellWithReuseIdentifier:@"HStoreCouponCell"];
        [_storeCol registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"GoodsCell"];
        [_storeCol registerClass:[HStoreSorterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HStoreSorterHeader"];
        [self.view addSubview:_storeCol];
    }
    return _storeCol;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



#pragma mark -- collectionview 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _cellArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 1;
    if ([_cellArray[section] isEqualToString:@"GoodsCell"]) {
        count = _index +1;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellArray[indexPath.section] forIndexPath:indexPath];
    cell.collectionView = collectionView;
    cell.model = [NSObject new];
    
    return cell;
   
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HStoreSorterHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HStoreSorterHeader" forIndexPath:indexPath];
        header.selecIndex = _index;
        _header = header;
        reusableView = header;
    }else{
        
    }
    return reusableView;
}






/**header的高度*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 0);
    if ([_cellArray[section] isEqualToString:@"GoodsCell"]) {
       size = CGSizeMake(screenW, headerHeight);
    }
    return size;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_cellArray[indexPath.section] isEqualToString:@"HStoreHeaderCell"]) {
        return CGSizeMake(screenW, storeImageViewHeight);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HStoreFiveModuleCell"]) {
        return CGSizeMake(screenW, buttonViewHeight);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HStoreActiveCell"]) {
        return CGSizeMake(screenW, screenW * 0.5);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"HStoreCouponCell"]) {
        return CGSizeMake(screenW, CouponCellHeight);
    }
    if ([_cellArray[indexPath.section] isEqualToString:@"GoodsCell"]) {
        return CGSizeMake((screenW - 5*3.0)/2.0, (screenW - 5*3.0)/2.0 * 1.3);
    }

    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets edgeInsets =  UIEdgeInsetsMake(0, 0, 0, 0);
    
    //设置goods组中的布局
    if ([_cellArray[section] isEqualToString:@"GoodsCell"]) {
        edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return edgeInsets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    CGFloat inter = 0;
    if ([_cellArray[section] isEqualToString:@"GoodsCell"]) {
        inter = 5;
    }
    return inter;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    CGFloat line = 0;
    if ([_cellArray[section] isEqualToString:@"GoodsCell"]) {
        line = 5;
    }
    return line;
}
//消失完成，
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    //开始出现
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LOG(@"%@,%d,%@",[self class], __LINE__,NSStringFromCGRect(_header.frame))
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.storeCol.contentOffset.y >= _header.frame.origin.y) {
        if (_isFirst) {
            [self.view addSubview:_headerView];
            _isFirst = NO;
            [self configmentfourButtonInHeaderView:_headerView];
        }else{
            
        }
    }else{
        for (UIView *view in _headerView.subviews) {
            [view removeFromSuperview];
        }
        [_headerView removeFromSuperview];
        _isFirst = YES;
    }
    
}
- (void)configmentfourButtonInHeaderView:(UIView *)headerView{
    NSArray *array = @[@"推荐", @"销量", @"价格", @"评价"];
    CGFloat width = screenW * 1.0/array.count;
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, headerHeight)];
        [headerView addSubview:button];
        button.tag = i;
        if (_index == i) {
            _index = button.tag;
            button.selected = YES;
            _selectButton.selected = NO;
            _selectButton = button;
            
        }
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(cageGaryButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    }
    
}
#pragma mark -- 模块分类的点击方法
- (void)cageGaryButton:(UIButton *)button{
    if (_selectButton == button) {
        return;
    }
    _index = button.tag;
    button.selected = YES;
    _selectButton.selected = NO;
    _selectButton = button;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:_cellArray.count-1];
    [UIView animateWithDuration:0.3 animations:^{
        [self.storeCol reloadSections:indexSet];
    } completion:^(BOOL finished) {
        self.storeCol.contentOffset = CGPointMake(0, _header.frame.origin.y);
    }];
    
    
}
#pragma mark --  四个模块分类
- (void)fourModuleAction:(NSNotification *)notification{
    _index = [notification.userInfo[@"index"] integerValue];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:_cellArray.count-1];
    [self.storeCol reloadSections:indexSet];
    
    
    
}


/*
#pragma mark -- 点击到五个功能模块
- (void)fiveModuleAction:(NSNotification *)notificatin{
    NSInteger tag = [notificatin.userInfo[@"tag"] integerValue];
    switch (tag) {
        case 0:
        {
            [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HAllGoodsVC"];
        }
            break;
        case 1:
        {
            [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HAllClassVC"];
        }
            break;
        case 2:
        {
            [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HStoreStoryVC"];
        }
            break;
        case 3:
        {
            [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HStoreRecommentVC"];
        }
            break;
        case 4:
        {
            [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"HGloryAptitudeVC"];
        }
            break;
        default:
            break;
    }
}
*/
- (void)dealloc{
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HStoreFiveModuleCell" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HStoreSorterHeader" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
