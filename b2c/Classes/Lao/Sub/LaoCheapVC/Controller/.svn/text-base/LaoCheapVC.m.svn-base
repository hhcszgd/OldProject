//
//  LaoCheapVC.m
//  b2c
//
//  Created by wangyuanfei on 16/4/22.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "LaoCheapVC.h"

#import "ShopCarCollectoinCell.h"


#import "HomeRefreshHeader.h"
#import "HomeRefreshFooter.h"

#import "HCellModel.h"
#import "HCellComposeModel.h"

@interface LaoCheapVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView * collectionView ;
@property(nonatomic,strong)NSMutableArray * laoCheapData ;

@property(nonatomic,assign)NSUInteger  laoStoryPageNum ;
@end

@implementation LaoCheapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.laoStoryPageNum =1;
    [self setupCollectionView];
    [self initUI];
    // Do any additional setup after loading the view.
}



-(void)initUI
{
    
    [self gotLaoCheapDataWithPageNum:self.laoStoryPageNum actionType:Init Success:^{
        if (self.laoCheapData.count>0) {
//             [self setupCollectionView];
            [self setupRefreshUI];
        }else{
            [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
        }
    } failure:^{
          [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
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
    layout.headerReferenceSize = CGSizeMake(111, 10);
    
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[ShopCarCollectoinCell class] forCellWithReuseIdentifier:@"ShopCarCollectoinCell"];
//    [collectionView registerClass:[ShopCarCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" ];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" ];
    collectionView.showsVerticalScrollIndicator=NO;
    // Do any additional setup after loading the view.
    collectionView.dataSource =self;
    collectionView.delegate = self;
    
    
}

-(void)setupRefreshUI
{
    
    
    if (self.laoCheapData.count>0) {
        if (!self.collectionView.mj_header) {
            HomeRefreshHeader * refreshHeader = [HomeRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
            self.collectionView.mj_header=refreshHeader;
        }
        if (!self.collectionView.mj_footer) {
            HomeRefreshFooter* refreshFooter = [HomeRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMore)];
            self.collectionView.mj_footer = refreshFooter;
        }
        
    }else{
        self.collectionView.mj_header=nil;
        self.collectionView.mj_footer = nil;
    }
    [self.collectionView reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.laoCheapData.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ShopCarCollectoinCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCarCollectoinCell" forIndexPath:indexPath];
    
//    cell.backgroundColor  = randomColor;
    HCellComposeModel  * model  =self.laoCheapData[indexPath.item];
    model.keyParamete = @{@"paramete":model.ID};
    cell.composeModel = model;
    return cell;
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    
}


/** 刷新回调方法 */
-(void)refreshData
{
    [super refreshData];
    self.collectionView.mj_footer.state =  MJRefreshStateIdle;
    self.laoStoryPageNum = 1;
    [self gotLaoCheapDataWithPageNum:self.laoStoryPageNum actionType:Refresh Success:^{
        
        [self.collectionView.mj_header endRefreshing];
    } failure:^{
        [self.collectionView.mj_header endRefreshing];

    }];

}
/** 加载更多的回调方法 */
-(void)LoadMore
{
    [super LoadMore];
    [self gotLaoCheapDataWithPageNum:++self.laoStoryPageNum actionType:LoadMore Success:^{
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    } failure:^{
        [self.collectionView.mj_footer endRefreshing];

    }];

}


//抽取方法
-(void)gotLaoCheapDataWithPageNum:(NSInteger)pageNum actionType:(LoadDataActionType)actionType Success:(void(^)())success failure:(void(^)())failure{
    

    
    [[UserInfo shareUserInfo] gotLaoCheapDataWithPageNum:pageNum success:^(ResponseObject *responseObject) {
        LOG(@"_%@_%d_%@",[self class] , __LINE__,responseObject.data);
        if (![responseObject.data isKindOfClass:[NSDictionary class]]) {
            LOG(@"_%@_%d_%@",[self class] , __LINE__,@"获取捞便宜数据格式有误")
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        if (actionType==0 || actionType==1) {
            [self.laoCheapData removeAllObjects];
        }
        
        NSArray * items = responseObject.data[@"items"];
        for (int k=0 ;  k < items.count; k++) {
            NSDictionary * dict = items[k];
            HCellComposeModel * composeModel = [[HCellComposeModel alloc]initWithDict:dict];
            [self.laoCheapData addObject:composeModel];
        }
        [self setupRefreshUI];
        success();
        
    } failure:^(NSError *error) {
        failure(error);
//        [self.collectionView.mj_footer endRefreshing];
        LOG(@"_%@_%d_%@",[self class] , __LINE__,error)
        [self setupRefreshUI];

    }];

}

-(void)reconnectClick:(UIButton *)sender{
    [self gotLaoCheapDataWithPageNum:1 actionType:Init Success:^{
        if (self.laoCheapData.count>0) {
            [self removeTheViewWhenConnect];
        }
    } failure:^{
        
    }];
}

-(NSMutableArray * )laoCheapData{
    if(_laoCheapData==nil){
    _laoCheapData = [[NSMutableArray alloc]init];
    }
    return _laoCheapData;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HCellComposeModel *composeModel = self.laoCheapData[indexPath.item];
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:composeModel];
}

@end
