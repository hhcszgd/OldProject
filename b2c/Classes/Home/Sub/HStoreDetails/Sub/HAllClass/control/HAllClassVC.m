//
//  HAllClassVC.m
//  b2c
//
//  Created by 0 on 16/3/31.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllClassVC.h"
/**组头*/
#import "HAllClassHeader.h"
/**详细分类*/
#import "HAllClassCell.h"
/**模型*/
#import "HAllClassModel.h"

@interface HAllClassVC ()
/**布局类loyout*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**collectionview*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HAllClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i = 0; i < 5; i++) {
        HAllClassModel *model = [[HAllClassModel alloc] init];
        model.sectionTitle = @"孕婴妈妈";
        NSInteger count =arc4random()%10+ 5;
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger j = 0; j < count; j++) {
            HAllClassModel *cellModel = [[HAllClassModel alloc] init];
            cellModel.detailClass = [NSString stringWithFormat:@"%ld/%ld",i,j];
            cellModel.isSelected = NO;
            [array addObject:cellModel];
        }
        model.cellModelArr = array;
        [self.dataArray addObject:model];
    }
    [self configmentCol];
    // Do any additional setup after loading the view.
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY , screenW, screenH - self.startY) collectionViewLayout:self.flowLayout];
    }
    return _collectionView;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/**设置col*/
- (void)configmentCol{
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HAllClassCell class] forCellWithReuseIdentifier:@"HAllClassCell"];

    [self.collectionView registerClass:[HAllClassHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HAllClassHeader"];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    HAllClassModel *model = self.dataArray[section];
    NSArray *array = model.cellModelArr;
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HAllClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HAllClassCell" forIndexPath:indexPath];
    HAllClassModel *classModel = self.dataArray[indexPath.section];
    HAllClassModel *cellModel = classModel.cellModelArr[indexPath.row];
    if (cell.selected) {
        [cell.classLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] backColor:[UIColor redColor] textAligement:1 cornerRadius:6 text:cellModel.detailClass];
    }else{
        [cell.classLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor lightGrayColor] textAligement:1 cornerRadius:6 text:cellModel.detailClass];
    }
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((screenW - 4*10)/3.0, 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HAllClassModel *model = self.dataArray[indexPath.section];
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HAllClassHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HAllClassHeader" forIndexPath:indexPath];
        header.model = model;
        reusableView = header;
    }else{
//        <#CollectionReusableViewFooter#> *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"<#CollectionReusableViewFooter#>" forIndexPath:indexPath];
//        footer.backgroundColor = [UIColor lightGrayColor];
//        reusableView = footer;
    }
    return  reusableView;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(screenW, 40);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenW, 40);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"点击")
    HAllClassCell *cell = (HAllClassCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    HAllClassModel *classModel = self.dataArray[indexPath.section];
    HAllClassModel *cellModel = classModel.cellModelArr[indexPath.row];
//    [cell.classLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] backColor:[UIColor redColor] textAligement:1 cornerRadius:6 text:cellModel.detailClass];
    cellModel.isSelected = YES;
    cell.selected = YES;
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"取消")
    HAllClassCell *cell = (HAllClassCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    HAllClassModel *classModel = self.dataArray[indexPath.section];
    HAllClassModel *cellModel = classModel.cellModelArr[indexPath.row];
//    [cell.classLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor lightGrayColor] textAligement:1 cornerRadius:6 text:cellModel.detailClass];
    cellModel.isSelected = NO;
    cell.selected = NO;
    
}
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
