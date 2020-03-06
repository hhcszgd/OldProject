//
//  ShopCarEmptyVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/18.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ShopCarEmptyVC.h"
#import "ShopCarCollectionHeader.h"
#import "ShopCarCollectoinCell.h"


#import "HomeRefreshHeader.h"
//@import HomeRefreshHeader ;
#import "HomeRefreshFooter.h"

#import "HCellModel.h"
#import "HCellComposeModel.h"

#import "HomeNavigationVC.h"
#import "b2c-Swift.h"

#import "ShopCarNavigationVC.h"

@interface ShopCarEmptyVC ()<UICollectionViewDelegate , UICollectionViewDataSource,ShopCarEmptyCollectionHeaderDelegate>
@property(nonatomic,weak)UICollectionView * collectionView ;
@property(nonatomic,strong)NSMutableArray * guessLikeData ;

@property(nonatomic,assign)NSUInteger  guessLikePageNum ;
@end

@implementation ShopCarEmptyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    self.guessLikePageNum = 1 ;
    [self gotGuessLikeDataWithPageNum:self.guessLikePageNum actionType:Init Success:^{
        [self.collectionView reloadData];
        
    } failure:^{
        
    }];

}
-(void)setupCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    CGFloat toScreenMargin = 10 ;
    CGFloat itemMargin = toScreenMargin;
    CGFloat itemW = (screenW-2*toScreenMargin-itemMargin)/2;
    CGFloat itemH = 243*SCALE;
    layout.minimumLineSpacing = itemMargin;//行间距
    layout.minimumInteritemSpacing = 0;//列间距
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.sectionInset = UIEdgeInsetsMake(0, toScreenMargin, 0, toScreenMargin);
    layout.headerReferenceSize = CGSizeMake(320, 200);
    
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[ShopCarCollectoinCell class] forCellWithReuseIdentifier:@"ShopCarCollectoinCell"];
    [collectionView registerClass:[ShopCarCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" ];
    
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" ];
    collectionView.showsVerticalScrollIndicator=NO;
    // Do any additional setup after loading the view.
    collectionView.dataSource =self;
    collectionView.delegate = self;
    [self setupRefreshUI];

}

-(void)setupRefreshUI
{

        HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        self.collectionView.mj_header=refreshHeader;
        HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
        self.collectionView.mj_footer = refreshFooter;

    [self.collectionView reloadData];

}

/** 刷新回调方法 */
-(void)refreshData
{
    [super refreshData];
    if ([self.delegate respondsToSelector:@selector(shopCarDataHasChanged:)]) {
        [self.delegate shopCarDataHasChanged:self];
        //        self.theFirstAfterRefresh = YES;
    }
    self.collectionView.mj_footer.state =  MJRefreshStateIdle ;//MJRefreshStateIdle;
    self.guessLikePageNum = 1 ;
    [self gotGuessLikeDataWithPageNum:self.guessLikePageNum actionType:Refresh Success:^{
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    } failure:^{
        [self.collectionView.mj_header endRefreshing];
    }];
}

/** 加载更多的回调方法 */
-(void)LoadMore
{
    [super LoadMore];
    
    [self gotGuessLikeDataWithPageNum:++self.guessLikePageNum actionType:LoadMore Success:^{
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } failure:^{
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}
//抽取方法
-(void)gotGuessLikeDataWithPageNum:(NSInteger)pageNum actionType:(LoadDataActionType)actionType Success:(void(^)())success failure:(void(^)())failure{
    
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"0" PageNum:pageNum success:^(ResponseObject *responseObject) {
        if (![responseObject.data isKindOfClass:[NSDictionary class]]) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"返回数据类型不是字典")
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        if (actionType==0 || actionType==1) {
            [self.guessLikeData removeAllObjects];
        }
        
        NSArray * items = responseObject.data[@"items"];
        
        for (int k=0 ;  k < items.count; k++) {
            NSDictionary * dict = items[k];
            HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:dict];
            [self.guessLikeData addObject:composeModel];
        }
//        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        success();
    } failure:^(NSError *error) {
        failure();
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.guessLikeData.count;

}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        ShopCarCollectionHeader * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.delegate = nil ;
        header.delegate = self;
        reusableview = header;
    }
//    else{
//        reusableview = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
//    }
    
    return reusableview;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ShopCarCollectoinCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCarCollectoinCell" forIndexPath:indexPath];
    
//    cell.backgroundColor  = randomColor;
    cell.composeModel = self.guessLikeData[indexPath.item];
    return cell;

}
/** 点击去逛逛代理 */

-(void)seeMoreWithHeader:(ShopCarCollectionHeader*)header {
    LOG(@"_%@_%d_............................................%@",[self class] , __LINE__,self.navigationController);
    
//    if ([self.navigationController isKindOfClass:[HomeNavigationVC class]]) {
//        [self.view removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        [self.navigationController popToRootViewControllerAnimated:YES ];
    } completion:^(BOOL finished) {
//        [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:0];
        [[GDKeyVC share] selectChildViewControllerIndexWithIndex:0];

    }];
//    [self.navigationController popToRootViewControllerAnimated:YES ];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
//        [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:0];
//    });
//    }else if([self.navigationController isKindOfClass:[ShopCarNavigationVC class]]){
    
//    }
    
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    
}

-(NSMutableArray * )guessLikeData{
    if(_guessLikeData==nil){
        _guessLikeData = [[NSMutableArray alloc]init];
    }
    return _guessLikeData;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HCellComposeModel *composeModel = self.guessLikeData[indexPath.item];
    composeModel.keyParamete=@{@"paramete":composeModel.ID};
    //用首页的跳转方法
    [[SkipManager shareSkipManager]skipByVC:self withActionModel:composeModel];
//        [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:composeModel];
    

}
@end
