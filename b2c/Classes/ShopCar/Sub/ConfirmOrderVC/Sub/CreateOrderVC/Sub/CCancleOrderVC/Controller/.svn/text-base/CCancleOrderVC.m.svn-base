//
//  CCancleOrderVC.m
//  b2c
//
//  Created by 0 on 16/5/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "CCancleOrderVC.h"
#import "CCancleOrderHeader.h"
#import "ShopCarCollectoinCell.h"


#import "HomeRefreshHeader.h"
#import "HomeRefreshFooter.h"

#import "HCellModel.h"
#import "HCellComposeModel.h"

@interface CCancleOrderVC ()<UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CCancleOrderHeaderDelegate>
@property(nonatomic,weak)UICollectionView * collectionView ;
@property(nonatomic,strong)NSMutableArray * guessLikeData ;

@property(nonatomic,assign)NSUInteger  guessLikePageNum ;
@end

@implementation CCancleOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle =@"订单详情";
    [self setupCollectionView];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self gotGuessLikeDataWithPageNum:1 actionType:Init Success:^{
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
    
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(110,300, 111, 222) collectionViewLayout:layout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    LOG(@"%@,%d,%@",[self class], __LINE__,NSStringFromCGRect(collectionView.frame))
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[ShopCarCollectoinCell class] forCellWithReuseIdentifier:@"ShopCarCollectoinCell"];
    [collectionView registerClass:[CCancleOrderHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" ];
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
    
    [self gotGuessLikeDataWithPageNum:1 actionType:Refresh Success:^{
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
    
    [self gotGuessLikeDataWithPageNum:self.guessLikePageNum actionType:LoadMore Success:^{
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } failure:^{
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}
//抽取方法
-(void)gotGuessLikeDataWithPageNum:(NSInteger)pageNum actionType:(LoadDataActionType)actionType Success:(void(^)())success failure:(void(^)())failure{
    
    [[UserInfo shareUserInfo] gotGuessLikeDataWithChannel_id:@"97" PageNum:++self.guessLikePageNum success:^(ResponseObject *responseObject) {
        LOG(@"%@,%d,%@",[self class], __LINE__,responseObject.data)
        if (![responseObject.data isKindOfClass:[NSDictionary class]]) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"返回数据类型不是字典")
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
    
    CCancleOrderHeader *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        reusableview= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableview.titleLbale.text = @"您的订单已取消";
        reusableview.subTitle.text = @"要不咱们接着逛逛";
        reusableview.delegate = self;
    }
    
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenW, 160);
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ShopCarCollectoinCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCarCollectoinCell" forIndexPath:indexPath];
    
//    cell.backgroundColor  = randomColor;
    cell.composeModel = self.guessLikeData[indexPath.item];
    return cell;
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = CGRectMake(0 ,self.startY, screenW, screenH - self.startY) ;
    
}

-(NSMutableArray * )guessLikeData{
    if(_guessLikeData==nil){
        _guessLikeData = [[NSMutableArray alloc]init];
    }
    return _guessLikeData;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HCellComposeModel *composeModel = self.guessLikeData[indexPath.item];
    composeModel.keyParamete = @{@"paramete":composeModel.ID};
    composeModel.actionKey = @"HGoodsVC";
    //用首页的跳转方法
    [[SkipManager shareSkipManager]skipByVC:self withActionModel:composeModel];
    //        [[SkipManager shareSkipManager] skipForHomeByVC:self withActionModel:composeModel];
    
    
}

- (void)CCancleOrderHeaderBackRootVC{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [[KeyVC shareKeyVC] skipToTabbarItemWithIndex:0];
    
}


-(void)navigationBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}



@end
