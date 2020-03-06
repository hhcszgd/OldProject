//
//  HSuperMarketClassifyVC.m
//  b2c
//
//  Created by 0 on 16/6/13.
//  Copyright © 2016年 www.16lao.com. All rights reserved.
//

#import "HSuperMarketClassifyVC.h"
#import "ActionBaseView.h"

#import "ClassifyFirstLevelModel.h"
#import "ClassifyTwoThreelevelModel.h"
#import "MJExtension.h"
#import "COneLevelCell.h"
//#import "ClassifyTableView.h"


#pragma mark -- collecitonview用到的类
#import "ClassifyCHeader.h"
#import "MJExtension.h"
#import "ClassifyFirstLevelModel.h"
#import "CThreeLevelCell.h"
#import "HSearchgoodsListVC.h"
/**行间距*/
#define rowInerval 1
/**列间距*/
#define lineInterval 1


@interface HSuperMarketClassifyVC ()


@property (nonatomic, strong) UITableView *classTable;


@property (nonatomic, strong) NSMutableArray *catelogyList;
@property (nonatomic, strong) ClassifyFirstLevelModel *selectCateModel;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/**取消选中的indexPath*/
@property (nonatomic, strong) NSIndexPath *beforeIndexPath;
@property (nonatomic, weak) ClassifyTwoThreelevelModel *defuletModel;



#pragma mark -- collectionview 中用到的属性
@property (nonatomic, strong) UICollectionView *collectionView;

/**二级分类数组*/
@property (nonatomic, strong) NSMutableArray *detailCategoryList;
/**用来储存数据的数组*/
@property (nonatomic, strong) NSMutableArray *detailOperations;
/**flowLayout*/
@property (nonatomic, strong) UICollectionViewFlowLayout *classflowlayout;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat headerWidth;
@property (nonatomic, strong) NSArray *dataArray;

/**默认的热门推荐*/
@property (nonatomic, copy) NSString *defaultClassID;
/**默认的热门推荐数据*/
@property (nonatomic, strong) NSMutableArray *defaultClassIDArr;

@end

@implementation HSuperMarketClassifyVC
- (NSMutableArray *)defaultClassIDArr{
    if (_defaultClassIDArr == nil) {
        _defaultClassIDArr = [[NSMutableArray alloc] init];
    }
    return _defaultClassIDArr;
}



- (UITableView *)classTable{
    if (_classTable == nil) {
        _classTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, widthmemu * SCALE, self.view.frame.size.height - 64 - 50) style:UITableViewStylePlain];
        [self.view addSubview:_classTable];
        [_classTable registerClass:[COneLevelCell class] forCellReuseIdentifier:@"COneLevelCell"];
        
        // 去除分割线
        _classTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 取消滚动条
        _classTable.showsVerticalScrollIndicator = NO;
        // 允许反弹
        _classTable.bounces = YES;
        _classTable.delegate = self;
        _classTable.dataSource = self;
        
        
        
    }
    return _classTable;
}

#pragma mark -- 重新连接
- (void)reconnectClick:(UIButton *)sender{
    
    [self.catelogyList removeAllObjects];
    
    [[UserInfo shareUserInfo] gotClassifySuccess:^(ResponseObject *response) {
        NSDictionary *oneLevelDic = response.data[0];
        ClassifyFirstLevelModel *firstlevelModel = [ClassifyFirstLevelModel mj_objectWithKeyValues:oneLevelDic];
        [self removeTheViewWhenConnect];
        [self.catelogyList addObjectsFromArray:firstlevelModel.classone];
        for (NSInteger i = 0; i < firstlevelModel.classone.count; i++) {
            ClassifyFirstLevelModel *model = firstlevelModel.classone[i];
            model.isSelected = NO;
        }
        [_classTable reloadData];
        //第一个被选中
        if (self.catelogyList.count == 0) {
            
        }else{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            _selectCateModel = self.catelogyList[0];
            ClassifyFirstLevelModel *firstModel = self.catelogyList[0];
            self.defaultClassID = firstModel.ID;
            //                                [self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self tableView:_classTable didSelectRowAtIndexPath:indexPath];
        }
        
        
        ClassifyTwoThreelevelModel *twoThreeModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:response.data[1]];
        self.defuletModel = twoThreeModel;
        [self.detailOperations removeAllObjects];
        [self.detailOperations addObject:twoThreeModel];
        
        [self.detailCategoryList removeAllObjects];
        [self.detailCategoryList addObjectsFromArray:twoThreeModel.items];
        
        
        
        [self.collectionView reloadData];
        
        
        
        
    } failure:^(NSError *error) {
#pragma mark -- 当网络连接失败的时候
    }];
}



- (NSMutableArray *)catelogyList {
    if (_catelogyList == nil) {
        _catelogyList = [NSMutableArray array];
    }
    
    return _catelogyList;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.catelogyList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54 * SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    COneLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COneLevelCell" forIndexPath:indexPath];
    
    // 设置cell内容
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    
    cell.classLabel.text = model.classify_name;
    
    if (model.isSelected) {
        [cell.classLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:oneLevelSelectColor] backColor:[UIColor colorWithHexString:classifyBackGroundColor] textAligement:1 cornerRadius:0 text:model.classify_name];
        cell.leftView.hidden = NO;
    }else{
        cell.leftView.hidden = YES;
        [cell.classLabel configmentfont:[UIFont systemFontOfSize:14 * SCALE] textColor:[UIColor colorWithHexString:oneLevelUnselectColor] backColor:[UIColor colorWithHexString:oneLevelUnselectBackColor] textAligement:1 cornerRadius:0 text:model.classify_name];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
#pragma mark 取消选中后做什么
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    model.isSelected = NO;
    COneLevelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.leftView.hidden = YES;
    cell.classLabel.backgroundColor = [UIColor colorWithHexString:oneLevelUnselectBackColor];
    cell.classLabel.textColor = [UIColor colorWithHexString:oneLevelUnselectColor];
    
    
}



#pragma mark 点击cell会怎么样
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((_selectedIndexPath.row == 0) && (_selectedIndexPath.length != 0)) {
        [self tableView:tableView didDeselectRowAtIndexPath:_selectedIndexPath];
    }
    _selectedIndexPath = indexPath;
    
    ClassifyFirstLevelModel *model = self.catelogyList[indexPath.row];
    model.isSelected = YES;
    // 滚到顶端
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    COneLevelCell *cell = (COneLevelCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.classLabel.textColor = [UIColor colorWithHexString:oneLevelSelectColor];
    cell.classLabel.backgroundColor = BackgroundGray;
    cell.leftView.hidden = NO;
    __weak typeof(self) Myself = self;
    
    //避免重复刷新
    if ([Myself.selectCateModel.ID isEqualToString:model.ID] == NO) {
        Myself.selectCateModel = model;
        //点击将被选择的model传到collectionview
        [self categaryClick];
        
        
    }
    
    
}







- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

//    self.navigationView.hidden = YES;
    
//    ActionBaseView *navView = [[ActionBaseView alloc] init];
//    [self.view addSubview:navView];
//    navView.frame = CGRectMake(0, 0, screenW, 64);
//    
    //请求数据
    [self requestData];
    [self addCategoryMenuView];
//    
    
    
//    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
//    backButton.adjustsImageWhenHighlighted=NO;
//    self.backButton = backButton;
//    [self.navigationView addSubview:backButton];
//    [backButton addTarget:self action:@selector(navigationBack) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setImage:[UIImage imageNamed:@"header_leftbtn_nor"] forState:UIControlStateNormal];
//    self.naviTitle = @"超市";
    
}

-(void)navigationBack
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[KeyVC shareKeyVC] popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}



/**请求数据*/
- (void)requestData{
    [[UserInfo shareUserInfo] gotSuperMarketClassisysuccess:^(ResponseObject *response) {
        [self analyseDataWithresponse:response];
        [self.classTable reloadData];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [self showTheViewWhenDisconnectWithFrame:self.view.bounds];
    }];
    
    
}
#pragma mark -- 解析数据
- (void)analyseDataWithresponse:(ResponseObject *)response{
    NSDictionary *oneLevelDic = [response.data firstObject];
    ClassifyFirstLevelModel *firstlevelModel = [ClassifyFirstLevelModel mj_objectWithKeyValues:oneLevelDic];
    
    [self.catelogyList addObjectsFromArray:firstlevelModel.classone];
    for (NSInteger i = 0; i < firstlevelModel.classone.count; i++) {
        ClassifyFirstLevelModel *model = firstlevelModel.classone[i];
        model.isSelected = NO;
    }
    
    
    //第一个被选中
    
    if (self.catelogyList.count == 0) {
        
    }else{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        self.selectCateModel = self.catelogyList[0];
        //                                [self selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.classTable didSelectRowAtIndexPath:indexPath];
        
        
    }
    ClassifyTwoThreelevelModel *twoThreeModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:[response.data lastObject]];
    self.defuletModel = twoThreeModel;
    [self.detailOperations removeAllObjects];
    [self.detailOperations addObject:twoThreeModel];
    
    [self.detailCategoryList removeAllObjects];
    [self.detailCategoryList addObjectsFromArray:twoThreeModel.items];
    
}
#pragma mark -- 设置导航栏
- (void)configmentNavagation{
    
    //布局消息按钮
    UIImageView *messageImage = [[UIImageView alloc] init];
    messageImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionToMessage:)];
    [messageImage addGestureRecognizer:messageTap];
    messageImage.frame = CGRectMake(0, 0, 19, 44);
    messageImage.backgroundColor =  [UIColor clearColor];
    messageImage.contentMode = UIViewContentModeScaleAspectFit;
    messageImage.image = [UIImage imageNamed:@"icon_news_gray"];
    self.navigationBarRightActionViews = @[messageImage];
    
}

#pragma mark -- 跳转到消息页面
- (void)actionToMessage:(UITapGestureRecognizer *)messageTap{
    LOG(@"%@,%d,%@",[self class], __LINE__,@"跳转到消息页面")
    
    //    [[SkipManager shareSkipManager] skipByVC:self urlStr:nil title:@"消息中心" action:@"MessageCenterVC"];
}
#pragma mark -- 添加一级分类和二三级分类
- (void)addCategoryMenuView {
    
    self.classTable.backgroundColor = [UIColor clearColor];
    self.collectionView.frame = CGRectMake(widthmemu * SCALE +10, 64, screenW - widthmemu * SCALE-10-10, self.view.frame.size.height - 64 - 50);
    
    
   
    
}
- (UICollectionViewFlowLayout *)classflowlayout{
    if (_classflowlayout == nil) {
        _classflowlayout = [[UICollectionViewFlowLayout alloc] init];
        
    }
    return _classflowlayout;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(widthmemu * SCALE  +10, self.startY, screenW - widthmemu * SCALE - 20, screenH - self.startY - self.tabBarController.tabBar.frame.size.height) collectionViewLayout:self.classflowlayout];
        [self.view addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CThreeLevelCell class] forCellWithReuseIdentifier:@"CThreeLevelCell"];
        [_collectionView registerClass:[ClassifyCHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassifyCHeader"];
        _collectionView.bounces = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        
        
        
    }
    return _collectionView;
}


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
    
    threeLevelModel.actionKey = @"HSearchgoodsListVC";
    threeLevelModel.keyParamete = @{@"paramete":threeLevelModel.classify_name,@"channel_id":@""};
    
    [[SkipManager shareSkipManager] skipByVC:self withActionModel:threeLevelModel];
    

}

- (void)categaryClick{
    
    [self.detailCategoryList removeAllObjects];
    //bool属性，判断存储数组里面有没有对应id的模型
    BOOL isHave = NO;
    
    
    NSInteger ID = [self.selectCateModel.ID integerValue];
    LOG(@"%@,%d,%@",[self class], __LINE__,self.selectCateModel.ID)
    //如果已经存在在数组中就从数组中去，不存在的话就请求
    
    for (NSInteger i = 0; i < self.detailOperations.count; i++) {
        ClassifyTwoThreelevelModel *levelModel = self.detailOperations[i];
        if (levelModel.items.count > 0) {
            ClassifyTwoThreelevelModel *levelTwoModel = levelModel.items[0];
            
            
            if ([levelTwoModel.classify_pid isEqualToString:_selectCateModel.ID]) {
                [self.detailCategoryList removeAllObjects];
                //
                [self.detailCategoryList addObjectsFromArray:levelModel.items];
                [self.collectionView reloadData];
                LOG(@"%@,%d,%@",[self class], __LINE__,@"取数据")
                [self.collectionView setScrollsToTop:YES];
                self.collectionView.contentOffset = CGPointMake(0, 0);
                isHave = YES;
                
            }else{
                if ([self.defaultClassID isEqualToString:_selectCateModel.ID]) {
                    [self.detailCategoryList removeAllObjects];
                    [self.detailCategoryList addObjectsFromArray:self.defuletModel.items];
                    [self.collectionView reloadData];
                    [self.collectionView setScrollsToTop:YES];
                    self.collectionView.contentOffset = CGPointMake(0, 0);
                    isHave = YES;
                }
                
            }
        }
        
    }
    //数组中没有存相关的数据那么就进行请求
    if (!isHave) {
        [[UserInfo shareUserInfo] gotSuperMarketThreeLevelClassisyWithClassID:ID channel_id:@"102" success:^(ResponseObject *response) {
            if (response.data) {
                ClassifyTwoThreelevelModel *levelModel = [ClassifyTwoThreelevelModel mj_objectWithKeyValues:response.data[1]];
                
                //将其放在储存数据的数组中
                [self.detailOperations addObject:levelModel];
                //清空数据源数组
                [self.detailCategoryList removeAllObjects];
                [self.detailCategoryList addObjectsFromArray:levelModel.items];
                [self.collectionView setScrollsToTop:YES];
                self.collectionView.contentOffset = CGPointMake(0, 0);
            }
            [self.collectionView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
    
    
    
    
    
    LOG(@"%@,%d,%@",[self class], __LINE__,[UIDevice currentDevice].identifierForVendor.UUIDString)
    
    
    
    
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
