//
//  GCSimilargoodsVC.m
//  b2c
//
//  Created by 0 on 16/4/9.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "GCSimilargoodsVC.h"


@interface GCSimilargoodsVC ()
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation GCSimilargoodsVC
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY) collectionViewLayout:self.flowLayout];
        [self.view addSubview:_col];
        _col.delegate = self;
        _col.dataSource = self;
        
    }
    return _col;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configmentNa];
    // Do any additional setup after loading the view.
}
- (void)configmentNa{
    self.naviTitle = @"相似产品";
    UIImageView *moreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shop_more"]];
    moreImageView.frame = CGRectMake(0, 0, 20, 6);
    self.navigationBarRightActionViews = @[moreImageView];
    
}


//- (void)configmentCol{
//    
//    
//    
//    self.col.backgroundColor = BackgroundGray;
//    
//    [_col registerClass:[<#DemoCollectionkankanCell#> class] forCellWithReuseIdentifier:@"<#DemoCollectionkankanCell#>"];
//    [_col registerClass:[<#CollectionReusableViewFooter#> class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"<#CollectionReusableViewFooter#>"];
//    [_col registerClass:[<#CollectionHeaderView#> class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"<#CollectionHeaderView#>"];
//    [_col setShowsVerticalScrollIndicator:NO];
//    
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return <#1#>;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return <#10#>;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    <#DemoCollectionkankanCell#> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"<#DemoCollectionkankanCell#>" forIndexPath:indexPath];
//    
//    return cell;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return <#5#>;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return <#5#>;
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(<#5#>, <#5#>, <#5#>, <#5#>);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return CGSizeMake(<#(screenW - 3 * 5)/2.0#>, <#(screenW - 3 * 5)/2.0 * 1.2)#>;
//}
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
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
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
