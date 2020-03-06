//
//  ClassifyCollectVC.m
//  b2c
//
//  Created by 0 on 16/4/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ClassifyCollectVC.h"
#import "ClassifyCHeader.h"
#import "MJExtension.h"
#import "ClassifyFirstLevelModel.h"
#import "CThreeLevelCell.h"
#import "ClistOfGoodsVC.h"
/**行间距*/
#define rowInerval 1
/**列间距*/
#define lineInterval 1


@interface ClassifyCollectVC ()
/**二级分类数组*/
@property (nonatomic, strong) NSMutableArray *detailCategoryList;
/**用来储存数据的数组*/
@property (nonatomic, strong) NSMutableArray *detailOperations;
/**flowLayout*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat headerWidth;
@property (nonatomic, strong) NSArray *dataArray;



@end

@implementation ClassifyCollectVC


#pragma mark - 懒加载
- (NSMutableArray *)detailCategoryList {
    if (_detailCategoryList == nil) {
        _detailCategoryList = [NSMutableArray array];
    }
    return _detailCategoryList;
}

- (NSMutableArray *)detailOperations {
    if (_detailOperations == nil) {
        _detailOperations = [NSMutableArray array];
    }
    return _detailOperations;
}

#pragma mark - 初始化
- (instancetype)init {
    
    
    __weak typeof(self) Myself = self;
    [[UserInfo shareUserInfo] gotClassifySuccess:^(ResponseObject *response) {
        ClassifyTwoThreelevelModel *twoThreeModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:response.data[1]];
        ClassifyTwoThreelevelModel *model = twoThreeModel.items[0];
        LOG(@"%@,%d,%@",[self class], __LINE__,model.pid)
        [self.detailOperations removeAllObjects];
        [self.detailOperations addObject:twoThreeModel];

        [Myself.detailCategoryList removeAllObjects];
        [Myself.detailCategoryList addObjectsFromArray:twoThreeModel.items];
        
        
        
        [Myself.collectionView reloadData];
    } failure:^(NSError *error) {
        LOG(@"%@,%d,%@",[self class], __LINE__,error)
    }];

    return [super initWithCollectionViewLayout:self.flowLayout];
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
    }
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return _flowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categaryClick:) name:@"categary" object:nil];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CThreeLevelCell class] forCellWithReuseIdentifier:@"CThreeLevelCell"];
    [self.collectionView registerClass:[ClassifyCHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyCHeader"];
    self.collectionView.bounces = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
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

#pragma mark <UICollectionViewDataSource>

#pragma mark 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.detailCategoryList.count;
}

#pragma mark 每组有多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ClassifyTwoThreelevelModel *twolevelModel =  self.detailCategoryList[section];
    
    return twolevelModel.items.count;
}
#pragma mark cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CThreeLevelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CThreeLevelCell" forIndexPath:indexPath];
    // 取出模型数据
    
    cell.backgroundColor = [UIColor whiteColor];
    ClassifyTwoThreelevelModel *twoModel = self.detailCategoryList[indexPath.section];
    ClassifyTwoThreelevelModel *threeLevelModel = twoModel.items[indexPath.row];
    
    cell.levelModel = threeLevelModel;
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return rowInerval;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return lineInterval;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((collectionView.frame.size.width - 2 * lineInterval)/3.0, 110 * SCALE);
}
#pragma mark 附加控件长什么样
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    ClassifyTwoThreelevelModel *twoLevelModel = self.detailCategoryList[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        ClassifyCHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyCHeader" forIndexPath:indexPath];
        headerView.twoLevelStr = twoLevelModel.classify_name;
        reusableView = headerView;
    }
    
    // 取出模型数据
    reusableView.backgroundColor = [UIColor clearColor];
    return reusableView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.frame.size.width, 42 * SCALE);
}
#pragma mark - <UICollectionViewDelegate>
#pragma mark -- 点击三级分类取模型跳转商品列表页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //取的组
    ClassifyTwoThreelevelModel *twoLevelModel = self.detailCategoryList[indexPath.section];
    //取组里面的数据
    ClassifyTwoThreelevelModel *threeLevelModel = twoLevelModel.items[indexPath.row];
    

    
    ClistOfGoodsVC *clistVC = [[ClistOfGoodsVC alloc] init];
    clistVC.classifyID = 3102;
    [self.navigationController pushViewController:clistVC animated:YES];
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:nil action:@"ClistOfGoodsVC"];
    
}

- (void)categaryClick:(NSNotification *)notification{
    
    [self.detailCategoryList removeAllObjects];
    //bool属性，判断存储数组里面有没有对应id的模型
    BOOL isHave = NO;
   
    
    NSInteger ID = [notification.userInfo[@"classID"] integerValue];
    
    //如果已经存在在数组中就从数组中去，不存在的话就请求
 
        for (NSInteger i = 0; i < self.detailOperations.count; i++) {
            ClassifyTwoThreelevelModel *levelModel = self.detailOperations[i];
            
            ClassifyTwoThreelevelModel *levelTwoModel = levelModel.items[0];
            
            
            if ([levelTwoModel.pid isEqualToString:notification.userInfo[@"classID"]]) {
                [self.detailCategoryList removeAllObjects];
//
                [self.detailCategoryList addObjectsFromArray:levelModel.items];
                [self.collectionView reloadData];
                LOG(@"%@,%d,%@",[self class], __LINE__,@"取数据")
                NSIndexPath *topIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                [self.collectionView scrollToItemAtIndexPath:topIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
                self.collectionView.contentOffset = CGPointMake(0, 0);
                isHave = YES;
               
            }else{
//                isHave = NO;
                
                
                
                
                
                
            }
        }
    //数组中没有存相关的数据那么就进行请求
    if (!isHave) {
        [[UserInfo shareUserInfo] gotSubClassifyWithClassID:ID success:^(ResponseObject *response) {
            ClassifyTwoThreelevelModel *levelModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:response.data[1]];
            
            //将其放在储存数据的数组中
            [self.detailOperations addObject:levelModel];
            //清空数据源数组
            [self.detailCategoryList removeAllObjects];
            [self.detailCategoryList addObjectsFromArray:levelModel.items];
            [self.collectionView reloadData];
            NSIndexPath *topIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:topIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            self.collectionView.contentOffset = CGPointMake(0, 0);
        } failure:^(NSError *error) {
            LOG(@"%@,%d,%@",[self class], __LINE__,error)
        }];
    }
    
    
    
    
    
    
   
    
    
    
}


@end
