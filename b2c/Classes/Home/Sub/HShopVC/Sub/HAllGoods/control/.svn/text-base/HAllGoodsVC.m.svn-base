//
//  HAllGoodsVC.m
//  b2c
//
//  Created by 0 on 16/3/30.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HAllGoodsVC.h"
#import "CSearchBtn.h"

#import "ClistTopBtn.h"
#import "ClistChngeUIBtn.h"
#import "CustomFRefresh.h"
#import "HStoreDetailModel.h"
#import "HStoreSubModel.h"
#import "ClistOfGoodsBlockCell.h"
#import "CListOfGoodsBarCell.h"
#import "HAllClassVC.h"
#define widthOfchangUIBtn 55 * SCALE
@interface HAllGoodsVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/**btn上一个被选中的按钮*/
@property (nonatomic, strong) UIButton *beforselectButton;
@property (nonatomic, strong) UICollectionView *col;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**cell的标示符*/
@property (nonatomic, copy) NSString *cellID;

/**推荐数据*/
@property (nonatomic, strong) NSMutableArray *dataArr;
/**销量*/
@property (nonatomic, strong) NSMutableArray *salesVolumeArr;
/**价格*/
@property (nonatomic, strong) NSMutableArray *evaluateArr;
/**分页*/
@property (nonatomic, assign) NSInteger pageNumber;
/**排序方式*/
@property (nonatomic, assign) NSInteger sort;
/**价格是否按照从高到低的熟悉排序*/
@property (nonatomic, assign) BOOL isLowToHeight;

@property (nonatomic, copy) NSString *sortOrder;

@property (nonatomic, weak) CSearchBtn *search;
/**分类查询用到的id*/
@property (nonatomic, copy) NSString *classid;

/**改变UI按钮*/
@property (nonatomic, strong) ClistChngeUIBtn *changeBtn;
/**提示文字*/
@property (nonatomic, strong) UIImageView *promoptImg;

@end

@implementation HAllGoodsVC

- (UIImageView *)promoptImg{
    if (_promoptImg == nil) {
        _promoptImg = [[UIImageView alloc] init];
        [self.view addSubview:_promoptImg];
        _promoptImg.backgroundColor = [UIColor whiteColor];
        NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"];
        NSString * imgPath2x = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"kongkong@2x" ofType:@"png" inDirectory:@"Image"];
        NSString *imgPath3x = [[NSBundle bundleWithPath:strResourcesBundle] pathForResource:@"kongkong@3x" ofType:@"png" inDirectory:@"Image"];
        CGFloat scale = [UIScreen mainScreen].scale;
        NSLog(@"%@, %d ,%f",[self class],__LINE__,scale);
        if (scale == 2.0) {
            _promoptImg.image = [UIImage imageWithContentsOfFile:imgPath2x];
        }else{
            _promoptImg.image = [UIImage imageWithContentsOfFile:imgPath3x];
        }
        
        _promoptImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _promoptImg;
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
        
    }
    return _dataArr;
}
- (NSMutableArray *)salesVolumeArr{
    if (_salesVolumeArr == nil) {
        _salesVolumeArr = [[NSMutableArray alloc] init];
    }
    return _salesVolumeArr;
}
- (NSMutableArray *)evaluateArr{
    if (_evaluateArr == nil) {
        _evaluateArr = [[NSMutableArray alloc] init];
    }
    return _evaluateArr;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self configmentNavagation];
    //点击价格按钮的时候默认从低到高的排序
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(messageCountChanged) name:MESSAGECOUNTCHANGED object:nil];

    self.shop_id = self.keyParamete[@"paramete"];
    self.sellerUser = self.keyParamete[@"sellerUser"];

    
    self.isLowToHeight = YES;
    self.pageNumber = 1;
    self.sort = 0;
    self.sortOrder = classifyDesc;
    //默认从推荐开始
    [self configmentCategary];
    [self configmentMainUI];
    
    [self requestData:^(ResponseObject *responseObject) {
    
        [self cleanDataArray];
        [self analyseDataWith:responseObject];
    } failure:^{
        [self showUnconnectView];
    }];
    
    
    // Do any additional setup after loading the view.
}
- (void)requestData:(void (^)(ResponseObject *responseObject))success failure:(void(^)())failure{
    //包含关键字且关键字不是空
    if ([self.keyParamete objectForKey:@"keyword"] && ![self.keyParamete[@"keyword"] isEqualToString:@""]) {
        //根据关键字查询数据
        self.search.titleStr = self.keyParamete[@"keyword"];
        [[UserInfo shareUserInfo] gotShopSearchDataWithShopID:self.shop_id keyword:self.keyParamete[@"keyword"] page:self.pageNumber sort:self.sort sortOrder:self.sortOrder success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure();
        }];
        
    }else if ([self.keyParamete objectForKey:@"shangxin"]) {
        
        [[UserInfo shareUserInfo] gotShopShangXinWithStoreID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *reponseObject) {
            success(reponseObject);
        } failure:^(NSError *error) {
            failure();
            
        }];
        
    }else if ([self.keyParamete objectForKey:@"classid"]) {
        self.search.titleStr = self.keyParamete[@"className"];
        self.classid = self.keyParamete[@"classid"];
        [[UserInfo shareUserInfo] gotShopGoodsDataWithClassID:self.classid sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseOnject) {
            success(responseOnject);
        } failure:^(NSError *error) {
            failure();
        }];
    }else{
        //没有相应的键值，那么请求全部商品的数据
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure();
        }];

    }

}


#pragma mark -- 点击不同的分类的时候清空数组
- (void)cleanDataArray{
    if (self.pageNumber == 1) {
        [self.dataArr removeAllObjects];
    }
}



#pragma mark -- 设置导航栏
- (void)configmentNavagation{
   
    
    
    
}

- (void)configmentMidleView{
    [self configmentSearchView];
}

#pragma mark --跳转到搜索页面
- (void)actionToSearchView:(CSearchBtn *)searchBtn{
    //如果是从全部分类页面跳转过来的那么点击搜索框返回全部分类页面
    if (self.navigationController.topViewController) {
        UIViewController *viewController = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
        if ([viewController isKindOfClass:[HAllClassVC class]]) {
            [self.navigationController popViewControllerAnimated:NO ];
        }else{
            BaseModel *model = [[BaseModel alloc]init];
            model.actionKey = @"HAllClassVC";
            model.keyParamete = @{@"paramete":self.shop_id};
            [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];
        }
    }
    
}

/**设置搜索框*/
-(void)configmentSearchView{
    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    CSearchBtn *searchView = [[CSearchBtn alloc] initWithFrame:CGRectMake(46, statusFrame.size.height + 6, screenW - 46 - 54, 32)];
    [searchView addTarget:self action:@selector(actionToSearchView:) forControlEvents:UIControlEventTouchUpInside];
    searchView.titleStr = @"请输入您想找到的商品";
    self.navigationCustomView = searchView;
    self.search = searchView;
}

#pragma mark -- 分析数据
- (void)analyseDataWith:(ResponseObject *)responseObject{
    NSLog(@"%@, %d ,%@",[self class],__LINE__,responseObject.data);

    //未加载数据的时候的数据源个数
    if (responseObject.status > 0) {
        self.col.mj_footer = self.fRefresh;
        if ([responseObject.data isKindOfClass:[NSArray class]] && ([responseObject.data count] > 0)) {
            for (NSDictionary *dic in responseObject.data) {
                if (![dic[@"items"] isKindOfClass:[NSNull class]]) {
                    if ([self selectWantDataAddDataArrayWithKey:dic[@"key"]]) {
                        for (NSDictionary *itemsDic in dic[@"items"]) {
                            HStoreSubModel *model = [HStoreSubModel mj_objectWithKeyValues:itemsDic];
                            [self.dataArr addObject:model];
                        }

                    }
                }
                
            }
            
        }
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            //不是约定的格式
            AlertInVC(@"数据格式错误")
        }
            
        [self.col.mj_footer endRefreshing];
    }else{
        [self addPromoptView];
        [self.col.mj_footer endRefreshingWithNoMoreData];
    }
    [self.col reloadData];
    
}
/**有选择的挑选数据加入数据源中*/
- (BOOL)selectWantDataAddDataArrayWithKey:(NSString *)key{
    if ([key isEqualToString:@"goods"]) {
        return YES;
    }else if ([key isEqualToString:@"list"]){
        return YES;
    }
    return NO;
}

/**添加提示view*/
- (void)addPromoptView{
    if ((self.dataArr.count == 0) && (self.pageNumber == 1)) {
        self.promoptImg.frame = CGRectMake(0, self.startY + widthOfchangUIBtn, screenW, screenH - self.startY - widthOfchangUIBtn);
    }
    
}


#pragma mark -- 重新连接
- (void)reconnectClick:(UIButton *)sender{
    self.pageNumber = 1;
    [self reconnectClick:^(ResponseObject *responseObject) {
        [self.dataArr removeAllObjects];
        [self removeTheViewWhenConnect];
        [self analyseDataWith:responseObject];
        self.col.contentOffset = CGPointMake(0, 0);
    } failure:^{
        
    }];
    
}
- (void)reconnectClick:(void(^)(ResponseObject *responseObject))success failure:(void(^)())failure{
    
    if ([self.keyParamete[@"keyword"] isEqualToString:@""] && ![self.keyParamete[@"keyword"]isEqualToString:@""]) {
        
        //存在键，但是值是空的请求全部商品地 数据
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            
        }];
        
    }else if ([self.keyParamete objectForKey:@"shangxin"]) {
        [[UserInfo shareUserInfo] gotShopShangXinWithStoreID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *reponseObject) {
            success(reponseObject);

        } failure:^(NSError *error) {
            
        }];
        
    }else if ([self.keyParamete objectForKey:@"classid"]) {
        self.classid = self.keyParamete[@"classid"];
        [[UserInfo shareUserInfo] gotShopGoodsDataWithClassID:self.classid sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseOnject) {
            success(responseOnject);
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        //没有相应的键值，那么请求全部商品的数据
        //没有相应的键值，那么请求全部商品的数据
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"fuck , 内存警告");
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 添加分类的关键词
- (void)configmentCategary{
    NSArray *buttonArray = @[@"推荐",@"销量",@"价格",@"评价"];
    CGFloat width = (screenW - widthOfchangUIBtn)/4.0;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY, screenW - widthOfchangUIBtn, widthOfchangUIBtn)];
    [self.view addSubview:topView];
    topView.layer.borderColor = [[UIColor colorWithHexString:@"999999"] CGColor];
    topView.layer.borderWidth = 0.5;
    for (int i = 0; i < buttonArray.count; i++) {
        ClistTopBtn *button = [[ClistTopBtn alloc] initWithFrame:CGRectMake(i * width, 0, width, topView.frame.size.height) withFont:15 * SCALE WithStr:buttonArray[i]];
        [topView addSubview:button];
        button.tag = i;
        if (i == 0) {
            button.selected = YES;
            self.beforselectButton = button;
        }
        //设置价格按钮的选择图片
        if (i == 2) {
            [button setImage:[UIImage imageNamed:@"icon_array_nor"] forState:UIControlStateNormal];
        }
        button.frame = CGRectMake(i * width, 0, width, topView.frame.size.height);
        button.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:oneLevelUnselectColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:oneLevelSelectColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15 * SCALE];
        [button addTarget:self action:@selector(categary:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.changeBtn.backgroundColor = [UIColor whiteColor];
    
    
}
//设置改变cell样式的按钮
- (ClistChngeUIBtn *)changeBtn{
    if (_changeBtn == nil) {
        UIImage *image = [UIImage imageNamed:@"icon_switch_list"];
        _changeBtn = [[ClistChngeUIBtn alloc] initWithFrame:CGRectMake(screenW - widthOfchangUIBtn , self.startY, widthOfchangUIBtn, widthOfchangUIBtn) withImageSize:image.size];
        [self.view addSubview:_changeBtn];
        [_changeBtn addTarget:self action:@selector(changeUI:) forControlEvents:UIControlEventTouchUpInside];
        [_changeBtn setImage:[UIImage imageNamed:@"icon_switch_window"] forState:UIControlStateNormal];
        [_changeBtn setImage:[UIImage imageNamed:@"icon_switch_list"] forState:UIControlStateSelected];
        _changeBtn.adjustsImageWhenHighlighted = NO;//点击的时候不显示阴影效果
        _changeBtn.layer.borderWidth = 0.5;
        _changeBtn.layer.borderColor = [[UIColor colorWithHexString:@"999999"] CGColor];
        
    }
    return _changeBtn;
}

#pragma mark -- 根据关键词排行

#pragma mrak -- 改变UI样式
- (void)changeUI:(ClistChngeUIBtn *)btn{
    btn.selected = !btn.selected;
    //切换cell的样式。
    if (!btn.selected) {
        _cellID = @"ClistOfGoodsBlockCell";
    }else{
        _cellID = @"CListOfGoodsBarCell";
        
    }
    [self.col reloadData];
    [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    [self.col setContentOffset:CGPointMake(0, 0)];
    
}
- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    return _flowLayout;
}
- (UICollectionView *)col{
    if (_col == nil) {
        _col = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.startY + widthOfchangUIBtn, screenW, screenH - self.startY -widthOfchangUIBtn) collectionViewLayout:self.flowLayout];
        _cellID = @"ClistOfGoodsBlockCell";
        [self.view addSubview:_col];
        _col.delegate = self;
        _col.dataSource = self;
        _col.backgroundColor = BackgroundGray;
        [_col setShowsVerticalScrollIndicator:NO];
    }
    return _col;
}




- (void)categary:(ClistTopBtn *)btn{
    
    if (self.beforselectButton == btn) {
        //是价格按钮的时候进行特殊的处理
        if (btn.tag == 2) {
            self.isLowToHeight = !self.isLowToHeight;
            if (self.isLowToHeight) {
                [btn setImage:[UIImage imageNamed:@"icon_array_rise"] forState:UIControlStateSelected];
                self.sortOrder = classifyAsc;
            }else{
                [btn setImage:[UIImage imageNamed:@"icon_array_drop"] forState:UIControlStateSelected];
                self.sortOrder = classifyDesc;
            }
            self.pageNumber = 1;
            self.sort = btn.tag;
            [self handoverclassification];
        }
        return;
    }
    //如果button被点击的话说明是被选中了
    //排序的时候默认从高到底
    _sortOrder = classifyDesc;
    
    //价格按钮第一被选中的时候默认选择从低到高
    if (btn.tag == 2) {
        [btn setImage:[UIImage imageNamed:@"icon_array_rise"] forState:UIControlStateSelected];
        self.isLowToHeight = YES;
        self.sortOrder = classifyAsc;
    }
    btn.selected = YES;
    self.beforselectButton.selected = NO;
    self.beforselectButton = btn;
    //点击按钮的时候重新加载
    self.pageNumber = 1;
    self.sort = btn.tag;
    self.col.mj_footer.state = MJRefreshStateIdle;
    [self handoverclassification];
    
}
/**切换分类*/
- (void)handoverclassification{
    [self handoverclassification:^(ResponseObject *responseObject) {
        [self.dataArr removeAllObjects];
        [self analyseDataWith:responseObject];
        self.col.contentOffset = CGPointMake(0, 0);
    } failure:^{
        [self showUnconnectView];
    }];
}
- (void)handoverclassification:(void(^)(ResponseObject *responseObject))success failure:(void(^)())failure{
    if ([self.keyParamete[@"keyword"] isEqualToString:@""] && ![self.keyParamete[@"keyword"]isEqualToString:@""]) {
        //存在键，但是值是空的请求全部商品地 数据
        [[UserInfo shareUserInfo] gotShopSearchDataWithShopID:self.shop_id keyword:self.keyParamete[@"keyword"] page:self.pageNumber sort:self.sort sortOrder:self.sortOrder success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure();
        }];
        
    }else if ([self.keyParamete objectForKey:@"shangxin"]) {
        [[UserInfo shareUserInfo] gotShopShangXinWithStoreID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *reponseObject) {
            success(reponseObject);
        } failure:^(NSError *error) {
            failure();
        }];

        
    }else if ([self.keyParamete objectForKey:@"classid"]) {
        self.classid = self.keyParamete[@"classid"];
        [[UserInfo shareUserInfo] gotShopGoodsDataWithClassID:self.classid sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseOnject) {
            success(responseOnject);
        } failure:^(NSError *error) {
            failure();
        }];
        
    }else{
        //没有相应的键值，那么请求全部商品的数据
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure();
        }];
    }

}


#pragma mark -- 上拉加载更多
- (void)loadMoreData{
    self.pageNumber++;
    [self loadMoreData:^(ResponseObject *responseObject) {
        [self analyseDataWith:responseObject];
    } failure:^{
        [self showUnconnectView];
    }];
}




- (void)loadMoreData:(void (^)(ResponseObject *responseObject))success failure:(void (^)())failure{
    if ([self.keyParamete[@"keyword"] isEqualToString:@""] && ![self.keyParamete[@"keyword"]isEqualToString:@""]) {
        //存在键，但是值是空的请求全部商品地 数据
        [[UserInfo shareUserInfo] gotShopSearchDataWithShopID:self.shop_id keyword:self.keyParamete[@"keyword"] page:self.pageNumber sort:self.sort sortOrder:self.sortOrder success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure();
        }];
        
    }else if ([self.keyParamete objectForKey:@"shangxin"]) {
        [[UserInfo shareUserInfo] gotShopShangXinWithStoreID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *reponseObject) {
            success(reponseObject);
        } failure:^(NSError *error) {
            failure();
        }];
        
        
    }else if ([self.keyParamete objectForKey:@"classid"]) {
        self.classid = self.keyParamete[@"classid"];
        [[UserInfo shareUserInfo] gotShopGoodsDataWithClassID:self.classid sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseOnject) {
            success(responseOnject);
        } failure:^(NSError *error) {
            failure();
        }];
        
    }else{
        //没有相应的键值，那么请求全部商品的数据
        [[UserInfo shareUserInfo] gotStoreAllGoodsWithShopID:self.shop_id sort:self.sort sortOrder:self.sortOrder pageNumber:self.pageNumber success:^(ResponseObject *responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure();
        }];
    }
    
    
}
/**网络无法连接的时候显示的view*/
- (void)showUnconnectView{
    [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
}


#pragma mark -- 创建collectionview
- (void)configmentMainUI{
    [self.col registerClass:[ClistOfGoodsBlockCell class] forCellWithReuseIdentifier:@"ClistOfGoodsBlockCell"];
    [self.col registerClass:[CListOfGoodsBarCell class] forCellWithReuseIdentifier:@"CListOfGoodsBarCell"];
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

#pragma mark cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClistOfGoodsModel *model = self.dataArr[indexPath.item];
    
    
    if ([_cellID isEqualToString:@"ClistOfGoodsBlockCell"]) {
        ClistOfGoodsBlockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClistOfGoodsBlockCell" forIndexPath:indexPath];
        cell.clistModel = model;
        
        return cell;
    }else{
        CListOfGoodsBarCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:_cellID forIndexPath:indexPath];
        cell.clistModel = model;
        return cell;
    }
    
    
    return nil;
    
    
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([_cellID isEqualToString:@"ClistOfGoodsBlockCell"]) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([_cellID isEqualToString:@"ClistOfGoodsBlockCell"]) {
        
        //获取cell的宽度和高度
        return 10;
        
    }else{
        
        return 0;
        
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([_cellID isEqualToString:@"ClistOfGoodsBlockCell"]) {
        
        //获取cell的宽度和高度
        return 10;
        
    }else{
        
        return 0;
        
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cellID isEqualToString:@"ClistOfGoodsBlockCell"]) {
        
        //获取cell的宽度和高度
        return CGSizeMake((screenW - 3 * 10)/2.0, 233 * SCALE);
        
    }else{
        
        return CGSizeMake(screenW, 120 * SCALE);
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClistOfGoodsModel *model = self.dataArr[indexPath.item];
    model.actionKey = @"HGoodsVC";
    model.keyParamete = @{@"paramete":model.goodsID};
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:model];

}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
