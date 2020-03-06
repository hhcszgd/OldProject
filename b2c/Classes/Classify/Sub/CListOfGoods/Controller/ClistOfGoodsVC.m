//
//  ClistOfGoodsVC.m
//  b2c
//
//  Created by 0 on 16/4/25.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "ClistOfGoodsVC.h"
#import "CSearchBtn.h"
#import "ClistOfGoodsBlockCell.h"
#import "CListOfGoodsBarCell.h"
#import "ClistOfGoodsModel.h"
#import "ClistTopBtn.h"
#import "ClistChngeUIBtn.h"
#import "ClistRefreshFooter.h"
#define widthOfchangUIBtn 55 * SCALE
@interface ClistOfGoodsVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
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

@end

@implementation ClistOfGoodsVC

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
    //点击价格按钮的时候默认从低到高的排序
    _isLowToHeight = YES;
    _pageNumber = 1;
    _sort = 0;
    //默认从推荐开始
    [[UserInfo shareUserInfo] gotListOfGoodsWithClassID:_classifyID page:_pageNumber sort:_sort sortOrder:classifyAsc success:^(ResponseObject *response) {
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.data) {
                for (NSDictionary *itemsDic in dic[@"items"]) {
                    ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:itemsDic];
                    [self.dataArr addObject:model];
                }
            }
            
        }
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            for (NSDictionary *dic in response.data[@"items"]) {
                ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }
        
        [self.col reloadData];
        
    } failure:^(NSError *error) {
        
        [self showTheViewWhenDisconnectWithFrame:CGRectMake(0, self.startY, screenW, screenH - self.startY)];
        
        
        LOG(@"%@,%d,%@",[self class], __LINE__,error)
    }];
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configmentNavagation];
    [self configmentCategary];
    [self configmentMainUI];
    
    // Do any additional setup after loading the view.
}
- (void)reconnectClick:(UIButton *)sender{
    [[UserInfo shareUserInfo] gotListOfGoodsWithClassID:_classifyID page:_pageNumber sort:_sort sortOrder:classifyAsc success:^(ResponseObject *response) {
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.data) {
                for (NSDictionary *itemsDic in dic[@"items"]) {
                    ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:itemsDic];
                    [self.dataArr addObject:model];
                }
            }
            
        }
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            for (NSDictionary *dic in response.data[@"items"]) {
                ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }
        
        [self.col reloadData];
        
        [self removeTheViewWhenConnect];
        
        
    } failure:^(NSError *error) {
        
        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
        
        
        LOG(@"%@,%d,%@",[self class], __LINE__,error)
    }];
}




#pragma mark -- 设置导航栏
- (void)configmentNavagation{
    self.navigationBarColor = [UIColor colorWithHexString:@"ffffff"];
    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    CSearchBtn *searchView = [[CSearchBtn alloc] initWithFrame:CGRectMake(46, statusFrame.size.height + 6, screenW - 46 - 54, 32)];
    
    [searchView addTarget:self action:@selector(actionToSearchView:) forControlEvents:UIControlEventTouchUpInside];
    searchView.titleStr = @"请输入您想找到的商品";
    self.navigationCustomView = searchView;
    
    //布局消息按钮
    UIImageView *messageImage = [[UIImageView alloc] init];
    messageImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionToMessage:)];
    [messageImage addGestureRecognizer:messageTap];
    messageImage.backgroundColor = [UIColor clearColor];
    messageImage.frame = CGRectMake(0, 0, 19, 44);
    
    messageImage.contentMode = UIViewContentModeScaleAspectFit;
    messageImage.image = [UIImage imageNamed:@"icon_news_gray"];
    self.navigationBarRightActionViews = @[messageImage];
    
    
}
#pragma mark --跳转到搜索页面
- (void)actionToSearchView:(CSearchBtn *)searchBtn{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"搜索")
}
#pragma mark -- 跳转到消息页面
- (void)actionToMessage:(UITapGestureRecognizer *)messageTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"跳转到消息页面")
    
//    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:@"消息中心" action:@"MessageCenterVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
            _beforselectButton = button;
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
    
    
    UIImage *image = [UIImage imageNamed:@"icon_switch_list"];
    
    ClistChngeUIBtn *button  = [[ClistChngeUIBtn alloc] initWithFrame:CGRectMake(buttonArray.count * width , self.startY, widthOfchangUIBtn, widthOfchangUIBtn) withImageSize:image.size];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(changeUI:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"icon_switch_window"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_switch_list"] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor whiteColor];
    button.adjustsImageWhenHighlighted = NO;//点击的时候不显示阴影效果
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [[UIColor colorWithHexString:@"999999"] CGColor];
    
   
    
    
    
}

#pragma mark -- 根据关键词排行
- (void)categary:(ClistTopBtn *)btn{
    if (_beforselectButton == btn) {
        _isLowToHeight = !_isLowToHeight;
        if (btn.tag == 2) {
            if (_isLowToHeight) {
                [btn setImage:[UIImage imageNamed:@"icon_array_rise"] forState:UIControlStateSelected];
                _sortOrder = classifyAsc;
            }else{
                [btn setImage:[UIImage imageNamed:@"icon_array_drop"] forState:UIControlStateSelected];
                _sortOrder = classifyDesc;
            }
            _pageNumber = 1;
            _sort = btn.tag;
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
        _isLowToHeight = YES;
        _sortOrder = classifyAsc;
    }
    
    
    btn.selected = YES;
    _beforselectButton.selected = NO;
    _beforselectButton = btn;
    //点击按钮的时候重新加载
    _pageNumber = 1;
    _sort = btn.tag;
    [self handoverclassification];
    
}
/**切换分类*/
- (void)handoverclassification{
    [self.dataArr removeAllObjects];
    LOG(@"%@,%d,%@",[self class], __LINE__,_sortOrder)
    [[UserInfo shareUserInfo] gotListOfGoodsWithClassID:_classifyID page:_pageNumber sort:_sort sortOrder:_sortOrder success:^(ResponseObject *response) {
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.data) {
                for (NSDictionary *itemsDic in dic[@"items"]) {
                    ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:itemsDic];
                    [self.dataArr addObject:model];
                }
            }
            
        }
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            for (NSDictionary *dic in response.data[@"items"]) {
                ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }
        
        [self.col.mj_footer endRefreshing];
        [self.col reloadData];
        //        [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        [self.col setContentOffset:CGPointMake(0, 0)];
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mrak -- 改变UI样式
- (void)changeUI:(ClistChngeUIBtn *)btn{
    btn.selected = !btn.selected;
    
    if (!btn.selected) {
        
        _cellID = @"ClistOfGoodsBlockCell";
        [self.col reloadData];
        [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        [self.col setContentOffset:CGPointMake(0, 0)];
    }else{
        
        _cellID = @"CListOfGoodsBarCell";
        [self.col reloadData];
        [self.col scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        [self.col setContentOffset:CGPointMake(0, 0)];
    }
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
        ClistRefreshFooter *refreshFooter = [ClistRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
        _col.mj_footer = refreshFooter;
        
        [_col setShowsVerticalScrollIndicator:NO];
    }
    return _col;
}




#pragma mark -- 上拉加载更多
- (void)refreshFooter{
   
    _pageNumber++;
    [[UserInfo shareUserInfo] gotListOfGoodsWithClassID:_classifyID page:_pageNumber sort:_sort sortOrder:classifyAsc success:^(ResponseObject *response) {
        if ([response.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in response.data) {
                for (NSDictionary *itemsDic in dic[@"items"]) {
                    ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:itemsDic];
                    [self.dataArr addObject:model];
                }
            }
            
        }
        if ([response.data isKindOfClass:[NSDictionary class]]) {
            for (NSDictionary *dic in response.data[@"items"]) {
                ClistOfGoodsModel *model = [ClistOfGoodsModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
            }
        }
        [self.col.mj_footer endRefreshing];
        [self.col reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
    
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
    ClistOfGoodsModel *model = self.dataArr[indexPath.row];
    
    
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
    LOG(@"_%@_%d_%@",[self class] , __LINE__,@"TODO")
    
//    [[SkipManager shareSkipManager]skipByVC:self urlStr:nil title:nil action:@"HGoodsVC"];
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
