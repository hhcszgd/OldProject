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
#import "HAllClassBaseModel.h"
#import "HAllClassFooter.h"
#import "HAllGoodsVC.h"
#define classWidth 101 *SCALE
#define classheight 46 * SCALE
#define classleft 10
#define classright 10
#define classinter (screenW-classleft-classleft- 3 * classWidth)/3.0
#define classline 15
#define classBottom 20

@interface HAllClassVC ()<UITextFieldDelegate,HAllClassHeaderDelegate>
/**布局类loyout*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**collectionview*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/**店铺id*/
@property (nonatomic, assign) NSInteger shop_id;
/**提示文字*/
@property (nonatomic, strong) UILabel *promoptLable;
/**覆盖图*/
@property (nonatomic,strong) ActionBaseView *overView;

@end

@implementation HAllClassVC
- (UILabel *)promoptLable{
    if (_promoptLable == nil) {
        _promoptLable = [[UILabel alloc] init];
        [self.view addSubview:_promoptLable];
        [_promoptLable configmentfont:[UIFont boldSystemFontOfSize:15 *SCALE] textColor:[UIColor colorWithHexString:@"999999"] backColor:[UIColor whiteColor] textAligement:1 cornerRadius:0 text:@"亲，卖家偷懒没有添加分类哟"];
    }
    return _promoptLable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];

    NSString *shopID = self.keyParamete[@"paramete"];
    self.sellerUser = self.keyParamete[@"sellerUser"];
    self.shop_id = [shopID integerValue];
    LOG(@"%@,%d,%@",[self class], __LINE__,shopID)
    //请求数据
    [self requestData];
    
    
   
    
    [self configmentCol];
    // Do any additional setup after loading the view.
}
#pragma mark -- 请求数据
- (void)requestData{
    [[UserInfo shareUserInfo] gotStoreAllClassWithShopID:self.shop_id success:^(ResponseObject *responseObject) {
        
        [self analyseData:responseObject];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
    }];
}
- (void)analyseData:(ResponseObject *)responseObject{
    NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);

    if (responseObject.data) {
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            NSArray *arr = responseObject.data;
            if (arr.count == 0) {
                self.promoptLable.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
            }else{
                for (NSDictionary *dic in responseObject.data) {
                    HAllClassBaseModel *baseModel = [HAllClassBaseModel mj_objectWithKeyValues:dic];
                    [self.dataArray addObject:baseModel];
                }
            }
            
        }
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            LOG(@"%@,%d,%@",[self class], __LINE__,@"数据结构与约定不一样")
        }
    }else{
        self.promoptLable.frame = CGRectMake(0, self.startY, screenW, screenH - self.startY);
    }
    
}
/**有选择的挑选数据加入数据源中*/
- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
    if ([key isEqualToString:@"focus"]) {
        return YES;
    }else if ([key isEqualToString:@"nav"]) {
        return YES;
    }else if ([key isEqualToString:@"active"]) {
        return YES;
    }else if ([key isEqualToString:@"coupons"]) {
        return YES;
    }else if ([key isEqualToString:@"goods"]) {
        return YES;
    }
    return NO;
}



-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}
#pragma mark -- 点击重新连接
- (void)reconnectClick:(UIButton *)sender{
    [[UserInfo shareUserInfo] gotStoreAllClassWithShopID:_shop_id success:^(ResponseObject *responseObject) {
        [self analyseData:responseObject];
        [self.collectionView reloadData];
        [self removeTheViewWhenConnect];
    } failure:^(NSError *error) {
        
    }];
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


- (void)clickTap:(ActionBaseView *)tap{
    [self.searchField resignFirstResponder];
}

/**设置col*/
- (void)configmentCol{
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HAllClassCell class] forCellWithReuseIdentifier:@"HAllClassCell"];

    [self.collectionView registerClass:[HAllClassHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HAllClassHeader"];
    [self.collectionView registerClass:[HAllClassFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HAllClassFooter"];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
   
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    HAllClassBaseModel *model = self.dataArray[section];
    NSArray *array = model.child;
    return array.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HAllClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HAllClassCell" forIndexPath:indexPath];
    HAllClassBaseModel *baseModel = self.dataArray[indexPath.section];
    HAllClassModel *subModel = baseModel.child[indexPath.row];
    cell.model = subModel;
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return classinter;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return classline;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, classleft, classBottom, classright);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(classWidth, classheight);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HAllClassBaseModel *baseModel = self.dataArray[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HAllClassHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HAllClassHeader" forIndexPath:indexPath];
        header.baseModel = baseModel;
        header.delegate = self;
        return header;
    }else{
        HAllClassFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HAllClassFooter" forIndexPath:indexPath];
        footer.backgroundColor = BackgroundGray;
        return footer;
        
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenW, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == (self.dataArray.count - 1)) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(screenW, 15 * SCALE);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"点击")
    HAllClassBaseModel *baseModel = self.dataArray[indexPath.section];
    HAllClassModel *subModel = baseModel.child[indexPath.row];
    
    self.searchField.text = @"";
    
    subModel.keyParamete = @{@"paramete":@(self.shop_id),@"classid":subModel.ID,@"className":subModel.classify_name};
    subModel.actionKey = @"HAllGoodsVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:subModel];
    
    
//    HAllClassCell *cell = (HAllClassCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    HAllClassModel *classModel = self.dataArray[indexPath.section];
//    HAllClassModel *cellModel = classModel.cellModelArr[indexPath.row];

//    cellModel.isSelected = YES;
//    cell.selected = YES;
    
}

/**条抓到*/
- (void)clickToSearchWith:(HAllClassBaseModel *)baseModel{
    baseModel.keyParamete = @{@"paramete":@(self.shop_id),@"classid":baseModel.ID,@"className":baseModel.classify_name};
    baseModel.actionKey = @"HAllGoodsVC";
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:baseModel];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchField resignFirstResponder];
}



- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"取消")
//    HAllClassCell *cell = (HAllClassCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    HAllClassModel *classModel = self.dataArray[indexPath.section];
//    HAllClassModel *cellModel = classModel.cellModelArr[indexPath.row];
//    [cell.classLabel configmentfont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] backColor:[UIColor lightGrayColor] textAligement:1 cornerRadius:6 text:cellModel.detailClass];
//    cellModel.isSelected = NO;
//    cell.selected = NO;
    
}
- (HShopSearchField *)searchField{
    if (_searchField == nil) {
        _searchField = [[HShopSearchField alloc] init];
        _searchField.delegate = self;
    }
    return _searchField;
}

- (void)configmentMidleView{
    CGSize statusHeight = [[UIApplication sharedApplication] statusBarFrame].size;
    
    self.searchField.frame = CGRectMake(46,statusHeight.height +6, screenW - 46 - 56, 33);
    self.navigationCustomView = self.searchField;
    self.searchField.sborderWidth = 1;
    self.searchField.sCornerRadius = 6;
    self.searchField.sborderColor = [UIColor colorWithHexString:@"cccccc"];
    [self.searchField configmentAttributePlaceholderFont:[UIFont systemFontOfSize:14] color:[UIColor colorWithHexString:@"010101"] placeholder:@"请您输入您想要的商品"];
    self.searchField.textAlignment = NSTextAlignmentLeft;
    self.naviTitle = nil;
    ActionBaseView *leftView =[[ActionBaseView alloc] initWithFrame:CGRectMake(0, 0, 29, self.searchField.frame.size.height)];
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, (leftView.frame.size.height - 15)/2.0, 16, 15)];
    searchImage.image = [UIImage imageNamed:@"icon_search"];
    [leftView addSubview:searchImage];
    self.searchField.leftView = leftView;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    self.searchField.keyboardType = UIKeyboardTypeDefault;
    self.searchField.returnKeyType = UIReturnKeySearch;
    
}

- (ActionBaseView *)overView{
    if (_overView == nil) {
        _overView = [[ActionBaseView alloc]initWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
        [self.view addSubview:_overView];
        [_overView addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        _overView.userInteractionEnabled = YES;
        }
    return _overView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.overView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.overView removeFromSuperview];
    self.overView = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.searchField resignFirstResponder];
    
    
    HAllGoodsVC *goodsVC = [[HAllGoodsVC alloc] init];
   
    goodsVC.keyParamete = @{@"paramete":@(self.shop_id),@"keyword":self.searchField.text,@"VCName":@"HAllClassVC"};
    [self.navigationController pushViewController:goodsVC animated:YES];
    
    
    
    return YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --
- (void)actionToSearch:(ActionBaseView *)searchView{
    LOG(@"%@,%d,%@",[self class], __LINE__,searchView)
}
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
