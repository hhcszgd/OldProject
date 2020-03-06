//
//  HAllGoodsVC.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllGoodsVC.h"
#import "GoodsCell.h"
#define headerHeight 40
@interface HAllGoodsVC ()
/**组头*/
@property (nonatomic, strong) UIView *headerView;
/**四个按钮中之前被选中的按钮*/
@property (nonatomic, strong) UIButton *selectButton;
/**布局类loyout*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**collectionview*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**tag值，用来判断是第几组值*/
@property (nonatomic, assign) NSInteger tag;
@end

@implementation HAllGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@[@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4"],@[@"1",@"2"],@[@"1"],@[@"1",@"2",@"3",@"4"]];
    [self configmentCol];
    /**创建一个view，用来放，推荐，销量，价格，评价，四个按钮*/
    [self configmentHeaderView];
    
    // Do any additional setup after loading the view.
}
#pragma  mark --  创建一个view，用来放，推荐，销量，价格，评价，四个按钮
- (void)configmentHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, headerHeight)];
    _headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView];
    [self configmentfourButtonInHeaderView:_headerView];
    
}
- (void)configmentfourButtonInHeaderView:(UIView *)headerView{
    NSArray *array = @[@"推荐", @"销量", @"价格", @"评价"];
    CGFloat width = screenW * 1.0/array.count;
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, headerHeight)];
        [headerView addSubview:button];
        button.tag = i;
        if (i == 0) {
            [self cageGaryButton:button];
            
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
    _tag = button.tag;
    button.selected = YES;
    _selectButton.selected = NO;
    _selectButton = button;
    [self.collectionView reloadData];
    self.collectionView.contentOffset = CGPointMake(0, 0);
}
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY + headerHeight, screenW, screenH - self.startY- headerHeight) collectionViewLayout:self.flowLayout];
    }
    return _collectionView;
}

/**创建滚动视图*/
- (void)configmentCol{
    
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:@"GoodsCell"];
//    [_col registerClass:[<#CollectionReusableViewFooter#> class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"<#CollectionReusableViewFooter#>"];
//    [_col registerClass:[<#CollectionHeaderView#> class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"<#CollectionHeaderView#>"];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray[_tag] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    NSArray *arr = _dataArray[indexPath.section];
    
    cell.model = [NSObject new];
    cell.priceStr = arr[indexPath.item];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((screenW - 3 * 5)/2.0, (screenW - 3 * 5)/2.0 * 1.2);
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableView = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        <#CollectionHeaderView#> *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"<#CollectionHeaderView#>" forIndexPath:indexPath];
//        [Factory configmentLabel:header.textLabel font:15 textcolor:[UIColor blackColor] backcolor:[UIColor whiteColor] textAligement:0 cornerRadius:0 text:@"全部分类"];
//        reusableView = header;
//    }else{
//        <#CollectionReusableViewFooter#> *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"<#CollectionReusableViewFooter#>" forIndexPath:indexPath];
//        footer.backgroundColor = [UIColor lightGrayColor];
//        reusableView = footer;
//    }
//    return  reusableView;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(<#screenW#>, <#40#>);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(<#screenW#>, <#40#>);
//}



#pragma maek -- 右边消息按钮
- (void)message:(UITapGestureRecognizer *)tap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"消息")
}
#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
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
